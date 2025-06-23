from robot.api.deco import keyword
from selenium.webdriver.support.events import AbstractEventListener
import time
import json
import threading
import logging
from typing import Optional, Dict, List, Any, Union
from dataclasses import dataclass

@dataclass
class RequestInfo:
    """Data class to store request information"""
    url: str
    method: str
    headers: Dict[str, str]
    payload: Optional[str]
    status: Optional[int]
    response: Optional[str]
    timestamp: float
    request_id: Optional[str] = None
    error: Optional[str] = None

class NetworkError(Exception):
    """Base exception for network-related errors"""
    pass

class RequestTimeoutError(NetworkError):
    """Exception raised when request times out"""
    pass

class ResponseParsingError(NetworkError):
    """Exception raised when response parsing fails"""
    pass

class FinalNetwork(AbstractEventListener):
    """
    A comprehensive network monitoring and interception class that combines features
    from Network.py, RequestInterceptor.py, and GetResponse.py
    """
    
    def __init__(self):
        """Initialize the network interceptor"""
        self.driver = None
        self._request_map = {}  # Map request IDs to request info
        self._is_listening = False
        self._setup_logging()
        self._js_intercepted_requests = []  # Store requests intercepted by JavaScript
        self._monitor_thread: Optional[threading.Thread] = None

    def _setup_logging(self) -> None:
        """Setup logging configuration"""
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s'
        )
        self.logger = logging.getLogger('RequestInterceptor')

    def _get_webdriver(self, driver) -> Any:
        """Get the actual WebDriver instance from SeleniumLibrary"""
        if hasattr(driver, 'driver'):
            return driver.driver
        return driver

    @keyword("Inject Request Interceptor")
    def inject_request_interceptor(self, driver: Any, api_endpoint: str) -> None:
        """
        Inject JavaScript to intercept and log requests to a specific API endpoint.
        
        Args:
            driver: Selenium WebDriver instance
            api_endpoint: API endpoint to intercept
            
        Raises:
            NetworkError: If injection fails
        """
        self.driver = self._get_webdriver(driver)
        js_code = f"""
        window._requests = [];
        const originalFetch = window.fetch;
        window.fetch = async function(url, options) {{
            if (url.includes('{api_endpoint}')) {{
                const request = {{
                    url: url,
                    method: options && options.method ? options.method : 'GET',
                    payload: options && options.body ? options.body : null,
                    status: null,
                    response: null,
                    timestamp: Date.now()
                }};
                try {{
                    const response = await originalFetch.apply(this, arguments);
                    request.status = response.status;
                    request.response = await response.clone().text();
                    window._requests.push(request);
                    return response;
                }} catch (error) {{
                    request.status = error.status || 0;
                    request.error = error.message;
                    window._requests.push(request);
                    throw error;
                }}
            }}
            return originalFetch.apply(this, arguments);
        }};

        const originalXHR = window.XMLHttpRequest.prototype.send;
        window.XMLHttpRequest.prototype.send = function(body) {{
            if (this._url && this._url.includes('{api_endpoint}')) {{
                const request = {{
                    url: this._url,
                    method: this._method || 'GET',
                    payload: body,
                    status: null,
                    response: null,
                    timestamp: Date.now()
                }};
                this.addEventListener('readystatechange', function() {{
                    if (this.readyState === 4) {{
                        request.status = this.status;
                        request.response = this.responseText;
                        window._requests.push(request);
                    }}
                }});
            }}
            return originalXHR.apply(this, arguments);
        }};

        const originalOpen = window.XMLHttpRequest.prototype.open;
        window.XMLHttpRequest.prototype.open = function(method, url) {{
            this._url = url;
            this._method = method;
            return originalOpen.apply(this, arguments);
        }};
        """
        self.driver.execute_script(js_code)
        self.logger.info(f"JavaScript interceptor injected for endpoint: {api_endpoint}")

    @keyword("Start Network Interception")
    def start_network_interception(self, driver: Any) -> None:
        """
        Start intercepting network requests using CDP.
        
        Args:
            driver: Selenium WebDriver instance
            
        Raises:
            NetworkError: If starting interception fails
        """
        try:
            self.driver = self._get_webdriver(driver)
            self.driver.execute_cdp_cmd('Network.enable', {})
            self.logger.info("Network tracking enabled")

            self._is_listening = True
            self._monitor_thread = threading.Thread(target=self._monitor_network_events)
            self._monitor_thread.daemon = True
            self._monitor_thread.start()

            self.logger.info("Successfully started network monitoring")
        except Exception as e:
            self.logger.error(f"Error starting network interception: {str(e)}")
            raise NetworkError(f"Failed to start network interception: {str(e)}")

    def _get_response_body(self, request_id: str) -> Optional[str]:
        """
        Get response body using CDP.
        
        Args:
            request_id: ID of the request
            
        Returns:
            Response body as string or None if not available
            
        Raises:
            ResponseParsingError: If response body cannot be retrieved
        """
        try:
            response = self.driver.execute_cdp_cmd('Network.getResponseBody', {'requestId': request_id})
            body = response.get('body')
            if body is not None:
                if isinstance(body, str):
                    return body
                return json.dumps(body)
            return None
        except Exception as e:
            self.logger.error(f"Error getting response body for request {request_id}: {str(e)}")
            raise ResponseParsingError(f"Failed to get response body: {str(e)}")

    def _process_performance_logs(self) -> None:
        """Process performance logs to extract network requests"""
        try:
            logs = self.driver.get_log('performance')
            for entry in logs:
                try:
                    log = json.loads(entry['message'])['message']
                    method = log.get('method')
                    params = log.get('params', {})

                    if method == 'Network.requestWillBeSent':
                        request_id = params.get('requestId')
                        request = params.get('request', {})

                        if request_id and request:
                            request_info = {
                                'url': request.get('url', ''),
                                'method': request.get('method', ''),
                                'headers': request.get('headers', {}),
                                'postData': request.get('postData'),
                                'timestamp': time.time(),
                                'type': 'request',
                                'requestId': request_id
                            }
                            self._request_map[request_id] = request_info
                            self.logger.info(f"Request intercepted: {request_info['method']} {request_info['url']}")

                    elif method == 'Network.responseReceived':
                        request_id = params.get('requestId')
                        response = params.get('response', {})

                        if request_id and request_id in self._request_map:
                            request_info = self._request_map[request_id]
                            request_info.update({
                                'status': response.get('status'),
                                'responseTimestamp': time.time()
                            })

                            # Get response body for successful responses
                            if response.get('status') in [200, 201]:
                                body = self._get_response_body(request_id)
                                if body:
                                    try:
                                        if isinstance(body, str):
                                            parsed = json.loads(body)
                                            request_info['response'] = json.dumps(parsed)
                                        else:
                                            request_info['response'] = json.dumps(body)
                                        self.logger.info(f"Response body captured for {request_info['url']}")
                                    except json.JSONDecodeError as e:
                                        self.logger.error(f"Invalid JSON in response: {str(e)}")
                                        request_info['response'] = str(body)
                                else:
                                    self.logger.warning(f"Could not get response body for {request_info['url']}")

                            self.logger.info(f"Response received: {response.get('status')} {response.get('url')}")

                except Exception as e:
                    self.logger.error(f"Error processing log entry: {str(e)}")
                    continue

        except Exception as e:
            self.logger.error(f"Error getting performance logs: {str(e)}")

    def _monitor_network_events(self) -> None:
        """Monitor network events in a separate thread"""
        while self._is_listening:
            try:
                self._process_performance_logs()
                js_requests = self.driver.execute_script("return window._requests;")
                if js_requests:
                    self._js_intercepted_requests.extend(js_requests)
                    self.driver.execute_script("window._requests = [];")
                time.sleep(0.1)  # Use same sleep time as GetResponse
            except Exception as e:
                self.logger.error(f"Error in network monitoring: {str(e)}")
                time.sleep(0.1)

    @keyword("Get Intercepted Requests")
    def get_intercepted_requests(self, driver, endpoint=None, method=None, timeout=10):
        """Get intercepted requests matching the given criteria."""
        start_time = time.time()
        matching_requests = []

        while time.time() - start_time < timeout:
            # Get JavaScript intercepted requests first
            js_requests = self.driver.execute_script("return window._requests;")
            if js_requests:
                for request in js_requests:
                    if endpoint and endpoint not in request.get('url', ''):
                        continue
                    if method and method.upper() != request.get('method', '').upper():
                        continue
                    if request.get('status') and request.get('response'):
                        matching_requests.append(request)
                self.driver.execute_script("window._requests = [];")

            # Then get CDP intercepted requests
            for request_id, request_info in self._request_map.items():
                if endpoint and endpoint not in request_info.get('url', ''):
                    continue
                if method and method.upper() != request_info.get('method', '').upper():
                    continue
                if 'status' in request_info and 'response' in request_info:
                    matching_requests.append(request_info)

            if matching_requests:
                break

            time.sleep(0.1)

        self.logger.info(f"Found {len(matching_requests)} matching requests")
        return matching_requests

    @keyword("Wait For Request")
    def wait_for_request(self, driver, endpoint, method=None, timeout=10):
        """Wait for a specific request to be intercepted."""
        requests = self.get_intercepted_requests(driver, endpoint, method, timeout)
        if not requests:
            self.logger.warning(f"No request found for endpoint: {endpoint}")
            return None
        return requests[0]

    @keyword("Clear Intercepted Requests")
    def clear_intercepted_requests(self, driver: Any) -> None:
        """Clear all intercepted requests"""
        self._request_map.clear()
        self._js_intercepted_requests.clear()
        self.driver.execute_script("window._requests = [];")
        self.logger.info("Cleared all intercepted requests")

    @keyword("Stop Network Interception")
    def stop_network_interception(self, driver: Any) -> None:
        """Stop network interception and cleanup"""
        try:
            if self._is_listening:
                self._is_listening = False
                if hasattr(self, '_monitor_thread'):
                    self._monitor_thread.join(timeout=1)

                # Disable network tracking
                self.driver.execute_cdp_cmd('Network.disable', {})
                self.clear_intercepted_requests(driver)
                self.logger.info("Network interception stopped")
        except Exception as e:
            self.logger.error(f"Error stopping network interception: {str(e)}")
        finally:
            self._request_map.clear()
            self._js_intercepted_requests.clear()
            self.driver.execute_script("window._requests = [];")

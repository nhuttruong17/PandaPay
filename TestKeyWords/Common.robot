*** Settings ***
Library     SeleniumLibrary
Resource    ../TestData/Browser/Global.robot
Library     ../LibPy/FinalNetwork.py    WITH NAME    Network
# Library     ../../../LibPy/FinalNetwork.py    WITH NAME    Network
Library     AppiumLibrary
Library     OperatingSystem

*** Keywords ***
Basic Setup
#new#
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${logging_prefs}=    Create Dictionary    performance=ALL
    Call Method    ${options}    set_capability    goog:loggingPrefs    ${logging_prefs}
#    Call Method    ${options}    add_argument     --headless
#    Call Method    ${options}    add_argument    --start-maximized
#    Call Method    ${options}    add_argument    --incognito
#    Call Method    ${options}    add_argument    --disable-popup-blocking
#    RETURN    ${options}
    Open Browser    ${BASE_URL}    ${CHROME_BROWSER}    options=${options}
#    Maximize Browser Window
#    Set Window Size    1920    1080
#new#

Basic TearDowns
    Sleep    3
    Close Browser

#API  Request#
API Request
    [Arguments]     ${Method}    ${API_URL}    ${Payload}    ${Expected_Status_Code}
    ${response}=    Run Keyword   ${Method}    url=${API_URL}   json=${Payload}       expected_status=${Expected_Status_Code}
    RETURN  ${response}

API Request With Params
    [Arguments]     ${Method}   ${API_URL}    ${params}    ${Expected_Status_Code}
    ${response}=    Run Keyword   ${Method}  url=${API_URL}    params=${params}    expected_status=${Expected_Status_Code}
    RETURN          ${response}
#API  Request#
##Fill Text Input WEB ##
Fill Text Input
    [Arguments]    ${elm_input}    ${text}
    SeleniumLibrary.Wait Until Element Is Visible    ${elm_input}    10s
    SeleniumLibrary.Input Text    ${elm_input}    ${text}
##Click on element WEB ##
Click on Element
    [Arguments]    ${elm_input}
    SeleniumLibrary.Wait Until Element Is Visible    ${elm_input}    10s
    SeleniumLibrary.Click Element    ${elm_input}
##Check Validation Text ##
Check validation error message
    [Arguments]    ${Elm_message}      ${Expected_message}
    SeleniumLibrary.Wait Until Element Is Visible    ${Elm_message}      15s
    ${error_message_invalid} =    SeleniumLibrary.Get Text    ${Elm_message}
    Should Be Equal As Strings    ${error_message_invalid}     ${Expected_message}    Validation text successfully -> Expected: '${Expected_message}', Observed: '${error_message_invalid}'
    Set Test Message    validation error message with '${error_message_invalid}'
##Check Validation Text ##
Generate Secure Password
    ${uppercase}=    Evaluate    random.choice(string.ascii_uppercase)    modules=random,string
    ${lowercase}=    Evaluate    random.choice(string.ascii_lowercase)    modules=random,string
    ${digit}=        Evaluate    random.choice(string.digits)             modules=random,string
    ${special}=      Evaluate    random.choice("!@#$%^&*")              modules=random
    ${remaining}=    Evaluate    ''.join(random.choices(string.ascii_letters + string.digits + "!@#$%^&*", k=5))    modules=random,string
    ${password}=     Set Variable    ${uppercase}${lowercase}${digit}${special}${remaining}
    ${shuffled}=     Evaluate    ''.join(random.sample(list('${password}'), len('${password}')))    modules=random
    RETURN    ${shuffled}
##Request Payload###

## Scroll helpers ##
Scroll Page By Pixels
    [Arguments]    ${x}=0    ${y}=500
    [Documentation]    Scroll the page by the given x/y pixels. Default scrolls down 500px.
    SeleniumLibrary.Execute JavaScript    window.scrollBy(Number(arguments[0]), Number(arguments[1]));    ${x}    ${y}

Scroll To Bottom
    [Arguments]
    [Documentation]    Scroll to the bottom of the page.
    SeleniumLibrary.Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);

Scroll Element Into View
    [Arguments]    ${locator}
    [Documentation]    Scroll the element located by ${locator} into view using element.scrollIntoView().
    ${elem}=    SeleniumLibrary.Get WebElement    ${locator}
    SeleniumLibrary.Execute JavaScript    arguments[0].scrollIntoView({behavior: 'auto', block: 'center', inline: 'nearest'});    ${elem}

Prepare For Request Interception
    [Arguments]    ${endpoint}
    ${driver}=    Get Library Instance    SeleniumLibrary
    Network.Inject Request Interceptor    ${driver.driver}    ${endpoint}
    RETURN    ${driver}

Get Request API
    [Arguments]    ${driver}
    ${requests}=    Network.Get Intercepted Requests    ${driver.driver}
    Run Keyword Unless    ${requests}    Fail    No intercepted requests found.
    ${status}=    Set Variable    ${requests[0]['status']}
    ${url}=       Set Variable    ${requests[0]['url']}
    ${payload}=   Set Variable    ${requests[0]['payload']}
    ${body}=      Set Variable    ${requests[0]['response']}
    &{result}=    Create Dictionary    status=${status}    body=${body}     payload=${payload}      url=${url}
    RETURN    ${result}

Parse Response API
    [Arguments]    ${body}
    ${response_json}=    Evaluate    json.loads('''${body}''')    json
    ${success}=          Set Variable    ${response_json['success']}
    ${statusCode}=       Set Variable    ${response_json['statusCode']}
    ${message}=          Set Variable    ${response_json['message']}
    ${data}=             Set Variable    ${response_json['data']}
    &{parsed}=           Create Dictionary    success=${success}    statusCode=${statusCode}  message=${message}    data=${data}
    RETURN    &{parsed}
##Request Payload###



##Mobile
Basic Setup iOS
    Open Application    ${APPIUM_SERVER_URL}    platformName=${PLATFORM_NAME}   appium:automationName=${AUTOMATION_NAME}    appium:udid=${UDID}     appium:bundleId=${BUNDLE_ID}
Basic TearDowns iOS
    Sleep    3
    Close Application
##Fill Text Input mobile ##
Fill Text Input mobile
    [Arguments]    ${elm_input}    ${text}
    AppiumLibrary.Wait Until Element Is Visible    ${elm_input}    10s
    AppiumLibrary.Input Text    ${elm_input}    ${text}

Click on Element mobile
    [Arguments]    ${elm_input}
    AppiumLibrary.Wait Until Element Is Visible    ${elm_input}    10s
    AppiumLibrary.Click Element    ${elm_input}

Check validation error message mobile
    [Arguments]    ${Elm_message}      ${Expected_message}
    AppiumLibrary.Wait Until Element Is Visible    ${Elm_message}      15s
    ${error_message_invalid} =    AppiumLibrary.Get Text    ${Elm_message}
    Should Be Equal As Strings    ${error_message_invalid}     ${Expected_message}    Validation text successfully -> Expected: '${Expected_message}', Observed: '${error_message_invalid}'
    Set Test Message   validation error message with '${error_message_invalid}'
##Mobile IOS


*** Variables ***
#Method#
${Method_POST}    POST
${Method_GET}    GET
${Method_PUT}    PUT
${Method_DELETE}    DELETE
#Method#

#Status Code API#
${Status_200}    200
${Status_201}    201
${Status_202}    202
${Status_401}    401
${Status_400}    400

#Boolean API#
${Boolean_True}    True
${Boolean_False}    False



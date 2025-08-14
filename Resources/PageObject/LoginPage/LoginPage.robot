*** Settings ***
Resource    ../../Locators/LoginLocators.robot
Resource    ../../Locators/HomeLocators.robot
Resource    ../../../TestData/LoginData/LoginData.robot
Resource    ../../../TestKeyWords/Common.robot
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Library    BuiltIn
Library    ../../../LibPy/FinalNetwork.py    WITH NAME    Network

*** Keywords ***
#Function Check payload account inactive
Click on Sign In with Wait Request Payload account Inactive
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    ${SIGNIN_API}
    SeleniumLibrary.Wait Until Element Is Visible   ${btn_SignIn}     5s
    Click on Element    ${btn_SignIn}
    Sleep    2s
    #Get Sign In Request
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_401}
    #Verify request payload
    ${request_payload}=    Evaluate    json.loads('''${result.payload}''')    json
    Should Be Equal As Strings    ${request_payload['user_code']}    ${Valid_UserID_inactive}
    Should Be Equal As Strings    ${request_payload['password']}    ${Valid_Password_inactive}
    Should Be Equal As Strings    ${request_payload['type']}    ${Type}
    #Verify response
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_False}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_401}
    Should Be Equal As Strings    ${parsed.message}    ${EXPECTED_ERROR_MESSAGE_SignIn_Payload}
    Should Be Equal As Strings    ${parsed.data.code}    ${EXPECTED_ERROR_MESSAGE_API_inactive}

##Check function UI ##
#Function Check payload login failed
Click on SignIn with Wait Request Payload login Failed
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    ${SIGNIN_API}
    SeleniumLibrary.Wait Until Element Is Visible   ${btn_SignIn}     5s
    Click on Element    ${btn_SignIn}
    Sleep    2s
    #Get Sign In Request
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_401}
    #Verify request payload
    ${request_payload}=    Evaluate    json.loads('''${result.payload}''')    json
    Should Be Equal As Strings    ${request_payload['user_code']}    ${Valid_UserID}
    Should Be Equal As Strings    ${request_payload['password']}    ${Invalid_Password}
    Should Be Equal As Strings    ${request_payload['type']}    ${Type}
    #Verify response
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_False}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_401}
    Should Be Equal As Strings    ${parsed.message}    ${EXPECTED_ERROR_MESSAGE_SignIn_Payload}
    Should Be Equal As Strings    ${parsed.data.code}    ${EXPECTED_ERROR_MESSAGE_API}

#Function check response login successfully
Click on SignIn with Wait Response login successfully
    ${driver}=    Get Library Instance    SeleniumLibrary
    Click on Element    ${btn_SignIn}
    Network.Start Network Interception    ${driver.driver}
    # Clear any existing requests
    Network.Clear Intercepted Requests    ${driver.driver}
    # Wait for profile request
    ${profile_request}=    Network.Wait For Request    ${driver.driver}    ${Profile_API}    GET    10
    # Parse and verify profile data
    ${response}=    Set Variable    ${profile_request['response']}
    ${parsed_data}=    Parse Response API    ${response}
    Should Be Equal As Strings    ${parsed_data['data']['user_id']}    ${Valid_UserID}
    Network.Stop Network Interception    ${driver.driver}

#Function check response logout successfully
Click on Logout
    ${driver}=    Get Library Instance    SeleniumLibrary
    Network.Start Network Interception    ${driver.driver}
    # Clear any existing requests
    Network.Clear Intercepted Requests    ${driver.driver}
    Click on Element    ${elm_UserAvatar}
    Click on Element    ${btn_Logout}
    # Wait for profile request
    ${signout_request}=    Network.Wait For Request    ${driver.driver}    ${SIGNOUT_API}    POST    10
    # Parse and verify profile data
    ${response}=    Set Variable    ${signout_request['response']}
    ${parsed_data}=    Parse Response API    ${response}
    Should Be Equal As Strings    ${parsed_data['message']}    ${Expected_message_Signout}
    Network.Stop Network Interception    ${driver.driver}
    Sleep    3s
    Check validation error message    ${elm_Logout}    ${EXPECTED_SUCCESS_LOGOUT}

##Check API ##
#Function check login successfully with api
Check Loggin successfully with API
    ${response}=    API Request   ${Method_POST}   ${API_URL_SignIn}   ${PAYLOAD_SUCCESS}   ${Status_201}
    ${json}=    Evaluate    json.loads('''${response.content}''')    modules=json
    ${message}=    Get From Dictionary    ${json}    message
    Should Be Equal As Strings   ${message}    ${EXPECTED_SUCCESS_MESSAGE_API}
#Function check login failed with api
Check Login unsuccessfully with API
    ${response}=   API Request   ${Method_POST}   ${API_URL_SignIn}   ${PAYLOAD}   ${Status_401}
    ${json}=    Evaluate    json.loads('''${response.content}''')    modules=json
    ${error_code}=    Get From Dictionary    ${json['data']}    code
    Should Be Equal As Strings    ${error_code}    ${EXPECTED_ERROR_MESSAGE_API}
#Function check error message account inactive with api
Check Login account inactive with API
    ${response}=   API Request   ${Method_POST}   ${API_URL_SignIn}   ${PAYLOAD_UserInactive}   ${Status_401}
    ${json}=    Evaluate    json.loads('''${response.content}''')    modules=json
    ${error_code}=    Get From Dictionary    ${json['data']}    code
    Should Be Equal As Strings    ${error_code}    ${EXPECTED_ERROR_MESSAGE_API_inactive}



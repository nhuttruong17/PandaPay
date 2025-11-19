*** Settings ***
Documentation    Page Object for Reset & Send Password functionality
Resource    ../../../TestData/Browser/Global.robot
Resource    ../../../TestKeyWords/Common.robot
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${Radio_Email}                      xpath=//label[@for='r1']
${Radio_PhoneNumber}                xpath=//label[@for='r2']
${RESETPASSWORD_USER_BUTTON}        xpath=//p[normalize-space()='Reset Password']
${ResetPassword_EndPoint}           api/admin/reset-password/
${Confirm_Button}                   xpath=//button[normalize-space()='Confirm']

*** Keywords ***
Click Submit button and wait for response Send Reset Password to Email
    ${url}=    SeleniumLibrary.Get Location
    Log    ${url}
    ${id}=    Evaluate    re.search(r'/detail/(\\d+)', """${url}""").group(1)    re
    Log    ${id}
    ${driver}=    Get Library Instance    SeleniumLibrary
    Click on Element    ${Confirm_Button}
    Network.Start Network Interception    ${driver.driver}
    Network.Clear Intercepted Requests    ${driver.driver}
    #Get Request
    ${profile_request}=    Network.Wait For Request    ${driver.driver}    ${ResetPassword_EndPoint}${id}    ${Method_PUT}    timeout=10    
    Log    ${profile_request}
    Log    ${profile_request["postData"]}
    ${TypeEmail}=    Set Variable    ${profile_request["postData"]}
    ${postDataDict}=    Evaluate    json.loads('''${profile_request["postData"]}''')    json
    Log    ${postDataDict["notify_type"]}
    Should Be Equal As Strings     ${postDataDict["notify_type"]}     EMAIL
    #Get Response
    ${response}=    Set Variable    ${profile_request['response']}
    Log    ${response}
    ${parsed}=    Parse Response API    ${response}
    Log    ${parsed}
    Should Be Equal As Strings     ${parsed.success}        ${Boolean_True}
    Should Be Equal As Integers    ${parsed.statusCode}     ${Status_202}
    Should Be Equal As Strings     ${parsed.message}        Reset password user sucessfully
    Network.Stop Network Interception    ${driver.driver}

Click Submit button and wait for response Send Reset Password to Phone Number
    ${url}=    SeleniumLibrary.Get Location
    Log    ${url}
    ${id}=    Evaluate    re.search(r'/detail/(\\d+)', """${url}""").group(1)    re
    Log    ${id}
    ${driver}=    Get Library Instance    SeleniumLibrary
    Click on Element    ${Confirm_Button}
    Network.Start Network Interception    ${driver.driver}
    Network.Clear Intercepted Requests    ${driver.driver}
    #Get Request
    ${profile_request}=    Network.Wait For Request    ${driver.driver}    ${ResetPassword_EndPoint}${id}    ${Method_PUT}    timeout=10    
    Log    ${profile_request}
    Log    ${profile_request["postData"]}
    ${TypeEmail}=    Set Variable    ${profile_request["postData"]}
    ${postDataDict}=    Evaluate    json.loads('''${profile_request["postData"]}''')    json
    Log    ${postDataDict["notify_type"]}
    Should Be Equal As Strings     ${postDataDict["notify_type"]}     PHONE_NUMBER
    #Get Response
    ${response}=    Set Variable    ${profile_request['response']}
    Log    ${response}
    ${parsed}=    Parse Response API    ${response}
    Log    ${parsed}
    Should Be Equal As Strings     ${parsed.success}        ${Boolean_True}
    Should Be Equal As Integers    ${parsed.statusCode}     ${Status_202}
    Should Be Equal As Strings     ${parsed.message}        Reset password user sucessfully
    Network.Stop Network Interception    ${driver.driver}
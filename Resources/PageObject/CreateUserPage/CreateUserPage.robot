*** Settings ***
Documentation    Page Object for Create User functionality
Resource    ../../../TestData/Browser/Global.robot
Resource    ../../../TestKeyWords/Common.robot
Library    SeleniumLibrary

*** Variables ***
${USER_ID_INPUT}    //*[@name="user_id"]
${FIRST_NAME_INPUT}    //input[@id='first_name ']
${LAST_NAME_INPUT}    //input[@id='last_name ']
${EMAIL_INPUT}    //input[@id='email ']
${PHONE_INPUT}    //input[@placeholder='Enter phone number']
${DOB_INPUT}    //input[@placeholder='Enter date of birth']
${ADDRESS_INPUT}    //input[@placeholder='Enter address']
${USER_ROLE_SELECT}    //button[.//span[text()='Select user role']]
${PASSWORD_INPUT}    //input[@name='password']
${CONFIRM_PASSWORD_INPUT}    //input[@name='confirm_password']
${ACCOUNT_STATUS_TOGGLE}    id=account-status
${LANGUAGE_RADIO_ENGLISH}    xpath=//input[@name='language' and @value='English']
${LANGUAGE_RADIO_FRENCH}    xpath=//input[@name='language' and @value='French']
${LANGUAGE_RADIO_SPANISH}    xpath=//input[@name='language' and @value='Spanish']
${ORGANIZATION_SELECT}    id=organization\
${CREATE_USER_BUTTON}    xpath=//button[normalize-space()='Create New User']
${Tab_USER_BUTTON}    xpath=//button[normalize-space()='User']
${CREATE_USER_SUBMIT}    xpath=//button[@type="submit"]

${Create_User_API}    api/admin/user/

${UserID_exist}    School1190

${VALID_New_USER_ID}    Kids_User_01
${VALID_FIRST_NAME}    John
${VALID_LAST_NAME}    Doe
${VALID_EMAIL}    john@yopmail.com
${VALID_PHONE}    9998887777
${VALID_DOB}    11-10-2025
${VALID_ADDRESS}    123 Test Street
${VALID_New_User_PASSWORD}    Test@123
${VALID_CONFIRM_PASSWORD}    Test@123

${Valid_UserID}    SchoolLe
${Valid_Password}    School123@
*** Keywords ***
Go To Create User Page
    SeleniumLibrary.Wait Until Element Is Visible    ${CREATE_USER_BUTTON}    10s
    SeleniumLibrary.Page Should Contain Element    ${USER_ID_INPUT}

Input User ID
    [Arguments]    ${user_id}
    Fill Text Input    ${USER_ID_INPUT}    ${user_id}

Input First Name
    [Arguments]    ${first_name}
    Fill Text Input    ${FIRST_NAME_INPUT}    ${first_name}

Input Last Name
    [Arguments]    ${last_name}
    Fill Text Input    ${LAST_NAME_INPUT}    ${last_name}

Input Email
    [Arguments]    ${email}
    Fill Text Input    ${EMAIL_INPUT}    ${email}

Input Phone Number
    [Arguments]    ${phone}
    Fill Text Input    ${PHONE_INPUT}    ${phone}

Input Date Of Birth
    [Arguments]    ${dob}
    Fill Text Input    ${DOB_INPUT}    ${dob}

Input Address
    [Arguments]    ${address}
    Fill Text Input    ${ADDRESS_INPUT}    ${address}

Select User Role
    # SeleniumLibrary.Wait Until Element Is Visible    ${USER_ROLE_SELECT}    10s
    # Click on Element    ${USER_ROLE_SELECT}
    # Select From List By Label    xpath=//select[@aria-hidden='true']    Staff
    Click on Element    xpath=//select[@aria-hidden='true']/option[@value='8']
    # SeleniumLibrary.Get Element Attribute    //option[contains(@value,'8')]    value
    # Sleep    2s
    # SeleniumLibrary.Select From List By Label    ${USER_ROLE_SELECT}    ${role}
    # SeleniumLibrary.Select From List By Value    //div[@id=':rh:-form-item']//select[contains(@aria-hidden,'true')]    ${role}
Input Password Web
    [Arguments]    ${password}
    Fill Text Input    ${PASSWORD_INPUT}    ${password}

Input Confirm Password
    [Arguments]    ${password}
    Fill Text Input    ${CONFIRM_PASSWORD_INPUT}    ${password}

Set Account Status
    [Arguments]    ${status}
    ${current_status}=    SeleniumLibrary.Get Element Attribute    ${ACCOUNT_STATUS_TOGGLE}    checked
    Run Keyword If    '${status}' == 'Active' and '${current_status}' != 'true'    Click on Element    ${ACCOUNT_STATUS_TOGGLE}
    Run Keyword If    '${status}' == 'Inactive' and '${current_status}' == 'true'    Click on Element    ${ACCOUNT_STATUS_TOGGLE}

Select Language
    [Arguments]    ${language}
    Run Keyword If    '${language}' == 'English'    Click on Element    ${LANGUAGE_RADIO_ENGLISH}
    Run Keyword If    '${language}' == 'French'    Click on Element    ${LANGUAGE_RADIO_FRENCH}
    Run Keyword If    '${language}' == 'Spanish'    Click on Element    ${LANGUAGE_RADIO_SPANISH}

Select Organization
    [Arguments]    ${organization}
    Click on Element    ${ORGANIZATION_SELECT}
    SeleniumLibrary.Select From List By Label    ${ORGANIZATION_SELECT}    ${organization}

Click Submit button and wait for response Existing UserID
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    ${Create_User_API}
    Click on Element    xpath=/html/body/div[1]/div/main/div/div/form/button
    Sleep    2s
    #Get Sign In Request
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_400}
    #Verify request payload
    ${request_payload}=    Evaluate    json.loads('''${result.payload}''')    json
    Should Be Equal As Strings    ${request_payload['user_id']}    ${UserID_exist}
    Log    ${request_payload}
    #Verify response
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_False}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_400}
    Should Be Equal As Strings    ${parsed.message}    INVALID_INPUT
    Should Contain    ${parsed.data.user_id}    VAL546
    Log    ${parsed}

Click Submit button and wait for response Existing Email
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    ${Create_User_API}
    Click on Element    xpath=/html/body/div[1]/div/main/div/div/form/button
    Sleep    2s
    #Get Sign In Request
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_400}
    #Verify request payload
    ${request_payload}=    Evaluate    json.loads('''${result.payload}''')    json
    Log    ${request_payload}
    #Verify response
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_False}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_400}
    Should Be Equal As Strings    ${parsed.message}    INVALID_INPUT
    Should Contain    ${parsed.data.email}    VAL116
    Log    ${parsed}

Click Submit button and wait for response Existing Phone Number
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    ${Create_User_API}
    Click on Element    xpath=/html/body/div[1]/div/main/div/div/form/button
    Sleep    2s
    #Get Sign In Request
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_400}
    #Verify request payload
    ${request_payload}=    Evaluate    json.loads('''${result.payload}''')    json
    Log    ${request_payload}
    #Verify response
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_False}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_400}
    Should Be Equal As Strings    ${parsed.message}    INVALID_INPUT
    Should Contain    ${parsed.data.phone_number}    VAL117
    Log    ${parsed}

Click Submit button and wait for response create user successfully
    ${driver}=    Get Library Instance    SeleniumLibrary
    Click on Element    xpath=/html/body/div[1]/div/main/div/div/form/button
    Network.Start Network Interception    ${driver.driver}
    # Clear any existing requests
    Network.Clear Intercepted Requests    ${driver.driver}
    # Wait for profile request
    ${profile_request}=    Network.Wait For Request    ${driver.driver}    ${Create_User_API}    POST    10
    Log    ${profile_request}
    # Parse and verify profile data
    ${response}=    Set Variable    ${profile_request['response']}
    Log    ${response}
    ${parsed}=    Parse Response API    ${response}
    Log    ${parsed}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_True}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_201}
    Should Be Equal As Strings    ${parsed.message}    CREATE_SUCCESS
    Network.Stop Network Interception    ${driver.driver}


    


##Session persistence: save/restore cookies and localStorage to skip login on next browser open ##
Save Browser Session
    [Arguments]    ${session_dir}=.session
    Create Directory    ${session_dir}
    ${sl}=    Get Library Instance    SeleniumLibrary
    ${cookies}=    Call Method    ${sl.driver}    get_cookies
    ${cookies_json}=    Evaluate    json.dumps(${cookies})    modules=json
    Create File    ${session_dir}/cookies.json    ${cookies_json}    encoding=utf-8
    ${local}=    SeleniumLibrary.Execute JavaScript    return JSON.stringify(window.localStorage)
    Create File    ${session_dir}/localStorage.json    ${local}    encoding=utf-8

Restore Browser Session
    [Arguments]    ${session_dir}=.session
    ${cookies_file}=    Set Variable    ${session_dir}/cookies.json
    ${local_file}=      Set Variable    ${session_dir}/localStorage.json
    ${cookies_exist}=    Run Keyword And Return Status    File Should Exist    ${cookies_file}
    IF    ${cookies_exist}
        ${sl}=    Get Library Instance    SeleniumLibrary
        ${cookies_json}=    Get File    ${cookies_file}
        ${cookies}=    Evaluate    json.loads('''${cookies_json}''')    modules=json
        FOR    ${cookie}    IN    @{cookies}
            Call Method    ${sl.driver}    add_cookie    ${cookie}
        END
    END
    ${local_exist}=    Run Keyword And Return Status    File Should Exist    ${local_file}
    IF    ${local_exist}
        ${local_json}=    Get File    ${local_file}
    ${status}    ${dummy}=    Run Keyword And Ignore Error    Evaluate    json.loads('''${local_json}''')    json
    Run Keyword If    '${status}' == 'PASS'    SeleniumLibrary.Execute JavaScript    try{ var items = JSON.parse(arguments[0]); for(var k in items){ localStorage.setItem(k, items[k]); } }catch(e){ console.warn('localStorage restore skipped, invalid JSON'); }    ${local_json}
    Run Keyword If    '${status}' != 'PASS'    Log    Local storage JSON invalid or empty, skipping restoration    WARN
    Run Keyword If    '${status}' == 'PASS'    Reload Page
    END
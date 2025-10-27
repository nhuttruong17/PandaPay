*** Settings ***
Documentation    Page Object for Create User functionality
Resource    ../../../TestData/Browser/Global.robot
Resource    ../../../TestKeyWords/Common.robot
Library    SeleniumLibrary

*** Variables ***
${USER_ID_INPUT}             //*[@name="user_id"]
${FIRST_NAME_INPUT}          //input[@id='first_name ']
${LAST_NAME_INPUT}           //input[@id='last_name ']
${EMAIL_INPUT}               //input[@id='email ']
${PHONE_INPUT}               //input[@placeholder='Enter phone number']
${DOB_INPUT}                 //input[@placeholder='Enter date of birth']
${ADDRESS_INPUT}             //input[@placeholder='Enter address']
${USER_ROLE_SELECT}          //button[.//span[text()='Select user role']]
${PASSWORD_INPUT}            //input[@name='password']
${CONFIRM_PASSWORD_INPUT}    //input[@name='confirm_password']
${ACCOUNT_STATUS_TOGGLE}     id=account-status
${LANGUAGE_RADIO_ENGLISH}    xpath=//input[@name='language' and @value='English']
${LANGUAGE_RADIO_FRENCH}     xpath=//input[@name='language' and @value='French']
${LANGUAGE_RADIO_SPANISH}    xpath=//input[@name='language' and @value='Spanish']
${ORGANIZATION_SELECT}       id=organization\
${CREATE_USER_BUTTON}        xpath=//button[normalize-space()='Create New User']
${Tab_USER_BUTTON}           xpath=//button[normalize-space()='User']
# ${CREATE_USER_SUBMIT}        xpath=//button[@type="submit"]
${CREATE_USER_SUBMIT}        xpath=/html/body/div[1]/div/main/div/div/form/button
${Create_User_API}           api/admin/user/

${UserID_exist}         School1190

${VALID_New_USER_ID}    Kids_User_01
${VALID_FIRST_NAME}     John
${VALID_LAST_NAME}      Doe
${VALID_EMAIL}          john@yopmail.com
${VALID_PHONE}          9998887777
${VALID_DOB}            11-10-2025
${VALID_ADDRESS}        123 Test Street
${VALID_New_User_PASSWORD}    Test@123
${VALID_CONFIRM_PASSWORD}    Test@123

${Valid_UserID}      SchoolLe
${Valid_Password}    School123@

#Xpath UserID
${Empty_UserID}        xpath=//p[normalize-space(text())='The User ID cannot be empty']
${Min_UserID}          xpath=//p[normalize-space(text())='User ID must be at least 8 characters.']
${Max_UserID}          xpath=//p[normalize-space(text())='User ID must be at most 20 characters.']

#Xpath First Name
${Empty_FirstName}      xpath=//p[normalize-space(text())='The First Name cannot be empty']
${Min_FirstName}        xpath=//p[normalize-space(text())='First name must be at least 2 characters.']
${Max_FirstName}        xpath=//p[normalize-space(text())='First name must be at most 50 characters.']

#Xpath Last Name
${Empty_LastName}       xpath=//p[normalize-space(text())='The Last Name cannot be empty']
${Min_LastName}         xpath=//p[normalize-space(text())='Last Name must be at least 2 characters.']
${Max_LastName}         xpath=//p[normalize-space(text())='Last Name must be at most 50 characters.']


#Xpath Email
${Empty_Email}         //p[normalize-space(text())='Email is required.']
${Invalid_Email}       //p[normalize-space(text())='Not a valid email address.']

#Xpath Phone Number
${Invalid_Phone}       //p[normalize-space(text())='Phone number must be 10 characters.']

#Xpath Address
${Min_Address}      //p[normalize-space(text())='Address must be at least 8 characters.']
${Max_Address}      //p[normalize-space(text())='Address must be at most 280 characters.']

#Xpath Password
${Empty_Password}           //p[normalize-space(text())='Password is required.']
${Min_Password}             //p[normalize-space(text())='Password must be at least 8 characters.']
${Missing_Uppercase}        //p[normalize-space(text())='Password must contain at least one uppercase letter.']
${Missing_Lowercase}        //p[normalize-space(text())='Password must contain at least one lowercase letter.']
${Missing_OneNumber}        //p[normalize-space(text())='Password must contain at least one number.']
${Missing_SpecialChar}      //p[normalize-space(text())='Password must contain at least one special character.']

#Xpath Confirm Password
${Empty_ConfirmPassword}        //p[normalize-space(text())='Confirm password is required.']
${Mismatch_ConfirmPassword}     //p[normalize-space(text())='Confirm Passwords do not match.']

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


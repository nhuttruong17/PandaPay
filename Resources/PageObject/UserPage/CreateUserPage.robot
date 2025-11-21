*** Settings ***
Documentation    Page Object for Create User functionality
Resource    ../../../TestData/Browser/Global.robot
Resource    ../../../TestKeyWords/Common.robot
Library    SeleniumLibrary
Library    FakerLibrary

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
${CREATE_USER_SUBMIT}        xpath=/html/body/div[1]/div/main/div/div/form/button
${Create_User_API}           api/admin/user/
#Data
${UserID_exist}         School1190
${Email_Exist}          kai@exnodes.vn
${Phonenumber_Exist}    9977686888   
${VALID_DOB}            11-10-2025
${VALID_ADDRESS}        123 Test Street
${VALID_New_User_PASSWORD}    Test@123
${VALID_CONFIRM_PASSWORD}    Test@123
#Xpath UserID
${Empty_UserID}            xpath=//p[normalize-space(text())='User ID is required.']
${Expected_UserID}         User ID is required.
${Min_UserID}              xpath=//p[normalize-space(text())='User ID must be at least 8 characters.']
${Expected_min_UserID}     User ID must be at least 8 characters.
${Max_UserID}              xpath=//p[normalize-space(text())='User ID must be at most 20 characters.']
${Expected_max_UserID}     User ID must be at most 20 characters.
#Xpath First Name
${Empty_FirstName}           xpath=//p[normalize-space(text())='First name is required.']
${Expected_FirstName}        First name is required.
${Min_FirstName}             xpath=//p[normalize-space(text())='First name must be at least 2 characters.']
${Expected_min_FirstName}    First name must be at least 2 characters.
${Max_FirstName}             xpath=//p[normalize-space(text())='First name must be at most 50 characters.']
${Expected_max_FirstName}    First name must be at most 50 characters.
#Xpath Last Name
${Empty_LastName}           xpath=//p[normalize-space(text())='The Last Name cannot be empty']
${Expected_LastName}        The Last Name cannot be empty
${Min_LastName}             xpath=//p[normalize-space(text())='Last name must be at least 2 characters.']
${Expected_min_LastName}    Last name must be at least 2 characters.
${Max_LastName}             xpath=//p[normalize-space(text())='Last name must be at most 50 characters.']
${Expected_max_LastName}    Last name must be at most 50 characters.
#Xpath Email
${Empty_Email}              xpath=//p[normalize-space(text())='Email is required.']
${Expected_empty_Email}     Email is required.
${Invalid_Email}            xpath=//p[normalize-space(text())='Not a valid email address.']
${Expected_invalid_Email}   Not a valid email address.
#Xpath Phone Number
${Invalid_Phone}            xpath=//p[normalize-space(text())='Phone number must be 10 characters.']
${Expected_invalid_Phone}   Phone number must be 10 characters.
#Xpath Address    
${Min_Address}              xpath=//p[normalize-space(text())='Address must be at least 8 characters.']
${Expected_min_Address}     Address must be at least 8 characters.
${Max_Address}              xpath=//p[normalize-space(text())='Address must be at most 280 characters.']
${Expected_max_Address}     Address must be at most 280 characters.
#Xpath Password
${Empty_Password}                     xpath=//p[normalize-space(text())='Password is required.']
${Expected_empty_Password}            Password is required.
${Min_Password}                       xpath=//p[normalize-space(text())='Password must be at least 8 characters.']
${Expected_min_Password}              Password must be at least 8 characters.
${Missing_Uppercase}                  xpath=//p[normalize-space(text())='Password must contain at least one uppercase letter.']
${Expected_Uppercase_Password}        Password must contain at least one uppercase letter.
${Missing_Lowercase}                  xpath=//p[normalize-space(text())='Password must contain at least one lowercase letter.']
${Expected_Lowercase_Password}        Password must contain at least one lowercase letter.
${Missing_OneNumber}                  xpath=//p[normalize-space(text())='Password must contain at least one number.']
${Expected_OneNumber_Password}        Password must contain at least one number.
${Missing_SpecialChar}                xpath=//p[normalize-space(text())='Password must contain at least one special character.']
${Expected_SpecialChar_Password}      Password must contain at least one special character.
#Xpath Confirm Password
${Empty_ConfirmPassword}              xpath=//p[normalize-space(text())='Confirm password is required.']
${Expected_empty_ConfirmPassword}     Confirm password is required.
${Mismatch_ConfirmPassword}           xpath=//p[normalize-space(text())='Passwords do not match.']
${Expected_mismatch_ConfirmPassword}  Passwords do not match.
#Toast message
${Toast_message}                       //div[@class="text-sm opacity-90"]
${Expected_toast_UserIDExist}          • User ID code already exists
${Expected_toast_EmailExist}           • Email already used
${Expected_toast_PhoneNumberExist}     • Phone number already used
${Expected_toast_CreateUserSuccess}    User created successfully.

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
    Click on Element    xpath=//select[@aria-hidden='true']/option[@value='8']
    
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

Open Browser To Create User Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_USER_BUTTON}
    Click on Element    ${CREATE_USER_BUTTON}
    Generate Data User Information

On screen Create User Page
    No Operation

#UserID
Verify Error Message For Empty User ID
    Check validation error message    ${Empty_UserID}    ${Expected_UserID}

Verify Error Message For Min User ID
    Check validation error message    ${Min_UserID}    ${Expected_min_UserID}

Verify Error Message For Max User ID
    Check validation error message    ${Max_UserID}    ${Expected_max_UserID}

Verify No Error Message For Valid User ID
    Page Should Not Contain           ${Min_UserID}    ${Expected_min_UserID}
    
#First Name    
Verify Error Message For Empty First Name
    Check validation error message    ${Empty_FirstName}    ${Expected_FirstName}    

Verify Error Message For Min First Name
    Check validation error message    ${Min_FirstName}    ${Expected_min_FirstName}

Verify Error Message For Max First Name
    Check validation error message    ${Max_FirstName}    ${Expected_max_FirstName}

Verify No Error Message For Valid First Name
    Page Should Not Contain           ${Max_FirstName}    ${Expected_max_FirstName}

#Last Name
Verify Error Message For Empty Last Name
    Check validation error message    ${Empty_LastName}    ${Expected_LastName}    

Verify Error Message For Min Last Name
    Check validation error message    ${Min_LastName}    ${Expected_min_LastName}

Verify Error Message For Max Last Name
    Check validation error message    ${Max_LastName}    ${Expected_max_LastName}

Verify No Error Message For Valid Last Name
    Page Should Not Contain           ${Max_LastName}    ${Expected_max_LastName}

#Email
Verify Error Message For Empty Email
    Check validation error message    ${Empty_Email}      ${Expected_empty_Email}

Verify Error Message For Invalid Email
    Check validation error message    ${Invalid_Email}    ${Expected_invalid_Email}

Verify No Error Message For Valid Email
    Page Should Not Contain           ${Invalid_Email}    ${Expected_invalid_Email}

#Phone Number
Verify Error Message For Invalid Phone Number
    Check validation error message    ${Invalid_Phone}    ${Expected_invalid_Phone}

Verify No Error Message For Valid Phone Number
    Page Should Not Contain           ${Invalid_Phone}    ${Expected_invalid_Phone}

#Address
Verify Error Message For Min Address
    Check validation error message    ${Min_Address}    ${Expected_min_Address}

Verify Error Message For Max Address
    Check validation error message    ${Max_Address}    ${Expected_max_Address}

Verify No Error Message For Valid Address
    Page Should Not Contain           ${Max_Address}    ${Expected_max_Address}

#Password
Verify Error Message For Empty Password
    Check validation error message    ${Empty_Password}              ${Expected_empty_Password}

Verify Error Message For Min Password
    Check validation error message    ${Min_Password}                ${Expected_min_Password}

Verify Error Message For Missing Uppercase Password
    Check validation error message    ${Missing_Uppercase}           ${Expected_Uppercase_Password}   

Verify Error Message For Missing Lowercase Password
    Check validation error message    ${Missing_Lowercase}           ${Expected_Lowercase_Password}    

Verify Error Message For Missing Number Password
    Check validation error message    ${Missing_OneNumber}           ${Expected_OneNumber_Password}

Verify Error Message For Missing Special Character Password
    Check validation error message    ${Missing_SpecialChar}         ${Expected_SpecialChar_Password}

Verify Error Message For Empty Confirm Password
    Check validation error message    ${Empty_ConfirmPassword}       ${Expected_empty_ConfirmPassword}

Verify Error Message For Mismatch Confirm Password
    Check validation error message    ${Mismatch_ConfirmPassword}    ${Expected_mismatch_ConfirmPassword}

#Input Information
User Input Information with Existing User ID
    Input User ID        ${UserID_exist}
    Input First Name     ${Gen_Firstname}
    Input Last Name      ${Gen_Lastname}
    Input Email          ${Gen_Email}
    Input Phone Number    ${Gen_Phonenumber}
    Input Date Of Birth    ${VALID_DOB}
    Input Address    ${VALID_ADDRESS}
    Scroll To Bottom
    Select User Role
    Input Password Web         ${VALID_New_User_PASSWORD}
    Input Confirm Password     ${VALID_CONFIRM_PASSWORD}

User Input Information with Existing Existing Email
    Input User ID         ${Data_UserID}
    Input First Name      ${Gen_Firstname}
    Input Last Name       ${Gen_Lastname}
    Input Email           ${Email_Exist}
    Input Phone Number    ${Gen_Phonenumber}
    Input Date Of Birth   ${VALID_DOB}
    Input Address         ${VALID_ADDRESS}
    Select User Role
    Input Password Web         ${VALID_New_User_PASSWORD}
    Input Confirm Password     ${VALID_CONFIRM_PASSWORD}

User Input Information with Existing Phone Number
    Input User ID         ${Data_UserID}
    Input First Name      ${Gen_Firstname}
    Input Last Name       ${Gen_Lastname}
    Input Email           ${Gen_Email}
    Input Phone Number    ${Phonenumber_Exist}
    Input Date Of Birth   ${VALID_DOB}
    Input Address         ${VALID_ADDRESS}
    Select User Role
    Input Password Web         ${VALID_New_User_PASSWORD}
    Input Confirm Password     ${VALID_CONFIRM_PASSWORD}

User Input Valid Information for New User
    Input User ID            ${Data_UserID}
    Input First Name         ${Gen_Firstname}
    Input Last Name          ${Gen_Lastname}
    Input Email              ${Gen_Email}
    Input Phone Number       ${Gen_Phonenumber}
    Input Date Of Birth      ${VALID_DOB}
    Input Address            ${VALID_ADDRESS}
    Select User Role
    Input Password Web         ${VALID_New_User_PASSWORD}
    Input Confirm Password     ${VALID_CONFIRM_PASSWORD}

Verify Error Message For Existing User ID
    Check validation error message    ${Toast_message}    ${Expected_toast_UserIDExist}

Verify Error Message For Existing Email
    Check validation error message    ${Toast_message}    ${Expected_toast_EmailExist}

Verify Error Message For Existing Phone Number
    Check validation error message    ${Toast_message}    ${Expected_toast_PhoneNumberExist}

Verify Sucessfully Message For Create User
    Check validation error message    ${Toast_message}    ${Expected_toast_CreateUserSuccess}

# Save Session After Login (profile)
#     [Documentation]    Login once using a Chrome profile and close browser (profile will keep session)
#     [Tags]    session    save
#     # Open Browser To Create User Page
#     Fill Text Input    ${input_UserID}    ${Valid_UserID}
#     Fill Text Input    ${input_Password}    ${Valid_Password}
#     Click on SignIn with Wait Response login successfully
#     Save Browser Session
#     [Teardown]    Close Browser

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

Generate Data User Information 
    ${Gen_UserID}=    FakerLibrary.Word
    Log    ${Gen_UserID}
    Set Suite Variable    ${Data_UserID}    ${Gen_UserId}Exnodes
    Log    ${Data_UserID}

    ${Gen_Firstname}=    FakerLibrary.First Name
    Set Suite Variable    ${Gen_Firstname}
    Log    ${Gen_Firstname}
    
    ${Gen_Lastname}=    FakerLibrary.Last Name
    Set Suite Variable    ${Gen_Lastname}
    Log    ${Gen_Lastname}

    ${Gen_Email}=    FakerLibrary.Email
    Set Suite Variable    ${Gen_Email}
    Log    ${Gen_Email}

    ${Gen_Phonenumber}=    FakerLibrary.Basic Phone Number
    Set Suite Variable    ${Gen_Phonenumber}
    Log    ${Gen_Phonenumber}
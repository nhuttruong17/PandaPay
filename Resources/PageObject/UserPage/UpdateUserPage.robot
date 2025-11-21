*** Settings ***
Documentation    Page Object for Update User functionality
Resource    ../../../TestData/Browser/Global.robot
Resource    ../../../TestKeyWords/Common.robot
Library    SeleniumLibrary
Library    Collections
Library    FakerLibrary

*** Variables ***
${USER_ID_INPUT}             //*[@name="user_id"]
${FIRST_NAME_INPUT}          //input[@id='first_name ']
${LAST_NAME_INPUT}           //input[@id='last_name ']
${EMAIL_INPUT}               //input[@id='email ']
${PHONE_INPUT}               //input[@placeholder='Enter phone number']
${DOB_INPUT}                 //input[@placeholder='Enter date of birth']
${ADDRESS_INPUT}             //input[@placeholder='Address']
${USER_ROLE_SELECT}          //button[.//span[text()='Select user role']]
${PASSWORD_INPUT}            //input[@name='password']
${CONFIRM_PASSWORD_INPUT}    //input[@name='confirm_password']
${ACCOUNT_STATUS_TOGGLE}     id=account-status
${LANGUAGE_RADIO_ENGLISH}    xpath=//input[@name='language' and @value='English']
${LANGUAGE_RADIO_FRENCH}     xpath=//input[@name='language' and @value='French']
${LANGUAGE_RADIO_SPANISH}    xpath=//input[@name='language' and @value='Spanish']
${ORGANIZATION_SELECT}       id=organization\
${UPDATE_USER_BUTTON}        xpath=//p[normalize-space()='Update user']
${Tab_USER_BUTTON}           xpath=//button[normalize-space()='User']
${UPDATE_USER_SUBMIT}        xpath=//button[normalize-space()='Submit']
${Create_User_API}      api/admin/user/
${UserID_exist}         School1190
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
#Toast message
${Toast_message}                       //div[@class="text-sm opacity-90"]
${Expected_toast_EmailExist}           • Email already used
${Expected_toast_PhoneNumberExist}     • Phone number already used
${Expected_toast_CreateUserSuccess}    User updated successfully.
#Data
${VALID_ADDRESS}        123 Test Street
${Phone_number_exist}    3693256983
${Email_exist}        kai@exnodes.vn
${VALID_DOB}            11-10-2025

*** Keywords ***
Input First Name
    [Arguments]    ${first_name}
    SeleniumLibrary.Wait Until Element Is Visible    ${FIRST_NAME_INPUT}    10s
    Clear Element Text        ${FIRST_NAME_INPUT}
    Fill Text Input    ${FIRST_NAME_INPUT}    ${first_name}

Input Last Name
    [Arguments]    ${last_name}
    SeleniumLibrary.Wait Until Element Is Visible    ${LAST_NAME_INPUT}    10s
    Clear Element Text    ${LAST_NAME_INPUT}
    Fill Text Input    ${LAST_NAME_INPUT}    ${last_name}

Input Email
    [Arguments]    ${email}
    SeleniumLibrary.Wait Until Element Is Visible    ${EMAIL_INPUT}    10s
    Clear Element Text    ${EMAIL_INPUT}
    Fill Text Input    ${EMAIL_INPUT}    ${email}

Input Phone Number
    [Arguments]    ${phone}
    SeleniumLibrary.Wait Until Element Is Visible    ${PHONE_INPUT}    10s
    Clear Element Text    ${PHONE_INPUT}
    Fill Text Input    ${PHONE_INPUT}    ${phone}

Input Date Of Birth
    [Arguments]    ${dob}
    SeleniumLibrary.Wait Until Element Is Visible    ${DOB_INPUT}    10s
    Clear Element Text    ${DOB_INPUT}
    Fill Text Input    ${DOB_INPUT}    ${dob}

Input Address
    [Arguments]    ${address}
    SeleniumLibrary.Wait Until Element Is Visible    ${ADDRESS_INPUT}    10s
    Clear Element Text    ${ADDRESS_INPUT}
    Fill Text Input    ${ADDRESS_INPUT}    ${address}

Select User Role
    Click on Element    xpath=//select[@aria-hidden='true']/option[@value='8']

Click Update Submit
    Click on Element    ${UPDATE_USER_SUBMIT}

On screen Update User Page
    No Operation

Go To Update User Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_USER_BUTTON}
    Select User Random User From List
    Click on Element    ${UPDATE_USER_BUTTON}
    Sleep    5s
    Generate Data User Information

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

#Input Information
User Input Information with Existing Existing Email
    Input Email     ${Email_exist}

User Input Information with Existing Phone Number
    Input Email           ${Gen_Email}
    Input Phone Number    ${Phone_number_exist}
   
User Input Valid Information for New User
    Input First Name      ${Gen_Firstname}
    Input Last Name       ${Gen_Lastname}
    Input Email           ${Gen_Email}
    Input Phone Number    ${Gen_Phonenumber}
    Input Date Of Birth   ${VALID_DOB}
    Input Address         ${VALID_ADDRESS}

Verify Error Message For Existing Email
    Check validation error message    ${Toast_message}    ${Expected_toast_EmailExist}
    Sleep    2

Verify Error Message For Existing Phone Number
    Check validation error message    ${Toast_message}    ${Expected_toast_PhoneNumberExist}
    Sleep    2

Verify Sucessfully Message For Update User
    Check validation error message    ${Toast_message}    ${Expected_toast_CreateUserSuccess}

Select User Random User From List
    [Documentation]    Collect visible user rows from the users table and click one at random.
    SeleniumLibrary.Wait Until Element Is Visible    xpath=//table//tbody//tr    20s
    ${rows}=    SeleniumLibrary.Get WebElements    xpath=//table//tbody//tr
    ${count}=    Get Length    ${rows}
    Run Keyword If    ${count} == 0    Fail    No user rows found to click
    ${index}=    Evaluate    random.randint(0, ${count}-1)    modules=random
    ${row}=    Collections.Get From List    ${rows}    ${index}
    # Try to scroll the row into view, then click it (use SeleniumLibrary explicitly to avoid conflicts)
    Run Keyword And Ignore Error    SeleniumLibrary.Scroll Element Into View    ${row}
    SeleniumLibrary.Click Element    ${row}

Click Submit button and wait for response Existing Email    
    SeleniumLibrary.Wait Until Element Is Visible    //p[contains(normalize-space(.), '#')]      15s
    ${text}=    SeleniumLibrary.Get Text    //p[contains(normalize-space(.), '#')]
    Log    ${text}
    ${id}=    Evaluate    re.search(r'#(\\d+)', """${text}""").group(1)    re
    Log    ${id}
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    api/admin/user/${id}/
    Click Update Submit
    Sleep    2s
    #Get Sign In Request
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_400}
    #Verify request payload
    ${request_payload}=    Evaluate    json.loads('''${result.payload}''')    json
    Log    ${request_payload}
    #Verify response
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings     ${parsed.success}        ${Boolean_False}
    Should Be Equal As Integers    ${parsed.statusCode}     ${Status_400}
    Should Be Equal As Strings     ${parsed.message}        INVALID_INPUT
    Should Contain                 ${parsed.data.email}     VAL116
    Log    ${parsed}

Click Submit button and wait for response Existing Phone Number        
    SeleniumLibrary.Wait Until Element Is Visible    //p[contains(normalize-space(.), '#')]      15s
    ${text}=    SeleniumLibrary.Get Text    //p[contains(normalize-space(.), '#')]
    Log    ${text}
    ${id}=    Evaluate    re.search(r'#(\\d+)', """${text}""").group(1)    re
    Log    ${id}
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    api/admin/user/${id}/
    Click Update Submit
    Sleep    2s
    #Get Sign In Request
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_400}
    #Verify request payload
    ${request_payload}=    Evaluate    json.loads('''${result.payload}''')    json
    Log    ${request_payload}
    #Verify response
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings     ${parsed.success}              ${Boolean_False}
    Should Be Equal As Integers    ${parsed.statusCode}           ${Status_400}
    Should Be Equal As Strings     ${parsed.message}              INVALID_INPUT
    Should Contain                 ${parsed.data.phone_number}    VAL117
    Log    ${parsed}

Click Submit button and wait for response update user successfully
    SeleniumLibrary.Wait Until Element Is Visible    //p[contains(normalize-space(.), '#')]      15s
    ${text}=    SeleniumLibrary.Get Text    //p[contains(normalize-space(.), '#')]
    Log    ${text}
    ${id}=    Evaluate    re.search(r'#(\\d+)', """${text}""").group(1)    re
    Log    ${id}
    ${driver}=    Get Library Instance    SeleniumLibrary
    Click Update Submit
    Network.Start Network Interception    ${driver.driver}
    Network.Clear Intercepted Requests    ${driver.driver}
    #Get Request
    ${profile_request}=    Network.Wait For Request    ${driver.driver}    ${Create_User_API}${id}/    ${Method_PUT}    timeout=10    
    Log    ${profile_request}
    #Get Response
    ${response}=    Set Variable    ${profile_request['response']}
    Log    ${response}
    ${parsed}=    Parse Response API    ${response}
    Log    ${parsed}
    Should Be Equal As Strings         ${parsed.success}        ${Boolean_True}
    Should Be Equal As Integers        ${parsed.statusCode}     ${Status_202}
    Should Be Equal As Strings         ${parsed.message}        UPDATE_DATA_SUCCEEDED
    Network.Stop Network Interception    ${driver.driver}    

Generate Data User Information 
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


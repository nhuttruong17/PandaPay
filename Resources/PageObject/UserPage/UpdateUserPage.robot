*** Settings ***
Documentation    Page Object for Update User functionality
Resource    ../../../TestData/Browser/Global.robot
Resource    ../../../TestKeyWords/Common.robot
Library    SeleniumLibrary
Library    Collections

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

# XPaths for validations (shared with CreateUserPage)
${Empty_UserID}    xpath=//p[normalize-space(text())='The User ID cannot be empty']
${Min_UserID}      xpath=//p[normalize-space(text())='User ID must be at least 8 characters.']
${Max_UserID}      xpath=//p[normalize-space(text())='User ID must be at most 20 characters.']

#Xpath First Name
${Empty_FirstName}   xpath=//p[normalize-space(text())='The First Name cannot be empty']
${Min_FirstName}     xpath=//p[normalize-space(text())='First name must be at least 2 characters.']
${Max_FirstName}     xpath=//p[normalize-space(text())='First name must be at most 50 characters.']

#Xpath Last Name
${Empty_LastName}    xpath=//p[normalize-space(text())='The Last Name cannot be empty']
${Min_LastName}      xpath=//p[normalize-space(text())='Last Name must be at least 2 characters.']
${Max_LastName}      xpath=//p[normalize-space(text())='Last Name must be at most 50 characters.']

#Xpath Email
${Empty_Email}      //p[normalize-space(text())='Email is required.']
${Invalid_Email}    //p[normalize-space(text())='Not a valid email address.']

#Xpath Phone Number
${Invalid_Phone}    //p[normalize-space(text())='Phone number must be 10 characters.']

#Xpath Address
${Min_Address}      //p[normalize-space(text())='Address must be at least 8 characters.']
${Max_Address}      //p[normalize-space(text())='Address must be at most 280 characters.']
${VALID_ADDRESS}        123 Test Street

#Xpath Password
${Empty_Password}          //p[normalize-space(text())='Password is required.']
${Min_Password}            //p[normalize-space(text())='Password must be at least 8 characters.']
${Missing_Uppercase}       //p[normalize-space(text())='Password must contain at least one uppercase letter.']
${Missing_Lowercase}       //p[normalize-space(text())='Password must contain at least one lowercase letter.']
${Missing_OneNumber}       //p[normalize-space(text())='Password must contain at least one number.']
${Missing_SpecialChar}     //p[normalize-space(text())='Password must contain at least one special character.']

#Xpath Confirm Password
${Empty_ConfirmPassword}        //p[normalize-space(text())='Confirm password is required.']
${Mismatch_ConfirmPassword}    //p[normalize-space(text())='Confirm Passwords do not match.']

${Phone_number_exist}    3693256983
${Email_exist}        henry@exnodes.vn

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

Verify Update Success
    Check validation error message    //div[@class="text-sm opacity-90"]    User updated successfully.

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
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_False}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_400}
    Should Be Equal As Strings    ${parsed.message}    INVALID_INPUT
    Should Contain    ${parsed.data.email}    VAL116
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
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_False}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_400}
    Should Be Equal As Strings    ${parsed.message}    INVALID_INPUT
    Should Contain    ${parsed.data.phone_number}    VAL117
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

    
    #Get Update Request
    ${profile_request}=    Network.Wait For Request    ${driver.driver}    ${Create_User_API}${id}/    ${Method_PUT}    timeout=10    
   
    Log    ${profile_request}

    ${response}=    Set Variable    ${profile_request['response']}
    Log    ${response}
    ${parsed}=    Parse Response API    ${response}
    Log    ${parsed}

    Should Be Equal As Strings    ${parsed.success}    ${Boolean_True}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_202}
    Should Be Equal As Strings    ${parsed.message}    UPDATE_DATA_SUCCEEDED
    Network.Stop Network Interception    ${driver.driver}    




    # ${driver}=    Get Library Instance    SeleniumLibrary
    # Click on Element    xpath=/html/body/div[1]/div/main/div/div/form/button
    # Network.Start Network Interception    ${driver.driver}
    # # Clear any existing requests
    # Network.Clear Intercepted Requests    ${driver.driver}
    # # Wait for profile request
    # ${profile_request}=    Network.Wait For Request    ${driver.driver}    ${Create_User_API}    POST    10
    # Log    ${profile_request}
    # # Parse and verify profile data
    # ${response}=    Set Variable    ${profile_request['response']}
    # Log    ${response}
    # ${parsed}=    Parse Response API    ${response}
    # Log    ${parsed}
    # Should Be Equal As Strings    ${parsed.success}    ${Boolean_True}
    # Should Be Equal As Integers    ${parsed.statusCode}    ${Status_201}
    # Should Be Equal As Strings    ${parsed.message}    CREATE_SUCCESS
    # Network.Stop Network Interception    ${driver.driver}

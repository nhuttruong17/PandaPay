*** Settings ***
Documentation    Page Object for Update User functionality
Resource    ../../../TestData/Browser/Global.robot
Resource    ../../../TestKeyWords/Common.robot
Library    SeleniumLibrary
Library    Collections

*** Variables ***
#Xpath Input Password
${PASSWORD_INPUT}            //input[@name='new_password']
${CONFIRM_PASSWORD_INPUT}    //input[@name='confirm_new_password']
#Xpath Password
${Empty_Password}           //p[normalize-space(text())='Password is required.']
${Min_Password}             //p[normalize-space(text())='Password must be at least 8 characters.']
${Missing_Uppercase}        //p[normalize-space(text())='Password must contain at least one uppercase letter.']
${Missing_Lowercase}        //p[normalize-space(text())='Password must contain at least one lowercase letter.']
${Missing_OneNumber}        //p[normalize-space(text())='Password must contain at least one number.']
${Missing_SpecialChar}      //p[normalize-space(text())='Password must contain at least one special character.']

#Xpath Confirm Password
${Empty_ConfirmPassword}        //p[normalize-space(text())='Confirm password is required.']
${Mismatch_ConfirmPassword}    //p[normalize-space(text())='Confirm Passwords do not match.']

#Button
${Tab_ChangePassword}           xpath=//p[normalize-space()='Change Password']
${CHANGE_PASSWORD_SUBMIT}       //button[p[normalize-space(text())="Confirm"]]

#End Point API
${ChangePassword_User_API}      api/admin/change-password/

*** Keywords ***
Input New Password
    [Arguments]    ${password}
    Fill Text Input    ${PASSWORD_INPUT}    ${password}

Input Confirm New Password
    [Arguments]    ${password}
    Fill Text Input    ${CONFIRM_PASSWORD_INPUT}    ${password}

Click Submit button and wait for response change password user successfully
    SeleniumLibrary.Wait Until Element Is Visible    //p[contains(normalize-space(.), '#')]      15s
    ${text}=    SeleniumLibrary.Get Text    //p[contains(normalize-space(.), '#')]
    Log    ${text}
    ${id}=    Evaluate    re.search(r'#(\\d+)', """${text}""").group(1)    re
    Log    ${id}
    ${driver}=    Get Library Instance    SeleniumLibrary
    Click on Element    ${CHANGE_PASSWORD_SUBMIT}
    Network.Start Network Interception    ${driver.driver}
    Network.Clear Intercepted Requests    ${driver.driver}
    #Get Request
    ${profile_request}=    Network.Wait For Request    ${driver.driver}    ${ChangePassword_User_API}${id}    ${Method_PUT}    timeout=10    
    Log    ${profile_request}
    #Get Response
    ${response}=    Set Variable    ${profile_request['response']}
    Log    ${response}
    ${parsed}=    Parse Response API    ${response}
    Log    ${parsed}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_True}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_202}
    Should Be Equal As Strings    ${parsed.message}    Update password user sucessfully
    Network.Stop Network Interception    ${driver.driver}    
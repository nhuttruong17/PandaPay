*** Settings ***
Resource        ../../Resources/PageObject/LoginPage/LoginPage.robot
Resource        ../../TestData/LoginData/LoginData.robot
Suite Setup     Basic Setup iOS
Suite Teardown  Basic TearDowns iOS
*** Test Cases ***
#Test case validation text UserID
Check validation empty UserID error
    Fill Text Input mobile    ${input_UserID_IOS}    ${Empty_textUserID}
    Click on Element mobile    ${elm_clickscreen}
    Click on Element mobile    ${btn_Login_IOS}
    Check validation error message mobile    ${elm_error_empty_UserID_IOS}    ${Expected_error_emptyfield}
Check validation min UserID error
    Fill Text Input mobile    ${input_UserID_IOS}    ${Min_textUserID}
    Click on Element mobile    ${elm_clickscreen}
    Check validation error message mobile    ${elm_MinUserID}    ${Expected_MinUserID}
Check validation max UserID error
    Clear Text    //XCUIElementTypeTextField[@value="${Min_textUserID}"]
    Fill Text Input mobile    ${input_UserID_IOS}    ${Max_textUserID}
    Click on Element mobile    ${elm_clickscreen}
    Check validation error message mobile    ${elm_MaxUserID}    ${Expected_MaxUserID}
Check validation special characters UserID error
    Clear Text    //XCUIElementTypeTextField[@value="${Max_textUserID}"]
    Fill Text Input mobile    ${input_UserID_IOS}    ${Specialcharacters_textUserID}
    Click on Element mobile    ${elm_clickscreen}
    Check validation error message mobile    ${elm_SpecialCharacters}    ${EXPECTED_SpecialCharacters}
Check validation empty Password error
    Click on Element mobile    ${elm_showPassword}
    Fill Text Input mobile    ${input_Password_IOS}    ${Empty_textPassword}
    Click on Element mobile    ${btn_Login_IOS}
    Check validation error message mobile    ${elm_error_empty_Password_IOS}    ${Expected_error_emptyfield}
Check validation min Password error
    Fill Text Input mobile    ${input_Password_IOS}    ${Min_textPassword}
    Click on Element mobile    ${btn_Login_IOS}
    Check validation error message mobile    ${elm_MinPassword}    ${Expected_MinPassword}
Check validation missing uppercase Password error
    Clear Text    //XCUIElementTypeTextField[@value="${Min_textPassword}"]
    Fill Text Input mobile    ${input_Password_IOS}    ${Missing_Uppercase}
    Click on Element mobile    ${btn_Login_IOS}
    Check validation error message mobile    ${elm_validationtext_password}    ${EXPECTED_validationtext_password}
Check validation missing lowercase Password error
    Clear Text    //XCUIElementTypeTextField[@value="${Missing_Uppercase}"]
    Fill Text Input mobile    ${input_Password_IOS}    ${Missing_Lowercase}
    Click on Element mobile    ${btn_Login_IOS}
    Check validation error message mobile    ${elm_validationtext_password}    ${EXPECTED_validationtext_password}
Check validation missing one number Password error
    Clear Text    //XCUIElementTypeTextField[@value="${Missing_Lowercase}"]
    Fill Text Input mobile    ${input_Password_IOS}    ${Missing_Number}
    Click on Element mobile    ${btn_Login_IOS}
    Check validation error message mobile    ${elm_validationtext_password}    ${EXPECTED_validationtext_password}
Check validation missing one special character Password error
    Clear Text    //XCUIElementTypeTextField[@value="${Missing_Number}"]
    Fill Text Input mobile    ${input_Password_IOS}    ${Missing_Special}
    Click on Element mobile    ${btn_Login_IOS}
    Check validation error message mobile    ${elm_validationtext_password}    ${EXPECTED_validationtext_password}
#Test function Login
Verify login with account inactive
    AppiumLibrary.Wait Until Element Is Visible    //XCUIElementTypeTextField[@value="${Specialcharacters_textUserID}"]
    Clear Text    //XCUIElementTypeTextField[@value="${Specialcharacters_textUserID}"]
    Fill Text Input mobile    ${input_UserID_IOS}    ${Valid_UserID_inactive}
    Click on Element mobile    ${elm_clickscreen}
    Clear Text    //XCUIElementTypeTextField[@value="${Missing_Special}"]
    Fill Text Input mobile    ${input_Password_IOS}    ${Valid_Password_inactive}
    Click on Element mobile    ${btn_Login_IOS}
    Check validation error message mobile    ${elm_login_inactive_IOS}    ${Expected_login_inactive_IOS}
Verify login with account invalid
    AppiumLibrary.Wait Until Element Is Visible    //XCUIElementTypeTextField[@value="${Valid_UserID_inactive}"]
    Clear Text    //XCUIElementTypeTextField[@value="${Valid_UserID_inactive}"]
    Fill Text Input mobile    ${input_UserID_IOS}    ${Valid_UserID}
    Click on Element mobile    ${elm_clickscreen}
    Clear Text    //XCUIElementTypeTextField[@value="${Valid_Password_inactive}"]
    Fill Text Input mobile    ${input_Password_IOS}    ${Invalid_Password}
    Click on Element mobile    ${btn_Login_IOS}
    Check validation error message mobile    ${elm_login_failed_IOS}    ${Expected_login_failed_IOS}
Verify login success with valid account
    AppiumLibrary.Wait Until Element Is Visible    //XCUIElementTypeTextField[@value="${Valid_UserID}"]
    Clear Text    //XCUIElementTypeTextField[@value="${Valid_UserID}"]
    Fill Text Input mobile    ${input_UserID_IOS}    ${Valid_UserID}
    Click on Element mobile    ${elm_clickscreen}
    Clear Text    //XCUIElementTypeTextField[@value="${Invalid_Password}"]
    Fill Text Input mobile    ${input_Password_IOS}    ${Valid_Password}
    Click on Element mobile    ${btn_Login_IOS}
    Check validation error message mobile    ${elm_login_success_IOS}    ${Expected_login_success_IOS}
Verify logout success
    Sleep    3s
    Click on Element mobile    ${elm_Settings_IOS}
    Click on Element mobile    ${elem_SignOut_IOS}
    Click on Element mobile    ${elm_confirm_Yes}
    Check validation error message mobile    ${elm_welcome_IOS}    ${Expected_Welcome_IOS}

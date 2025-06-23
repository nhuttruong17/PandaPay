*** Settings ***
Resource        ../../Resources/PageObject/LoginPage/LoginPage.robot
Resource        ../../TestData/LoginData/LoginData.robot
Suite Setup     Basic Setup
Suite Teardown  Basic TearDowns
*** Test Cases ***
#Test case validation text UserID
Check validation empty UserID error
    Given Fill Text Input  ${input_UserID}  ${Empty_textUserID}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_empty_UserID}    ${EXPECTED_ERROR_EmptyUserID}
Check validation special characters UserID error
    Given Fill Text Input  ${input_UserID}   ${Specialcharacters_textUserID}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_invalid_UserID}    ${EXPECTED_ERROR_InvalidUserID}
Check validation min UserID error
    Given Fill Text Input  ${input_UserID}  ${Min_textUserID}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_min_UserID}    ${EXPECTED_ERROR_MinUserID}
Check validation max UserID error
    Given Fill Text Input  ${input_UserID}  ${Max_textUserID}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_max_UserID}    ${EXPECTED_ERROR_MaxUserID}
#Test case validation text Password
Check validation empty Password error
    Given Fill Text Input  ${input_Password}    ${Empty_textPassword}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_empty_Password}    ${EXPECTED_ERROR_EmptyPassword}
Check validation min Password error
    Given Fill Text Input  ${input_Password}   ${Min_textPassword}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_min_Password}    ${EXPECTED_ERROR_MinPassword}
Check validation missing uppercase Password error
    Given Fill Text Input  ${input_Password}    ${Missing_Uppercase}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_Missing_Uppercase}    ${EXPECTED_Missing_Uppercase}
Check validation missing lowercase Password error
    Given Fill Text Input  ${input_Password}    ${Missing_Lowercase}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_Missing_Lowercase}    ${EXPECTED_Missing_Lowercase}
Check validation missing one number Password error
    Given Fill Text Input  ${input_Password}     ${Missing_Number}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_Missing_OneNumber}    ${EXPECTED_Missing_OneNumber}
Check validation missing one special character Password error
    Given Fill Text Input  ${input_Password}    ${Missing_Special}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_Missing_OneSpecialCharacter}    ${EXPECTED_Missing_OneSpecialCharacter}
#Test function Login
Verify login with account inactive
    Given Fill Text Input  ${input_UserID}    ${Valid_UserID_inactive}
    And Fill Text Input  ${input_Password}    ${Valid_Password_inactive}
    When Click on Sign In with Wait Request Payload account Inactive
    Then Check validation error message    ${elm_error_message_inactive}    ${EXPECTED_ERROR_MESSAGE_inactive}
Verify login failed with invalid account
    Given Fill Text Input  ${input_UserID}   ${Valid_UserID}
    And Fill Text Input  ${input_Password}   ${Invalid_Password}
    When Click on SignIn with Wait Request Payload login Failed
    Then Check validation error message    ${elm_error_message}    ${EXPECTED_ERROR_MESSAGE}
Verify login success with valid account
    Given Fill Text Input  ${input_UserID}   ${Valid_UserID}
    And Fill Text Input  ${input_Password}  ${Valid_Password}
    When Click on SignIn with Wait Response login successfully
    Then Check validation error message    ${elm_daily_batch_report}    ${EXPECTED_SUCCESS_MESSAGE}
Verify logout success
    Sleep    2
    Click on Logout

*** Settings ***
Resource        ../../Resources/PageObject/LoginPage/LoginPage.robot
Resource        ../../TestData/LoginData/LoginData.robot
Suite Setup     Basic Setup
Suite Teardown  Basic TearDowns
*** Test Cases ***
#Test case validation text UserID
Check validation empty UserID error
    [Documentation]    Verify that the system shows validation error when UserID input is empty
    [Tags]    UserID    Validation    Empty
    Given Fill Text Input  ${input_UserID}  ${Empty_textUserID}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_empty_UserID}    ${EXPECTED_ERROR_EmptyUserID}

Check validation special characters UserID error
    [Documentation]    Verify that UserID does not accept special characters and shows proper validation error
    [Tags]    UserID    Validation    SpecialCharacters
    Given Fill Text Input  ${input_UserID}   ${Specialcharacters_textUserID}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_invalid_UserID}    ${EXPECTED_ERROR_InvalidUserID}

Check validation min UserID error
    [Documentation]    Verify that UserID below minimum length shows appropriate validation error
    [Tags]    UserID    Validation    MinLength
    Given Fill Text Input  ${input_UserID}  ${Min_textUserID}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_min_UserID}    ${EXPECTED_ERROR_MinUserID}

Check validation max UserID error
    [Documentation]    Verify that UserID exceeding maximum length shows appropriate validation error
    [Tags]    UserID    Validation    MaxLength
    Given Fill Text Input  ${input_UserID}  ${Max_textUserID}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_max_UserID}    ${EXPECTED_ERROR_MaxUserID}

#Test case validation text Password
Check validation empty Password error
    [Documentation]    Verify that the system shows validation error when Password input is empty
    [Tags]    Password    Validation    Empty
    Given Fill Text Input  ${input_Password}    ${Empty_textPassword}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_empty_Password}    ${EXPECTED_ERROR_EmptyPassword}

Check validation min Password error
    [Documentation]    Verify that Password below minimum length shows appropriate validation error
    [Tags]    Password    Validation    MinLength
    Given Fill Text Input  ${input_Password}   ${Min_textPassword}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_min_Password}    ${EXPECTED_ERROR_MinPassword}

Check validation missing uppercase Password error
    [Documentation]    Verify that Password missing uppercase letter shows proper validation error
    [Tags]    Password    Validation    Uppercase
    Given Fill Text Input  ${input_Password}    ${Missing_Uppercase}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_Missing_Uppercase}    ${EXPECTED_Missing_Uppercase}

Check validation missing lowercase Password error
    [Documentation]    Verify that Password missing lowercase letter shows proper validation error
    [Tags]    Password    Validation    Lowercase
    Given Fill Text Input  ${input_Password}    ${Missing_Lowercase}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_Missing_Lowercase}    ${EXPECTED_Missing_Lowercase}

Check validation missing one number Password error
    [Documentation]    Verify that Password missing at least one number shows proper validation error
    [Tags]    Password    Validation    Number
    Given Fill Text Input  ${input_Password}     ${Missing_Number}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_Missing_OneNumber}    ${EXPECTED_Missing_OneNumber}

Check validation missing one special character Password error
    [Documentation]    Verify that Password missing at least one special character shows proper validation error
    [Tags]    Password    Validation    SpecialCharacter
    Given Fill Text Input  ${input_Password}    ${Missing_Special}
    When Click on Element  ${btn_SignIn}
    Then Check validation error message    ${error_Missing_OneSpecialCharacter}    ${EXPECTED_Missing_OneSpecialCharacter}

#Test function Login
Verify login with account inactive
    [Documentation]    Verify that login fails when using an inactive account
    [Tags]    Login    Negative    InactiveAccount
    Given Fill Text Input  ${input_UserID}    ${Valid_UserID_inactive}
    And Fill Text Input  ${input_Password}    ${Valid_Password_inactive}
    When Click on Sign In with Wait Request Payload account Inactive
    Then Check validation error message    ${elm_error_message_inactive}    ${EXPECTED_ERROR_MESSAGE_inactive}

Verify login failed with invalid account
    [Documentation]    Verify that login fails when using invalid credentials
    [Tags]    Login    Negative    InvalidCredentials
    Given Fill Text Input  ${input_UserID}   ${Valid_UserID}
    And Fill Text Input  ${input_Password}   ${Invalid_Password}
    When Click on SignIn with Wait Request Payload login Failed
    Then Check validation error message    ${elm_error_message}    ${EXPECTED_ERROR_MESSAGE}

Verify login success with valid account
    [Documentation]    Verify that login is successful with valid credentials
    [Tags]    Login    Positive    ValidAccount
    Given Fill Text Input  ${input_UserID}   ${Valid_UserID}
    And Fill Text Input  ${input_Password}  ${Valid_Password}
    When Click on SignIn with Wait Response login successfully
    Then Check validation error message    ${elm_daily_batch_report}    ${EXPECTED_SUCCESS_MESSAGE}
    
Verify logout success
    Sleep    2
    Click on Logout

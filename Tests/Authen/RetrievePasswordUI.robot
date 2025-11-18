*** Settings ***
Resource    ../../Resources/PageObject/RetrievePasswordPage/RetrievePasswordPage.robot
Resource    ../../TestData/RetrivePasswordData/RetrivePasswordData.robot
Resource    ../../TestKeyWords/Common.robot
*** Test Cases ***
Check Retrieve Password Page with UI, Fill Empty UserID
    [Documentation]    Verify validation error when UserID field is empty on Retrieve Password Page
    [Tags]    RetrievePassword    Validation    EmptyUserID
    Basic Setup
    Navigate to Retrieve Password Page
    Given Fill Text Input    ${input_UserID_Retrive}  ${Empty_textUserID}
    When Click on Element    ${btn_Submit_Retrive}
    Then Check validation error message    ${elm_error_validationtext}    ${EXPECTED_ERROR_EmptyUserID}

Check Retrieve Password Page with UI, Fill Special characters UserID
    [Documentation]    Verify validation error when UserID contains special characters
    [Tags]    RetrievePassword    Validation    SpecialCharacters
    Given Fill Text Input    ${input_UserID_Retrive}  ${Specialcharacters_textUserID}
    When Click on Element    ${btn_Submit_Retrive}
    Then Check validation error message    ${elm_error_validationtext}    ${EXPECTED_ERROR_InvalidUserID}

Check Retrieve Password Page with UI, Fill Min UserID
    [Documentation]    Verify validation error when UserID is below minimum length
    [Tags]    RetrievePassword    Validation    MinLength
    Given Fill Text Input    ${input_UserID_Retrive}  ${Min_textUserID}
    When Click on Element    ${btn_Submit_Retrive}
    Then Check validation error message    ${elm_error_validationtext}    ${EXPECTED_ERROR_MinUserID}

Check Retrieve Password Page with UI, Fill Max UserID
    [Documentation]    Verify validation error when UserID exceeds maximum length
    [Tags]    RetrievePassword    Validation    MaxLength
    Given Fill Text Input    ${input_UserID_Retrive}    ${Max_textUserID}
    When Click on Element    ${btn_Submit_Retrive}
    Then Check validation error message    ${elm_error_validationtext}    ${EXPECTED_ERROR_MaxUserID}
    Basic TearDowns

Check Retrieve Password Page with UI, User not existing
    [Documentation]    Verify error message when retrieving password for a non-existing user
    [Tags]    RetrievePassword    Negative    UserNotExist
    Basic Setup
    Navigate to Retrieve Password Page
    Given Fill Text Input    ${input_UserID_Retrive}    ${userID_Invalid}
    When Click on Retrieve Password with Wait Request Payload User not existing
    Then Check validation error message    ${elm_message}    ${EXPECTED_RERROR_MESSAGE_USERINVALID}
    Basic TearDowns

Check Retrieve Password Page with UI, Validation text OTP empty, Check Token invalid
    [Documentation]    Verify error message when OTP is empty or token is invalid
    [Tags]    RetrievePassword    Validation    OTP
    Basic Setup
    Navigate to Retrieve Password Page
    Given Fill Text Input    ${input_UserID_Retrive}    ${Valid_userID}
    When Click on Verify Retrieve Password with Wait Request Payload
    Then Check validation error message    ${elm_message}    ${EXPECTED_• The OTP you entered is incorrect. Please try again}
    Basic TearDowns

Check Retrive Password Page with UI, New Password same old password
    [Documentation]    Verify error message when new password is same as old password
    [Tags]    RetrievePassword    Validation    PasswordSameAsOld
    Basic Setup
    Navigate to Retrieve Password Page
    Given Fill Text Input    ${input_UserID_Retrive}    ${userID_SchoolLe}
    When Click on Retrieve with Wait Request Payload New Password Same Old Password
    Then Check validation error message    ${elm_message}    ${EXPECTED_• New password cannot be the same as current password}
    Basic TearDowns

Check Retrieve Password Page with UI, UserID valid with email
    [Documentation]    Verify successful password retrieval when UserID is valid and associated with email
    [Tags]    RetrievePassword    Positive    Email
    Basic Setup
    Navigate to Retrieve Password Page
    Given Fill Text Input  ${input_UserID_Retrive}   ${Valid_userID}
    When Click on Retrieve with Wait Request Payload UserID valid with email
    Then Check validation error message    ${elm_message}    ${EXPETCTED_Message_Retrieve_Success}
    Basic TearDowns
    
Check Retrieve Password Page with UI, UserID valid with phone number
    [Documentation]    Verify successful password retrieval when UserID is valid and associated with phone number
    [Tags]    RetrievePassword    Positive    Phone
    Basic Setup
    Navigate to Retrieve Password Page
    Given Fill Text Input  ${input_UserID_Retrive}   ${userID_Johny}
    When Click on Retrieve with Wait Request Payload UserID valid with phone number
    Then Check validation error message    ${elm_message}    ${EXPETCTED_Message_Retrieve_Success}
    Basic TearDowns
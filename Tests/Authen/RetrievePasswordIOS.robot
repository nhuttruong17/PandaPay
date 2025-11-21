*** Settings ***
Resource    ../../Resources/PageObject/RetrievePasswordPage/RetrievePasswordPage.robot
Resource    ../../TestData/RetrivePasswordData/RetrivePasswordData.robot
Resource    ../../TestKeyWords/Common.robot
*** Test Cases ***
Check Retrieve Password Page with IOS, Fill min UserID
    [Documentation]    Verify validation error when UserID is below minimum length
    [Tags]    RetrievePassword    Validation    MinLength
    Basic Setup iOS
    Click on Element mobile     ${elm_RetrivePassword_IOS}
    Fill Text Input mobile    ${input_UserID_RetrievePassword_IOS}   ${Min_textUserID}
    Check validation error message mobile    ${elm_minUserID_IOS}    ${Expected_minUserID_IOS}
    
Check Retrieve Password Page with IOS, Fill max UserID
    [Documentation]    Verify validation error when UserID exceeds maximum length
    [Tags]    RetrievePassword    Validation    MaxLength
    Clear Text    //XCUIElementTypeTextField[@value="${Min_textUserID}"]
    Fill Text Input mobile    ${input_UserID_RetrievePassword_IOS}    ${Max_textUserID}
    Check validation error message mobile    ${elm_maxUserID_IOS}    ${Expected_maxUserID_IOS}

Check Retrieve Password Page with IOS, Fill special characters UserID
    [Documentation]    Verify validation error when UserID contains special characters
    [Tags]    RetrievePassword    Validation    SpecialCharacters
    Clear Text    //XCUIElementTypeTextField[@value="${Max_textUserID}"]
    Fill Text Input mobile   ${input_UserID_RetrievePassword_IOS}    ${Specialcharacters_textUserID}
    Check validation error message mobile    ${elm_specialcharacters_IOS}      ${Expected_specialcharacters_IOS}

Check Retrieve Password Page with IOS, User not existing
    [Documentation]    Verify error message when retrieving password for a non-existing user
    [Tags]    RetrievePassword    Negative    UserNotExist
    Clear Text    //XCUIElementTypeTextField[@value="${Specialcharacters_textUserID}"]
    Fill Text Input mobile    ${input_UserID_RetrievePassword_IOS}    ${userID_Invalid}
    Click on Element mobile    ${elm_Continue_IOS}
    Check validation error message mobile    ${elm_UserID_notfound_IOS}    ${Expected_UserID_notfound_IOS}

Check Retrieve Password Page with IOS, UserID valid with email
    [Documentation]    Verify successful password retrieval when UserID is valid and associated with email
    [Tags]    RetrievePassword    Positive    Email
    Clear Text    //XCUIElementTypeTextField[@value="${userID_Invalid}"]
    Fill Text Input mobile    ${input_UserID_RetrievePassword_IOS}    ${userID_Schoolinactive}
    Click on Retrieve Password with email
    Check validation error message mobile    ${elm_Signout_IOS}    ${Expected_Signout_IOS}
    Execute Script    mobile: tap    x=246    y=581

Check Retrieve Password Page with IOS, UserID valid with phone number
    [Documentation]    Verify successful password retrieval when UserID is valid and associated with phone number
    [Tags]    RetrievePassword    Positive    Phone
    Click on Element mobile     ${elm_RetrivePassword_IOS}
    Fill Text Input mobile    ${input_UserID_RetrievePassword_IOS}    ${userID_Schoolinactive}
    Click on Retrieve Password with phone number
    Check validation error message mobile    ${elm_Signout_IOS}    ${Expected_Signout_IOS}
    Execute Script    mobile: tap    x=246    y=581

Check Retrieve Password Page with IOS, New password same as old password
    [Documentation]    Verify error message when new password is same as old password
    [Tags]    RetrievePassword    Validation    PasswordSameAsOld
    Click on Element mobile     ${elm_RetrivePassword_IOS}
    Fill Text Input mobile    ${input_UserID_RetrievePassword_IOS}    SchoolLe
    Click on Retrieve Password with email, New password same as old password
    Check validation error message mobile    ${elm_popup_Newpassword_samecurrent}    ${Expected_popup_NewPassword_SameCurrent}
    Execute Script    mobile: tap    x=246    y=581
    Basic TearDowns iOS
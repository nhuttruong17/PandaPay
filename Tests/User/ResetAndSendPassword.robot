*** Settings ***
Documentation    Test cases for Reset & Send Password functionality
Resource    ../../Resources/PageObject/UserPage/UpdateUserPage.robot
Resource    ../../Resources/PageObject/UserPage/ResetAndSendPasswordPage.robot

*** Test Cases ***
Reset and Send Password to Email successfully
    [Documentation]    Reset and send password to email successfully
    [Tags]    regression    reset_password    positive    email
    Given Go To Reset Password User Page
    When Choose method Reset & Send Password to Email
    And Click Submit button and wait for response Send Reset Password to Email
    Then Verify Sucessfully Message For Send Reset Password successfully
    [Teardown]    Close Browser

Reset and Send Password to Phone Number successfully
    [Documentation]    Reset and send password to phone number successfully
    [Tags]    regression    reset_password    positive    phone_number
    Given Go To Reset Password User Page
    When Choose method Reset & Send Password to PhoneNumber
    And Click Submit button and wait for response Send Reset Password to Phone Number
    Then Verify Sucessfully Message For Send Reset Password successfully
    [Teardown]    Close Browser

*** Keywords ***
Go To Reset Password User Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_USER_BUTTON}
    Select User Random User From List
    Click on Element    ${RESETPASSWORD_USER_BUTTON}
    Sleep    5s

Choose method Reset & Send Password to Email
    Click on Element    ${Radio_Email}

Choose method Reset & Send Password to PhoneNumber
    Click on Element    ${Radio_PhoneNumber}

Verify Sucessfully Message For Send Reset Password successfully
    Check validation error message    //div[@class="text-sm opacity-90"]        Reset user password successfully.
    
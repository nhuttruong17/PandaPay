*** Settings ***
Documentation    Test cases for Reset & Send Password functionality
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

    
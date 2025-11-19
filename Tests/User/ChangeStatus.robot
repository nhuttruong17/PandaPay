*** Settings ***
Documentation    Test cases for Reset & Send Password functionality
Resource    ../../Resources/PageObject/UserPage/UpdateUserPage.robot
Resource    ../../Resources/PageObject/UserPage/ResetAndSendPasswordPage.robot

*** Test Cases ***
Reset and Send Password to Email successfully
    # [Documentation]    Reset and send password to email successfully
    # [Tags]    regression    reset_password    positive    email
    Given Go To Reset Password User Page
    SeleniumLibrary.Wait Until Element Is Visible    //button[@value='on']
    ${get_attribute}=    SeleniumLibrary.Get Element Attribute    //button[@value='on']    aria-checked
    Log    ${get_attribute}


*** Keywords ***
Go To Reset Password User Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_USER_BUTTON}
    Select User Random User From List
    Click on Element    xpath=//p[normalize-space()='Change Status']
    Sleep    5s

Verify Sucessfully Message For Change Status successfully
    Check validation error message    //div[@class="text-sm opacity-90"]        Change status successfully.
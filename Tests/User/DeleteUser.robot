*** Settings ***
Documentation    Test cases for Update User functionality
Resource    ../../Resources/PageObject/UserPage/UpdateUserPage.robot
Resource    ../../Resources/PageObject/UserPage/DeleteUserPage.robot
Resource    ../../TestData/Browser/Global.robot
Resource    ../../TestKeyWords/Common.robot
Resource    ../../Resources/PageObject/LoginPage/LoginPage.robot
Resource    ../../TestData/LoginData/LoginData.robot


*** Test Cases ***

Test Delete User
    Given Go To Delete User Page
    Capture API Delete
    Then Verify Sucessfully Message For Delete User
    [Teardown]    Close Browser



*** Keywords ***
Go To Delete User Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_USER_BUTTON}
    Select User Random User From List
    Click on Element    xpath=//p[normalize-space()='Delete User']
    Sleep    5s

Verify Sucessfully Message For Delete User
    Check validation error message    //div[@class="text-sm opacity-90"]    User deleted successfully
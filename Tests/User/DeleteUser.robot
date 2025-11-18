*** Settings ***
Documentation    Test cases for Update User functionality
Resource    ../../Resources/PageObject/UserPage/UpdateUserPage.robot
Resource    ../../Resources/PageObject/UserPage/DeleteUserPage.robot
Resource    ../../TestData/Browser/Global.robot
Resource    ../../TestKeyWords/Common.robot
Resource    ../../Resources/PageObject/LoginPage/LoginPage.robot
Resource    ../../TestData/LoginData/LoginData.robot

*** Test Cases ***
Verify the system Delete User Successfully
    [Documentation]    Verify that the system allows deleting a user successfully and displays the correct success message.
    [Tags]    regression    delete_user    positive
    Given Go To Delete User Page
    When Choose User Random User From List
    And Click Delete button and wait for response update user successfully
    Then Verify Sucessfully Message For Delete User
    [Teardown]    Close Browser
    
*** Keywords ***
Go To Delete User Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_USER_BUTTON}

Choose User Random User From List
    Select User Random User From List
    Click on Element    xpath=//p[normalize-space()='Delete User']
    Sleep    5s

Verify Sucessfully Message For Delete User
    Check validation error message    //div[@class="text-sm opacity-90"]    User deleted successfully
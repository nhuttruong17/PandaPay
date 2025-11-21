*** Settings ***
Documentation    Test cases for Delete User functionality
Resource    ../../Resources/PageObject/UserPage/DeleteUserPage.robot

*** Test Cases ***
Verify the system Delete User Successfully
    [Documentation]    Verify that the system allows deleting a user successfully and displays the correct success message.
    [Tags]    regression    delete_user    positive
    Given Go To Delete User Page
    When Choose User Random User From List
    And Click Delete button and wait for response update user successfully
    Then Verify Sucessfully Message For Delete User
    [Teardown]    Close Browser
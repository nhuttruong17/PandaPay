*** Settings ***
Documentation    Test cases for Reset & Send Password functionality
Resource    ../../Resources/PageObject/UserPage/UpdateUserPage.robot
Resource    ../../Resources/PageObject/UserPage/ChangeStatusUserPage.robot

*** Test Cases ***
Verify the system Change Status User successfully
    [Documentation]    Change Status User successfully
    [Tags]    regression    change_status    positive    active/deactive
    Given Go To User Detail on User Page
    When Change Activate/Deactivate on Change Status Tab
    And Click Submit button and wait for response change status user successfully
    Then Verify Sucessfully Message For Change Status successfully
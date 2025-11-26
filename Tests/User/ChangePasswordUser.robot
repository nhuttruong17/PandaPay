*** Settings ***
Documentation    Test cases for Change Password User functionality
Resource    ../../Resources/PageObject/UserPage/ChangePasswordUserPage.robot

*** Test Cases ***
# Check validation empty Password error on Change Password User Page
#     [Documentation]    Verify validation message for empty Password on Change Password User form
#     [Tags]    validation    create_user
#     Given Go to Change Password User Page
#     And Click on Element     ${CHANGE_PASSWORD_SUBMIT}
#     Then Verify Error Message For Empty Password
#     #Waiting Dev to fix bug validation message 'Confirm password is required' => 'Password is required'

Check validation min Password error on Create User Page
    [Documentation]    Verify validation message for Password less than minimum length on Create User form
    [Tags]    validation    create_user
    Given Go to Change Password User Page
    When Input New Password    AAAAAAA
    And Click on Element     ${CHANGE_PASSWORD_SUBMIT}
    Then Verify Error Message For Min Password

Check validation missing uppercase Password error on Create User Page
    [Documentation]    Verify validation message for Password missing uppercase letter on Create User form
    [Tags]    validation    create_user
    Given On screen Change Password User Page
    When Input New Password    abcdefg1!
    And Click on Element    ${CHANGE_PASSWORD_SUBMIT}
    Then Verify Error Message For Missing Uppercase Password

Check validation missing lowercase Password error on Create User Page
    [Documentation]    Verify validation message for Password missing lowercase letter on Create User form
    [Tags]    validation    create_user
    Given On screen Change Password User Page
    When Input New Password    ABCDEFG1!
    And Click on Element    ${CHANGE_PASSWORD_SUBMIT}
    Then Verify Error Message For Missing Lowercase Password

Check validation missing number Password error on Create User Page
    [Documentation]    Verify validation message for Password missing number on Create User form
    [Tags]    validation    create_user
    Given On screen Change Password User Page
    When Input New Password    Abcdefgh!
    And Click on Element    ${CHANGE_PASSWORD_SUBMIT}
    Then Verify Error Message For Missing Number Password

Check validation missing special character Password error on Create User Page
    [Documentation]    Verify validation message for Password missing special character on Create User form
    [Tags]    validation    create_user
    Given On screen Change Password User Page
    When Input New Password    Abcdefg1
    And Click on Element    ${CHANGE_PASSWORD_SUBMIT}
    Then Verify Error Message For Missing Special Character Password

# Check validation empty Confirm Password error on Create User Page
#     [Documentation]    Verify validation message for empty Confirm Password on Create User form
#     [Tags]    validation    create_user
#     Given On screen Change Password User Page
#     When Click on Element    ${CHANGE_PASSWORD_SUBMIT}
#     Then Verify Error Message For Empty Confirm Password
    #Waiting Dev to fix bug validation message 'Confirm password must be at least 8 characters.' => 'Confirm password is required'

Check validation mismatch Confirm Password error on Create User Page
    [Documentation]    Verify validation message for Confirm Password mismatch on Create User form
    [Tags]    validation    create_user
    Given On screen Change Password User Page
    When Input New Password    Abcdefg1!
    And Input Confirm New Password    Different1!
    And Click on Element    ${CHANGE_PASSWORD_SUBMIT}
    Then Verify Error Message For Mismatch Confirm Password
    [Teardown]    Close Browser

Verify Change Password User successfully
    [Documentation]    Verify Change Password User successfully
    [Tags]    change_password    positive
    Given Go to Change Password User Page
    When Input New Password    ${new_password}
    And Input Confirm New Password    ${new_password}
    And Click Submit button and wait for response change password user successfully
    Then Verify Change Password Successfully
    [Teardown]    Close Browser
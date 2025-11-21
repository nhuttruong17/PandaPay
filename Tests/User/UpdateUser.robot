*** Settings ***
Documentation    Test cases for Update User functionality
Resource    ../../Resources/PageObject/UserPage/UpdateUserPage.robot

*** Test Cases ***
# Check validation empty First Name error on Create User Page
#     [Documentation]    Verify validation message for empty First Name on Create User form
#     [Tags]    validation    create_user
#     Given Go To Update User Page
#     Sleep    5s
#     SeleniumLibrary.Wait Until Element Is Visible    ${FIRST_NAME_INPUT}    10s
#     SeleniumLibrary.Click Element    ${FIRST_NAME_INPUT}
#     SeleniumLibrary.Clear Element Text    ${FIRST_NAME_INPUT}
#     Input First Name    A
#     And Click on Element    ${UPDATE_USER_SUBMIT}
#     SeleniumLibrary.Clear Element Text    ${FIRST_NAME_INPUT}
#     Then Verify Error Message For Empty First Name

Check validation min First Name error on Create User Page
    [Documentation]    Verify validation message for First Name less than minimum length on Create User form
    [Tags]    validation    create_user
    Given Go To Update User Page
    When Input First Name    A
    And Click on Element    ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Min First Name

Check validation max First Name error on Create User Page
    [Documentation]    Verify validation message for First Name more than maximum length on Create User form
    [Tags]    validation    create_user
    Given On screen Update User Page
    When Input First Name    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    And Click on Element    ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Max First Name

Check the system not display validation error message for valid First Name on Create User Page
    [Documentation]    Verify no validation message for valid First Name on Create User form
    [Tags]    validation    create_user
    Given On screen Update User Page
    When Input First Name   ${Gen_Firstname}
    Then Verify No Error Message For Valid First Name

### Check validation empty Last Name error on Create User Page
#     [Documentation]    Verify validation message for empty Last Name on Create User form
#     [Tags]    validation    create_user
#     Given On screen Update User Page
#     When Input Last Name    ${EMPTY}
#     Sleep    5s
#     When Click on Element    ${UPDATE_USER_SUBMIT}
#     Then Verify Error Message For Empty Last Name

Check validation min Last Name error on Create User Page        
    [Documentation]    Verify validation message for Last Name less than minimum length on Create User form
    [Tags]    validation    create_user
    Given On screen Update User Page
    When Input Last Name    A
    And Click on Element    ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Min Last Name

Check validation max Last Name error on Create User Page
    [Documentation]    Verify validation message for Last Name more than maximum length on Create User form
    [Tags]    validation    create_user
    Given On screen Update User Page
    When Input Last Name    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    And Click on Element    ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Max Last Name

Check the system not display validation error message for valid Last Name on Create User Page
    [Documentation]    Verify no validation message for valid Last Name on Create User form
    [Tags]    validation    create_user
    Given On screen Update User Page
    When Input Last Name    ${Gen_Lastname}
    Then Verify No Error Message For Valid Last Name

### Check validation empty Email error on Create User Page
#     [Documentation]    Verify validation message for empty Email on Create User form
#     [Tags]    validation    create_user
#     Given On screen Update User Page
#     When Click on Element    ${UPDATE_USER_SUBMIT}
#     Then Verify Error Message For Empty Email

Check validation invalid Email error on Create User Page
    [Documentation]    Verify validation message for invalid Email on Create User form
    [Tags]    validation    create_user
    Given On screen Update User Page
    When Input Email    invalid.email
    And Click on Element    ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Invalid Email

Check the system not display validation error message for valid Email on Create User Page
    [Documentation]    Verify no validation message for valid Email on Create User form
    [Tags]    validation    create_user
    Given On screen Update User Page
    When Input Email    ${Gen_Email}
    Then Verify No Error Message For Valid Email

Check validation invalid Phone Number error on Create User Page
    [Documentation]    Verify validation message for invalid Phone Number on Create User form
    [Tags]    validation    create_user
    Given On screen Update User Page
    When Input Phone Number    456
    And Click on Element    ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Invalid Phone Number

Check the system not display validation error message for valid Phone Number on Create User Page
    [Documentation]    Verify no validation message for valid Phone Number on Create User form
    [Tags]    validation    create_user
    Given On screen Update User Page
    When Input Phone Number    ${Gen_Phonenumber}
    Then Verify No Error Message For Valid Phone Number

Check validation min Address error on Create User Page
    [Documentation]    Verify validation message for Address less than minimum length on Create User form
    [Tags]    validation    create_user
    Given On screen Update User Page
    When Input Address    abc
    And Click on Element     ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Min Address

Check validation max Address error on Create User Page
    [Documentation]    Verify validation message for Address more than maximum length on Create User form
    [Tags]    validation    create_user
    Given On screen Update User Page
    When Input Address    aadsasdaskljadsnrjansedfjansdjfnadjklsfnalsdnfaklsfmnasknfaklsfjnaksjfaklsdfjaklsfjaklaaaacfascadfsncadfsnjklcfjlnadfjlscncladfjscnafjsklcnjkladfscnjkladfscnadfsjklccnadfsjklcnklafjscnadfsjlnjlcfadsjlnacdfsijlnacdfsnacdfsnjlacdsfjlncafsnjlacfsjlncadfskladfsiuadfsguyguhadfsghjghjhj
    And Click on Element     ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Max Address

Check the system not display validation error message for valid Address on Create User Page
    [Documentation]    Verify no validation message for valid Address on Create User form    
    [Tags]    validation    create_user
    Given On screen Update User Page
    When Input Address    ${VALID_ADDRESS}
    Then Verify No Error Message For Valid Address

Update User With Existing Email
    [Documentation]    Verify user cannot update profile with existing email
    [Tags]    regression    update_user    negative
    Given On screen Update User Page
    When User Input Information with Existing Existing Email
    And Click Submit button and wait for response Existing Email
    Then Verify Error Message For Existing Email

Update User With Existing Phone Number
    [Documentation]    Verify user cannot update profile with existing phone number
    [Tags]    regression    update_user    negative
    Given On screen Update User Page
    When User Input Information with Existing Phone Number
    And Click Submit button and wait for response Existing Phone Number
    Then Verify Error Message For Existing Phone Number
    [Teardown]    Close Browser

Update User With Valid Information
    [Documentation]    Verify user can update profile with valid information
    [Tags]    regression    update_user    positive
    Given Go To Update User Page
    When User Input Valid Information for New User
    And Click Submit button and wait for response update user successfully
    Then Verify Sucessfully Message For Update User
    [Teardown]    Close Browser
*** Settings ***
Documentation    Test cases for Create User functionality
Resource    ../../Resources/PageObject/UserPage/CreateUserPage.robot

*** Test Cases ***
# Check validation empty UserID error on Create User Page
#     [Documentation]    Verify validation message for empty UserID on Create User form
#     [Tags]    validation    create_user
#     Given Open Browser To Create User Page
#     Input User ID        ${EMPTY}
#     When Click on Element    ${CREATE_USER_SUBMIT}
#     Then Verify Error Message For Empty User ID

Check validation min UserID error on Create User Page
    [Documentation]    Verify validation message for UserID less than minimum length on Create User form
    [Tags]    validation    create_user
    Given Open Browser To Create User Page
    When Input User ID        user1
    And Click on Element    ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Min User ID

# Check validation max UserID error on Create User Page
#     [Documentation]    Verify validation message for UserID more than maximum length on Create User form
#     [Tags]    validation    create_user
#     Given On screen Create User Page
#     When Input User ID    user1234567890123456789012345
#     And Click on Element    ${CREATE_USER_SUBMIT}
#     Then Verify Error Message For Max User ID

Check the system not display validation error message for valid UserID on Create User Page
    [Documentation]    Verify no validation message for valid UserID on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input User ID        ${Data_UserID}
    Then Verify No Error Message For Valid User ID

Check validation empty First Name error on Create User Page
    [Documentation]    Verify validation message for empty First Name on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Click on Element    ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Empty First Name

Check validation min First Name error on Create User Page
    [Documentation]    Verify validation message for First Name less than minimum length on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input First Name    A
    And Click on Element    ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Min First Name

Check validation max First Name error on Create User Page
    [Documentation]    Verify validation message for First Name more than maximum length on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input First Name    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    And Click on Element    ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Max First Name

Check the system not display validation error message for valid First Name on Create User Page
    [Documentation]    Verify no validation message for valid First Name on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input First Name        ${Gen_Firstname}
    Then Verify No Error Message For Valid First Name

# Check validation empty Last Name error on Create User Page
#     [Documentation]    Verify validation message for empty Last Name on Create User form
#     [Tags]    validation    create_user
#     Given On screen Create User Page
#     When Click on Element    ${CREATE_USER_SUBMIT}
#     Then Verify Error Message For Empty Last Name
#     [Teardown]    Close Browser

Check validation min Last Name error on Create User Page        
    [Documentation]    Verify validation message for Last Name less than minimum length on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Last Name    A
    And Click on Element    ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Min Last Name

Check validation max Last Name error on Create User Page
    [Documentation]    Verify validation message for Last Name more than maximum length on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Last Name    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    And Click on Element    ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Max Last Name

Check the system not display validation error message for valid Last Name on Create User Page
    [Documentation]    Verify no validation message for valid Last Name on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Last Name        ${Gen_Lastname}
    Then Verify No Error Message For Valid Last Name

# Check validation empty Email error on Create User Page
#     [Documentation]    Verify validation message for empty Email on Create User form
#     [Tags]    validation    create_user
#     Given On screen Create User Page
#     When Click on Element    ${CREATE_USER_SUBMIT}
#     Then Verify Error Message For Empty Email

Check validation invalid Email error on Create User Page
    [Documentation]    Verify validation message for invalid Email on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Email    invalid.email
    And Click on Element    ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Invalid Email

Check the system not display validation error message for valid Email on Create User Page
    [Documentation]    Verify no validation message for valid Email on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Email    ${Gen_Email}
    Then Verify No Error Message For Valid Email

Check validation invalid Phone Number error on Create User Page
    [Documentation]    Verify validation message for invalid Phone Number on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Phone Number    456
    And Click on Element    ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Invalid Phone Number

Check the system not display validation error message for valid Phone Number on Create User Page
    [Documentation]    Verify no validation message for valid Phone Number on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Phone Number    ${Gen_Phonenumber}
    Then Verify No Error Message For Valid Phone Number

Check validation min Address error on Create User Page
    [Documentation]    Verify validation message for Address less than minimum length on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Address    abc
    And Click on Element     ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Min Address

Check validation max Address error on Create User Page
    [Documentation]    Verify validation message for Address more than maximum length on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Address    aadsasdaskljadsnrjansedfjansdjfnadjklsfnalsdnfaklsfmnasknfaklsfjnaksjfaklsdfjaklsfjaklaaaacfascadfsncadfsnjklcfjlnadfjlscncladfjscnafjsklcnjkladfscnjkladfscnadfsjklccnadfsjklcnklafjscnadfsjlnjlcfadsjlnacdfsijlnacdfsnacdfsnjlacdsfjlncafsnjlacfsjlncadfskladfsiuadfsguyguhadfsghjghjhj
    And Click on Element     ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Max Address

Check the system not display validation error message for valid Address on Create User Page
    [Documentation]    Verify no validation message for valid Address on Create User form    
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Address    ${VALID_ADDRESS}
    Then Verify No Error Message For Valid Address

Check User select role
    [Documentation]    Verify user can select role from dropdown
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Select User Role

# Check validation empty Password error on Create User Page
#     [Documentation]    Verify validation message for empty Password on Create User form
#     [Tags]    validation    create_user
#     Given On screen Create User Page
#     When Click on Element    ${CREATE_USER_SUBMIT}
#     Then Verify Error Message For Empty Password

Check validation min Password error on Create User Page
    [Documentation]    Verify validation message for Password less than minimum length on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    # Scroll To Bottom
    When Input Password Web    AAAAAAA
    And Click on Element     xpath=/html/body/div[1]/div/main/div/div/form/button
    Then Verify Error Message For Min Password

Check validation missing uppercase Password error on Create User Page
    [Documentation]    Verify validation message for Password missing uppercase letter on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Password Web    abcdefg1!
    And Click on Element    ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Missing Uppercase Password

Check validation missing lowercase Password error on Create User Page
    [Documentation]    Verify validation message for Password missing lowercase letter on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Password Web    ABCDEFG1!
    And Click on Element    ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Missing Lowercase Password

Check validation missing number Password error on Create User Page
    [Documentation]    Verify validation message for Password missing number on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Password Web    Abcdefgh!
    And Click on Element    ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Missing Number Password

Check validation missing special character Password error on Create User Page
    [Documentation]    Verify validation message for Password missing special character on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Password Web    Abcdefg1
    And Click on Element    ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Missing Special Character Password

Check validation empty Confirm Password error on Create User Page
    [Documentation]    Verify validation message for empty Confirm Password on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Click on Element    ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Empty Confirm Password

Check validation mismatch Confirm Password error on Create User Page
    [Documentation]    Verify validation message for Confirm Password mismatch on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Password Web    Abcdefg1!
    And Input Confirm Password    Different1!
    And Click on Element    ${CREATE_USER_SUBMIT}
    Then Verify Error Message For Mismatch Confirm Password
    [Teardown]    Close Browser

Create User With Existing UserID
    [Documentation]    Verify error message for duplicate information user
    [Tags]    regression    create_user    negative
    Given Open Browser To Create User Page
    When User Input Information with Existing User ID
    And Click Submit button and wait for response Existing UserID
    Then Verify Error Message For Existing User ID
    [Teardown]    Close Browser

Create User With Existing Email
    [Documentation]    Verify error message for duplicate information user
    [Tags]    regression    create_user    negative
    Given Open Browser To Create User Page
    When User Input Information with Existing Existing Email
    And Click Submit button and wait for response Existing Email
    Then Verify Error Message For Existing Email
    [Teardown]    Close Browser

Create User With Existing Phone Number
    [Documentation]    Verify error message for duplicate information user
    [Tags]    regression    create_user    negative
    Given Open Browser To Create User Page
    When User Input Information with Existing Phone Number
    And Click Submit button and wait for response Existing Phone Number
    Then Verify Error Message For Existing Phone Number
    [Teardown]    Close Browser

Create User With Valid Information
    [Documentation]    Verify user can be created with valid information
    [Tags]    regression    create_user    positive
    Basic Setup
    Given Open Browser To Create User Page
    When User Input Valid Information for New User
    And Click Submit button and wait for response create user successfully
    Then Verify Sucessfully Message For Create User
    [Teardown]    Close Browser
*** Settings ***
Documentation    Test cases for Update User functionality
Resource    ../../Resources/PageObject/UserPage/UpdateUserPage.robot
Resource    ../../TestData/Browser/Global.robot
Resource    ../../TestKeyWords/Common.robot
Resource    ../../Resources/PageObject/LoginPage/LoginPage.robot
Resource    ../../TestData/LoginData/LoginData.robot
# Suite Setup     Basic Setup

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
    When Input First Name        John
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
    When Input Last Name        Doe
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
    When Input Email    john@yopmail.com
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
    When Input Phone Number    9977686223
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
    And Capture API 400
    Then Verify Error Message For Existing Email
    Sleep    2

Update User With Existing Phone Number
    [Documentation]    Verify user cannot update profile with existing phone number
    [Tags]    regression    update_user    negative
    Given On screen Update User Page
    When User Input Information with Existing Phone Number
    And Capture API 400
    Then Verify Error Message For Existing Phone Number
    Sleep    2
    [Teardown]    Close Browser

Update User With Valid Information
    [Documentation]    Verify user can update profile with valid information
    [Tags]    regression    update_user    positive
    Given Go To Update User Page
    When User Input Valid Information for New User
    And Capture API PUT
    Then Verify Sucessfully Message For Update User
    [Teardown]    Close Browser

*** Keywords ***
On screen Update User Page
    No Operation

Go To Update User Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_USER_BUTTON}
    Select User Random User From List
    Click on Element    ${UPDATE_USER_BUTTON}
    Sleep    5s

#First Name    
Verify Error Message For Empty First Name
    Check validation error message    xpath=//p[normalize-space(text())='First name is required.']    First name is required.    

Verify Error Message For Min First Name
    Check validation error message    xpath=//p[normalize-space(text())='First name must be at least 2 characters.']    First name must be at least 2 characters.

Verify Error Message For Max First Name
    Check validation error message    xpath=//p[normalize-space(text())='First name must be at most 50 characters.']    First name must be at most 50 characters.

Verify No Error Message For Valid First Name
    Page Should Not Contain    xpath=//p[normalize-space(text())='First name must be at most 50 characters.']    First name must be at most 50 characters.

#Last Name
Verify Error Message For Empty Last Name
    Check validation error message    xpath=//p[normalize-space(text())='The Last Name cannot be empty']    The Last Name cannot be empty    

Verify Error Message For Min Last Name
    Check validation error message    xpath=//p[normalize-space(text())='Last name must be at least 2 characters.']    Last name must be at least 2 characters.

Verify Error Message For Max Last Name
    Check validation error message    xpath=//p[normalize-space(text())='Last name must be at most 50 characters.']    Last name must be at most 50 characters.

Verify No Error Message For Valid Last Name
    Page Should Not Contain    xpath=//p[normalize-space(text())='Last name must be at most 50 characters.']    Last name must be at most 50 characters.

#Email
Verify Error Message For Empty Email
    Check validation error message    xpath=//p[normalize-space(text())='Email is required.']    Email is required.

Verify Error Message For Invalid Email
    Check validation error message    xpath=//p[normalize-space(text())='Not a valid email address.']    Not a valid email address.

Verify No Error Message For Valid Email
    Page Should Not Contain    xpath=//p[normalize-space(text())='Not a valid email address.']    Not a valid email address.

#Phone Number
Verify Error Message For Invalid Phone Number
    Check validation error message    xpath=//p[normalize-space(text())='Phone number must be 10 characters.']    Phone number must be 10 characters.

Verify No Error Message For Valid Phone Number
    Page Should Not Contain    xpath=//p[normalize-space(text())='Phone number must be 10 characters.']    Phone number must be 10 characters.

#Address
Verify Error Message For Min Address
    Check validation error message    xpath=//p[normalize-space(text())='Address must be at least 8 characters.']    Address must be at least 8 characters.

Verify Error Message For Max Address
    Check validation error message    xpath=//p[normalize-space(text())='Address must be at most 280 characters.']    Address must be at most 280 characters.

Verify No Error Message For Valid Address
    Page Should Not Contain    xpath=//p[normalize-space(text())='Address must be at most 280 characters.']    Address must be at most 280 characters.

#Input Information
User Input Information with Existing Existing Email
    # Input First Name     Nhut
    # Input Last Name      Minh
    Input Email     ${Email_exist}
    # Input Phone Number    9977686113
    # Input Date Of Birth    ${VALID_DOB}
    # Input Address    ${VALID_ADDRESS}


User Input Information with Existing Phone Number
    # Input First Name     Nhut
    # Input Last Name      Minh
    Input Email     minh1212@yopmail.com
    Input Phone Number    ${Phone_number_exist}
    # Input Date Of Birth    ${VALID_DOB}
    # Input Address    ${VALID_ADDRESS}
   
User Input Valid Information for New User
    Input First Name     When
    Input Last Name      What
    Input Email     what@yopmail.com
    Input Phone Number    9111688000
    Input Date Of Birth    ${VALID_DOB}
    Input Address    ${VALID_ADDRESS}

Verify Error Message For Existing Email
    Check validation error message    //div[@class="text-sm opacity-90"]    • Email already used

Verify Error Message For Existing Phone Number
    Check validation error message    //div[@class="text-sm opacity-90"]    • Phone number already used

Verify Sucessfully Message For Update User
    Check validation error message    //div[@class="text-sm opacity-90"]    User updated successfully.

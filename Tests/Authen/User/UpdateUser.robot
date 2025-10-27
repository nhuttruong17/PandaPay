*** Settings ***
Documentation    Test cases for Update User functionality
Resource    ../../../Resources/PageObject/UserPage/UpdateUserPage.robot
Resource    ../../../TestData/Browser/Global.robot
Resource    ../../../TestKeyWords/Common.robot
Resource    ../../../Resources/PageObject/LoginPage/LoginPage.robot
Resource    ../../../TestData/LoginData/LoginData.robot
# Suite Setup     Basic Setup

*** Test Cases ***
Check validation empty First Name error on Create User Page
    [Documentation]    Verify validation message for empty First Name on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Click on Element    ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Empty First Name

Check validation min First Name error on Create User Page
    [Documentation]    Verify validation message for First Name less than minimum length on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input First Name    A
    And Click on Element    ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Min First Name

Check validation max First Name error on Create User Page
    [Documentation]    Verify validation message for First Name more than maximum length on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input First Name    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    And Click on Element    ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Max First Name

Check the system not display validation error message for valid First Name on Create User Page
    [Documentation]    Verify no validation message for valid First Name on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input First Name        John
    Then Verify No Error Message For Valid First Name

# Check validation empty Last Name error on Create User Page
#     [Documentation]    Verify validation message for empty Last Name on Create User form
#     [Tags]    validation    create_user
#     Given On screen Create User Page
#     When Click on Element    ${UPDATE_USER_SUBMIT}
#     Then Verify Error Message For Empty Last Name
#     [Teardown]    Close Browser

Check validation min Last Name error on Create User Page        
    [Documentation]    Verify validation message for Last Name less than minimum length on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Last Name    A
    And Click on Element    ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Min Last Name

Check validation max Last Name error on Create User Page
    [Documentation]    Verify validation message for Last Name more than maximum length on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Last Name    AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    And Click on Element    ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Max Last Name

Check the system not display validation error message for valid Last Name on Create User Page
    [Documentation]    Verify no validation message for valid Last Name on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Last Name        Doe
    Then Verify No Error Message For Valid Last Name

# Check validation empty Email error on Create User Page
#     [Documentation]    Verify validation message for empty Email on Create User form
#     [Tags]    validation    create_user
#     Given On screen Create User Page
#     When Click on Element    ${UPDATE_USER_SUBMIT}
#     Then Verify Error Message For Empty Email

Check validation invalid Email error on Create User Page
    [Documentation]    Verify validation message for invalid Email on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Email    invalid.email
    And Click on Element    ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Invalid Email

Check the system not display validation error message for valid Email on Create User Page
    [Documentation]    Verify no validation message for valid Email on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Email    john@yopmail.com
    Then Verify No Error Message For Valid Email

Check validation invalid Phone Number error on Create User Page
    [Documentation]    Verify validation message for invalid Phone Number on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Phone Number    456
    And Click on Element    ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Invalid Phone Number

Check the system not display validation error message for valid Phone Number on Create User Page
    [Documentation]    Verify no validation message for valid Phone Number on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Phone Number    9977686113
    Then Verify No Error Message For Valid Phone Number

Check validation min Address error on Create User Page
    [Documentation]    Verify validation message for Address less than minimum length on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Address    abc
    And Click on Element     ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Min Address

Check validation max Address error on Create User Page
    [Documentation]    Verify validation message for Address more than maximum length on Create User form
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Address    aadsasdaskljadsnrjansedfjansdjfnadjklsfnalsdnfaklsfmnasknfaklsfjnaksjfaklsdfjaklsfjaklaaaacfascadfsncadfsnjklcfjlnadfjlscncladfjscnafjsklcnjkladfscnjkladfscnadfsjklccnadfsjklcnklafjscnadfsjlnjlcfadsjlnacdfsijlnacdfsnacdfsnjlacdsfjlncafsnjlacfsjlncadfskladfsiuadfsguyguhadfsghjghjhj
    And Click on Element     ${UPDATE_USER_SUBMIT}
    Then Verify Error Message For Max Address

Check the system not display validation error message for valid Address on Create User Page
    [Documentation]    Verify no validation message for valid Address on Create User form    
    [Tags]    validation    create_user
    Given On screen Create User Page
    When Input Address    ${VALID_ADDRESS}
    Then Verify No Error Message For Valid Address

Test Delete User
    Given Go To Delete User Page
    Sleep    10s
    Capture API Delete
    Sleep    10s
    [Teardown]    Close Browser


Update User With Valid Information
    [Documentation]    Verify user can update profile with valid information
    [Tags]    regression    update_user    positive
    Given Go To Update User Page
    Sleep    10s
    # Sleep    s
    # Clear Element Text    //input[@id='first_name ']
    # Input First Name     Nobita
    # Sleep    3s
    # Input Last Name      Minh
    # Sleep    3s
    # Input Email    ${Email_exist}
    # Sleep    3s
    Clear Element Text    //input[@placeholder='Enter phone number']
    Input Phone Number    ${Phone_number_exist}
    # Sleep    3s
    # Input Date Of Birth    11-10-2025
    # Sleep    3s
    # Input Address    This is a test adreesssssss
    Capture API PUT
    Sleep    10s
    # When Input First Name    Nhut
    # And Input Last Name    Minh
    # And Input Email    minh_update@yopmail.com
    # And Input Phone Number    9977689999
    # And Input Address    1 Updated Street
    # And Click Update Submit
    # Then Verify Update Success
    [Teardown]    Close Browser

Update User With Invalid Email
    [Documentation]    Verify validation when updating user with invalid email
    [Tags]    validation    update_user    negative
    Given Go To Update User Page
    When Input Email    invalid.email
    And Click Update Submit
    Then Check validation error message    //p[normalize-space(text())='Not a valid email address.']    Not a valid email address.
    [Teardown]    Close Browser

*** Keywords ***
Go To Update User Page
    # Open a browser/session for the test
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_USER_BUTTON}
    Select User Random User From List
    Click on Element    ${UPDATE_USER_BUTTON}


Go To Delete User Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_USER_BUTTON}
    Select User Random User From List
    Click on Element    xpath=//p[normalize-space()='Delete User']

On screen Create User Page
    No Operation

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
    Input User ID        School11122
    Input First Name     Nhut
    Input Last Name      Minh
    Input Email     ${Email_exist}
    Input Phone Number    9977686113
    Input Date Of Birth    ${VALID_DOB}
    Input Address    ${VALID_ADDRESS}


User Input Information with Existing Phone Number
    Input User ID        School11333
    Input First Name     Nhut
    Input Last Name      Minh
    Input Email     minh1212@yopmail.com
    Input Phone Number    ${Phone_number_exist}
    Input Date Of Birth    ${VALID_DOB}
    Input Address    ${VALID_ADDRESS}
   
User Input Valid Information for New User
    Input User ID        Spiderman
    Input First Name     Man
    Input Last Name      Root
    Input Email     spider@yopmail.com
    Input Phone Number    9111681903
    Input Date Of Birth    ${VALID_DOB}
    Input Address    ${VALID_ADDRESS}


Verify Error Message For Existing Email
    Check validation error message    //div[@class="text-sm opacity-90"]    • Email already used

Verify Error Message For Existing Phone Number
    Check validation error message    //div[@class="text-sm opacity-90"]    • Phone number already used

Verify Sucessfully Message For Create User
    Check validation error message    //div[@class="text-sm opacity-90"]    User created successfully.

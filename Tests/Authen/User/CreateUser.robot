*** Settings ***
Documentation    Test cases for Create User functionality
Resource    ../../../Resources/PageObject/CreateUserPage/CreateUserPage.robot
Resource    ../../../TestData/Browser/Global.robot
Resource    ../../../TestKeyWords/Common.robot
Resource    ../../../Resources/PageObject/LoginPage/LoginPage.robot
Resource    ../../../TestData/LoginData/LoginData.robot
# Suite Setup     Basic Setup
Library     FakerLibrary
*** Test Cases ***
# Save Session After Login (profile)
#     [Documentation]    Login once using a Chrome profile and close browser (profile will keep session)
#     [Tags]    session    save
#     # Open Browser To Create User Page
#     Fill Text Input    ${input_UserID}    ${Valid_UserID}
#     Fill Text Input    ${input_Password}    ${Valid_Password}
#     Click on SignIn with Wait Response login successfully
#     Save Browser Session
#     [Teardown]    Close Browser

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
    When Input User ID        School1234
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
    When Input First Name        John
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
    When Input Last Name        Doe
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
    When Input Email    john@yopmail.com
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
    When Input Phone Number    9977686113
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
    # Then Verify User Role Selected Successfully

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

# Create User With Valid Information
#     [Documentation]    Verify user can be created with valid information
#     [Tags]    regression    create_user    positive
#     Basic Setup
#     Given Open Browser To Create User Page
#     When User Input Valid Information for New User
#     And Click Submit button and wait for response create user successfully
#     Then Verify Sucessfully Message For Create User
#     [Teardown]    Close Browser

*** Keywords ***
Open Browser To Create User Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_USER_BUTTON}
    Click on Element    ${CREATE_USER_BUTTON}

On screen Create User Page
    No Operation

#UserID
Verify Error Message For Empty User ID
    Check validation error message    xpath=//p[normalize-space(text())='User ID is required.']    User ID is required.

Verify Error Message For Min User ID
    Check validation error message    xpath=//p[normalize-space(text())='User ID must be at least 8 characters.']    User ID must be at least 8 characters.    

Verify Error Message For Max User ID
    Check validation error message    xpath=//p[normalize-space(text())='User ID must be at most 20 characters.']    User ID must be at most 20 characters.    

Verify No Error Message For Valid User ID
    Page Should Not Contain    xpath=//p[normalize-space(text())='User ID must be at least 8 characters.']    User ID must be at least 8 characters.
    
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



#Password
Verify Error Message For Empty Password
    Check validation error message    xpath=//p[normalize-space(text())='Password is required.']    Password is required.

Verify Error Message For Min Password
    Check validation error message    xpath=//p[normalize-space(text())='Password must be at least 8 characters.']    Password must be at least 8 characters.

Verify Error Message For Missing Uppercase Password
    Check validation error message    xpath=//p[normalize-space(text())='Password must contain at least one uppercase letter.']    Password must contain at least one uppercase letter.   

Verify Error Message For Missing Lowercase Password
    Check validation error message    xpath=//p[normalize-space(text())='Password must contain at least one lowercase letter.']    Password must contain at least one lowercase letter.    

Verify Error Message For Missing Number Password
    Check validation error message    xpath=//p[normalize-space(text())='Password must contain at least one number.']    Password must contain at least one number.

Verify Error Message For Missing Special Character Password
    Check validation error message    xpath=//p[normalize-space(text())='Password must contain at least one special character.']    Password must contain at least one special character.

Verify Error Message For Empty Confirm Password
    Check validation error message    xpath=//p[normalize-space(text())='Confirm password is required.']    Confirm password is required.

Verify Error Message For Mismatch Confirm Password
    Check validation error message    xpath=//p[normalize-space(text())='Passwords do not match.']    Passwords do not match.

#Input Information
User Input Information with Existing User ID
    Input User ID        ${UserID_exist}
    Input First Name     Nhut
    Input Last Name      Minh
    Input Email     minh2@yopmail.com
    Input Phone Number    9977686113
    Input Date Of Birth    ${VALID_DOB}
    Input Address    ${VALID_ADDRESS}
    Scroll To Bottom
    
    Select User Role
    
    Input Password Web         ${VALID_New_User_PASSWORD}
    Input Confirm Password     ${VALID_CONFIRM_PASSWORD}
    # Set Account Status    Active 
    # Select Language    English
    # Select Organization    Default Organization

User Input Information with Existing Existing Email
    Input User ID        School11122
    Input First Name     Nhut
    Input Last Name      Minh
    Input Email     minh@yopmail.com
    Input Phone Number    9977686113
    Input Date Of Birth    ${VALID_DOB}
    Input Address    ${VALID_ADDRESS}
    Scroll To Bottom
    
    Select User Role
    
    Input Password Web         ${VALID_New_User_PASSWORD}
    Input Confirm Password     ${VALID_CONFIRM_PASSWORD}

User Input Information with Existing Phone Number
    Input User ID        School11333
    Input First Name     Nhut
    Input Last Name      Minh
    Input Email     minh1212@yopmail.com
    Input Phone Number    9977686888
    Input Date Of Birth    ${VALID_DOB}
    Input Address    ${VALID_ADDRESS}
    Scroll To Bottom
    Select User Role
    Input Password Web         ${VALID_New_User_PASSWORD}
    Input Confirm Password     ${VALID_CONFIRM_PASSWORD}

User Input Valid Information for New User
    Input User ID        School2025
    Input First Name     Nhut
    Input Last Name      Minh
    Input Email     minh25@yopmail.com
    Input Phone Number    9977682025
    Input Date Of Birth    ${VALID_DOB}
    Input Address    ${VALID_ADDRESS}
    Scroll To Bottom

    Select User Role

    Input Password Web         ${VALID_New_User_PASSWORD}
    Input Confirm Password     ${VALID_CONFIRM_PASSWORD}


Verify Error Message For Existing User ID
    Check validation error message    //div[@class="text-sm opacity-90"]    • User ID code already exists


Verify Error Message For Existing Email
    Check validation error message    //div[@class="text-sm opacity-90"]    • Email already used

Verify Error Message For Existing Phone Number
    Check validation error message    //div[@class="text-sm opacity-90"]    • Phone number already used

Verify Sucessfully Message For Create User
    Check validation error message    //div[@class="text-sm opacity-90"]    User created successfully.






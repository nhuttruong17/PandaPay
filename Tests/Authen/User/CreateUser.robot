*** Settings ***
Documentation    Test cases for Create User functionality
Resource    ../../../Resources/PageObject/CreateUserPage/CreateUserPage.robot
Resource    ../../../TestData/Browser/Global.robot
Resource    ../../../TestKeyWords/Common.robot
Resource    ../../../Resources/PageObject/LoginPage/LoginPage.robot
Resource    ../../../TestData/LoginData/LoginData.robot
Suite Setup     Basic Setup

*** Test Cases ***

Save Session After Login (profile)
    [Documentation]    Login once using a Chrome profile and close browser (profile will keep session)
    [Tags]    session    save
    Open Browser To Create User Page
    Fill Text Input    ${input_UserID}    ${Valid_UserID}
    Fill Text Input    ${input_Password}    ${Valid_Password}
    Click on SignIn with Wait Response login successfully
    Save Browser Session    .session/my_user
    [Teardown]    Close Browser






# Create User With Empty Required Fields
#     [Documentation]    Verify error messages for empty required fields
#     [Tags]    regression    create_user    negative
#     Open Browser To Create User Page
#     # Click Create User Button
#     Verify Error Message For Empty User ID
#     Verify Error Message For Empty First Name
#     Verify Error Message For Empty Last Name
#     Verify Error Message For Empty Email
#     Verify Error Message For Empty Password
#     [Teardown]    Close Browser

# Create User With Invalid Email Format
#     [Documentation]    Verify error message for invalid email format
#     [Tags]    regression    create_user    negative
#     Open Browser To Create User Page
#     Input User ID    ${VALID_USER_ID}
#     Input First Name    ${VALID_FIRST_NAME}
#     Input Last Name    ${VALID_LAST_NAME}
#     Input Email    invalid.email
#     Input Password Web    ${VALID_PASSWORD}
#     Input Confirm Password    ${VALID_CONFIRM_PASSWORD}
#     # Click Create User Button
#     Verify Error Message For Invalid Email Format
#     [Teardown]    Close Browser

# Create User With Password Mismatch
#     [Documentation]    Verify error message for password mismatch
#     [Tags]    regression    create_user    negative
#     Open Browser To Create User Page
#     Input User ID    ${VALID_USER_ID}
#     Input First Name    ${VALID_FIRST_NAME}
#     Input Last Name    ${VALID_LAST_NAME}
#     Input Email    ${VALID_EMAIL}
#     Input Password Web    ${VALID_PASSWORD}
#     Input Confirm Password    different_password
#     # Click Create User Button
#     Verify Error Message For Password Mismatch
#     [Teardown]    Close Browser

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
    Given Open Browser To Create User Page
    When User Input Valid Information for New User
    And Click Submit button and wait for response create user successfully
    Then Verify Sucessfully Message For Create User
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Create User Page
    Restore Browser Session    .session/my_user
    Click on Element    ${Tab_USER_BUTTON}
    Click on Element    ${CREATE_USER_BUTTON}

Verify Error Message For Empty User ID
    Page Should Contain    User ID is required

Verify Error Message For Empty First Name
    Page Should Contain    First Name is required

Verify Error Message For Empty Last Name
    Page Should Contain    Last Name is required

Verify Error Message For Empty Email
    Page Should Contain    Email is required

Verify Error Message For Empty Password
    Page Should Contain    Password is required

Verify Error Message For Invalid Email Format
    Page Should Contain    Invalid email format

Verify Error Message For Password Mismatch
    Page Should Contain    Passwords do not match


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

# Open Browser With Profile
#     [Arguments]    ${profile_name}=my_user
#     ${profile_dir}=    Set Variable    ${CURDIR}/../../.chrome_profiles/${profile_name}
#     Run Keyword If    "${profile_dir}" == ""    Create Directory    ${profile_dir}
#     Evaluate    __import__('os').makedirs(r'''${profile_dir}''', exist_ok=True)    modules=os
#     ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
#     Call Method    ${options}    add_argument    --user-data-dir=${profile_dir}
#     Open Browser    ${BASE_URL}    ${CHROME_BROWSER}    options=${options}
#     Maximize Browser Window







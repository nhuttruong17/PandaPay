*** Settings ***
Resource        ../../../Resources/PageObject/LoginPage/LoginPage.robot
Resource        ../../../TestData/LoginData/LoginData.robot
Library         DataDriver     /Users/apple/Downloads/School/PycharmProjects/PandaPay/Tests/Authen/Data_driven/Signin.csv
Library         SeleniumLibrary
Suite Setup     Basic Setup
Test Template   Login with invalid credentials should fail

*** Test Cases ***
CSV Template Tests
    ${username}    ${password}    ${expected_error}    ${action}

Manual Login Test
    [Template]    NONE
    Verify login failed with invalid account    ${Valid_UserID}    ${Invalid_Password}    ${EXPECTED_ERROR_MESSAGE}

*** Keywords ***
Verify login failed with invalid account
    [Arguments]    ${userid}    ${pass}    ${expected}
    Given Fill Text Input  ${input_UserID}   ${userid}
    And Fill Text Input  ${input_Password}   ${pass}
    When Click on SignIn with Wait Request Payload login Failed
    Then Check validation error message    ${elm_error_message}    ${expected}
    [Teardown]    Basic TearDowns


Login with invalid credentials should fail
    [Arguments]    ${username}    ${password}    ${expected_error}    ${action}
    # Fill fields first
    Fill Text Input  ${input_UserID}   ${username}
    Fill Text Input  ${input_Password}   ${password}
    # Dispatch to specific verification keyword based on CSV 'action'
    Run Keyword If    '${action}' == 'verify_login_failed'    Verify login failed with invalid account    ${username}    ${password}    ${expected_error}
    ...    ELSE IF    '${action}' == 'verify_login_failed_with_payload'    Verify login failed with payload    ${username}    ${password}    ${expected_error}
    ...    ELSE    Fail    Unknown action '${action}'


Verify login failed with payload
    [Arguments]    ${userid}    ${pass}    ${expected}
    Given Fill Text Input  ${input_UserID}   ${userid}
    And Fill Text Input  ${input_Password}   ${pass}
    # Use payload-specific click if exists; otherwise reuse generic click
    When Click on SignIn with Wait Request Payload login Failed
    Then Check validation error message    ${elm_error_message}    ${expected}
    [Teardown]    Basic TearDowns


# /Users/apple/Downloads/School/PycharmProjects/PandaPay/Tests/Authen/Data_driven/Signin.csv
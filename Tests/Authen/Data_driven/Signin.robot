*** Settings ***
Resource        ../../../Resources/PageObject/LoginPage/LoginPage.robot
Resource        ../../../TestData/LoginData/LoginData.robot
Library         DataDriver     
Library         DataDriver     /Users/apple/Downloads/School/PycharmProjects/PandaPay/Tests/Authen/Data_driven/Signin.csv
Library         SeleniumLibrary
Suite Setup     Basic Setup
Test Template   Login with invalid credentials should fail

*** Test Cases ***
1. CSV Template Tests  ${username}    ${password}    ${expected_error}
    
2.Login test         [Template]    Verify login failed with invalid account
                    ${Valid_UserID}    ${Invalid_Password}    ${EXPECTED_ERROR_MESSAGE}

# 2. Manual Login Test
#     [Documentation]    Execute specific test case with predefined data
#     ...    This will run second because of the "2." prefix
#     [Template]    NONE
#     Verify login failed with invalid account    ${Valid_UserID}    ${Invalid_Password}    ${EXPECTED_ERROR_MESSAGE}
*** Keywords ***
Login with invalid credentials should fail
    [Arguments]    ${username}    ${password}    ${expected_error}
    Fill Text Input  ${input_UserID}   ${username}
    Fill Text Input  ${input_Password}   ${password}
    SeleniumLibrary.Wait Until Element Is Visible    ${expected_error}   10s

Verify login failed with invalid account
    [Arguments]    ${userid}    ${pass}    ${expected}
    Given Fill Text Input  ${input_UserID}   ${userid}
    And Fill Text Input  ${input_Password}   ${pass}
    When Click on SignIn with Wait Request Payload login Failed
    Then Check validation error message    ${elm_error_message}    ${expected}
    [Teardown]    Basic TearDowns


# /Users/apple/Downloads/School/PycharmProjects/PandaPay/Tests/Authen/Data_driven/Signin.csv
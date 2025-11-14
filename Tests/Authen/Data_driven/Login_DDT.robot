*** Settings ***
Resource        ../../../Resources/PageObject/LoginPage/LoginPage.robot
Resource        ../../../TestData/LoginData/LoginData.robot
Suite Setup     Basic Setup
Suite Teardown  Basic TearDowns
Test Template   Validation text error message

*** Test Cases ***                                    Username                            Password                      Expected Result
# Empty UserID                                          ${Empty_textUserID}                 ${Valid_Password}             ${error_empty_UserID}
Special characters UserID                             ${Specialcharacters_textUserID}     ${Valid_Password}             ${error_invalid_UserID}
Min UserID                                            ${Min_textUserID}                   ${Valid_Password}             ${error_min_UserID}
Max UserID                                            ${Max_textUserID}                   ${Valid_Password}             ${error_max_UserID}
Valid UserId, Ivalid Password                         [Template]       Verify login failed with invalid account
                                                      ${Valid_UserID}                     ${Invalid_Password}           ${EXPECTED_ERROR_MESSAGE}    


*** Keywords ***
Validation text error message
    [Arguments]    ${username}    ${password}    ${expected_error}
    Fill Text Input  ${input_UserID}   ${username}
    Fill Text Input  ${input_Password}   ${password}
    Click on Element  ${btn_SignIn}
    SeleniumLibrary.Wait Until Element Is Visible    ${expected_error}   10s    

Verify login failed with invalid account
    [Arguments]    ${username}    ${password}    ${expected_error}
    Given Fill Text Input  ${input_UserID}   ${username}
    And Fill Text Input  ${input_Password}   ${password}
    When Click on SignIn with Wait Request Payload login Failed
    Then Check validation error message    ${elm_error_message}    ${expected_error}
    
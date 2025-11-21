*** Settings ***
Resource        ../../Resources/PageObject/LoginPage/LoginPage.robot
*** Test Cases ***
Given navigate to LoginPage, When input user information, Then check user inactive with ui
    Check Login account inactive with API
Given navigate to LoginPage, When input user information, Then Login Failed with api
    Check Login unsuccessfully with API
Given navigate to LoginPage, When input user information, Then Login successfully with api
    Check Loggin successfully with API
*** Settings ***
Documentation    Page Object for Delete User functionality
Resource    ../../../TestData/Browser/Global.robot
Resource    ../../../TestKeyWords/Common.robot
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${Create_User_API}      api/admin/user/



*** Keywords ***
Capture API Delete
    SeleniumLibrary.Wait Until Element Is Visible    //p[contains(normalize-space(.), '#')]      15s
    ${text}=    SeleniumLibrary.Get Text    //p[contains(normalize-space(.), '#')]
    Log    ${text}
    ${id}=    Evaluate    re.search(r'#(\\d+)', """${text}""").group(1)    re
    Log    ${id}

    ${driver}=    Get Library Instance    SeleniumLibrary

    Click on Element    //p[normalize-space()='Confirm']
    
    Network.Start Network Interception    ${driver.driver}

    Network.Clear Intercepted Requests    ${driver.driver}
    
    
    #Get Update Request
    ${profile_request}=    Network.Wait For Request    ${driver.driver}    ${Create_User_API}${id}/    ${Method_DELETE}    timeout=10
    Log    ${profile_request}


    ${response}=    Set Variable    ${profile_request['response']}
    Log    ${response}
    ${parsed}=    Parse Response API    ${response}
    Log    ${parsed}
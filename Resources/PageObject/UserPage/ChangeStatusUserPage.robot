*** Settings ***
Documentation    Page Object for Change Status User functionality
Resource    ../../../TestData/Browser/Global.robot
Resource    ../../../TestKeyWords/Common.robot
Resource    ../../../Resources/PageObject/UserPage/UpdateUserPage.robot
Library    SeleniumLibrary
Library    Collections

*** Variables ***
#Button
${CHANGE_STATUS_SUBMIT}       xpath=//button[normalize-space()='Submit']
#End Point API
${ChangeStatus_User_API}      api/admin/change-status/

*** Keywords ***
Go To User Detail on User Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_USER_BUTTON}
    Select User Random User From List
    Click on Element    xpath=//p[normalize-space()='Change Status']
    Sleep    2s

Change Activate/Deactivate on Change Status Tab
    SeleniumLibrary.Wait Until Element Is Visible    //button[@value='on']        10s
    ${get_now_status}=    SeleniumLibrary.Get Element Attribute    //button[@value='on']    aria-checked
    Log    ${get_now_status}
    # Sleep    2s
    Click on Element    //button[@value='on']
    
Verify Sucessfully Message For Change Status successfully
    Check validation error message    //div[@class="text-sm opacity-90"]        Change status successfully.

Click Submit button and wait for response change status user successfully
    SeleniumLibrary.Wait Until Element Is Visible    //button[@value='on']
    ${get_status_change}=    SeleniumLibrary.Get Element Attribute    //button[@value='on']    aria-checked
    Log    ${get_status_change}
    # Sleep    2s
    SeleniumLibrary.Wait Until Element Is Visible    //p[contains(normalize-space(.), '#')]      15s
    ${text}=    SeleniumLibrary.Get Text    //p[contains(normalize-space(.), '#')]
    Log    ${text}
    ${id}=    Evaluate    re.search(r'#(\\d+)', """${text}""").group(1)    re
    Log    ${id}
    ${driver}=    Get Library Instance    SeleniumLibrary
    Network.Start Network Interception    ${driver.driver}
    Network.Clear Intercepted Requests    ${driver.driver}
    Click on Element    ${CHANGE_STATUS_SUBMIT}
    #Get Request
    ${profile_request}=    Network.Wait For Request    ${driver.driver}    ${ChangeStatus_User_API}${id}    ${Method_PUT}    timeout=10    
    Log    ${profile_request}
    Log    ${profile_request["postData"]}
    ${TypeEmail}=    Set Variable    ${profile_request["postData"]}
    ${postDataDict}=    Evaluate    json.loads('''${profile_request["postData"]}''')    json
    Log    ${postDataDict["is_active"]}
    ${postDataDict["is_active"]}=    Evaluate    json.dumps(${postDataDict["is_active"]})    json
    Should Be Equal As Strings     ${postDataDict["is_active"]}     ${get_status_change}
    #Get Response
    ${response}=    Set Variable    ${profile_request['response']}
    Log    ${response}
    ${parsed}=    Parse Response API    ${response}
    Log    ${parsed}
    Should Be Equal As Strings     ${parsed.success}       ${Boolean_True}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_202}
    Should Be Equal As Strings     ${parsed.message}       Update status user successfully
    Network.Stop Network Interception    ${driver.driver}  
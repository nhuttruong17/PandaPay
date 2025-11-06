*** Settings ***
Documentation    Page Object for Update Product functionality
Resource    ../../../TestData/Browser/Global.robot
Resource    ../../../TestKeyWords/Common.robot
Library    SeleniumLibrary
Library    Collections
*** Variables ***
###Buttons###
${Tab_PRODUCTS_BUTTON}           xpath=//button[normalize-space()='Product']
${DELETE_PRODUCTS_BUTTON}        xpath=//button[normalize-space()='Delete product']
${CONFIRM_PRODUCTS_BUTTON}        xpath=//button[normalize-space()='Confirm']
###API###
${Delete_Product_API}            api/products/


*** Keywords ***
Select Product Random Product From List
    [Documentation]    Collect visible user rows from the users table and click one at random.
    SeleniumLibrary.Wait Until Element Is Visible    xpath=//table//tbody//tr    20s
    ${rows}=    SeleniumLibrary.Get WebElements    xpath=//table//tbody//tr
    Log    ${rows}
    ${count}=    Get Length    ${rows}
    Run Keyword If    ${count} == 0    Fail    No user rows found to click
    ${index}=    Evaluate    random.randint(0, ${count}-1)    modules=random
    ${row}=    Collections.Get From List    ${rows}    ${index}
    Log    ${rows}
    # Try to scroll the row into view, then click it (use SeleniumLibrary explicitly to avoid conflicts)
    Run Keyword And Ignore Error    SeleniumLibrary.Scroll Element Into View    ${row}
    SeleniumLibrary.Click Element    ${row}

Click Submit button and wait for response Delete Product
    ${url}=    SeleniumLibrary.Get Location
    ${id}=     Evaluate    re.search(r'/detail/([0-9]+)(?:[/?]|$)', """${url}""").group(1)    re
    Log    ${id}
    # #Prepare for request interception
    # ${driver}=    Prepare For Request Interception    ${Delete_Product_API}${id}/
    # Click on Element    ${CONFIRM_PRODUCTS_BUTTON}
    # Sleep    2s
    # #Get Sign In Request
    # ${result}=    Get Request API    ${driver}
    # Should Be Equal As Integers    ${result.status}    ${Status_202}
    # #Verify request payload
    # ${request_payload}=    Evaluate    json.loads('''${result.payload}''')    json
    # Should Be Equal As Strings    ${request_payload['code']}    Pikachu
    # Log    ${request_payload}
    # #Verify response
    # &{parsed}=    Parse Response API   ${result.body}
    # Should Be Equal As Strings    ${parsed.success}    ${Boolean_True}
    # Should Be Equal As Integers    ${parsed.statusCode}    ${Status_202}
    # Should Be Equal As Strings    ${parsed.message}    UPDATE_DATA_SUCCEEDED
    # Log    ${parsed}

    ${driver}=    Get Library Instance    SeleniumLibrary

    Click on Element    //p[normalize-space()='Confirm']
    
    Network.Start Network Interception    ${driver.driver}

    Network.Clear Intercepted Requests    ${driver.driver}
    
    #Get Update Request
    ${profile_request}=    Network.Wait For Request    ${driver.driver}    ${Delete_Product_API}${id}/    ${Method_DELETE}    timeout=10
    Log    ${profile_request}
    ${response}=    Set Variable    ${profile_request['response']}
    Log    ${response}
    ${parsed}=    Parse Response API    ${response}
    Log    ${parsed}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_True}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_202}
    Should Be Equal As Strings    ${parsed.message}    DELETE_DATA_SUCCEEDED
    Network.Stop Network Interception    ${driver.driver}
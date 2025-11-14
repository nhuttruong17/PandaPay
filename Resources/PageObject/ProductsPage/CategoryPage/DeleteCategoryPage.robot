*** Settings ***
Documentation    Page Object for Delete Category functionality
Resource    ../../../../TestData/Browser/Global.robot
Resource    ../../../../TestKeyWords/Common.robot
Library    SeleniumLibrary
Library    Collections
*** Variables ***
###Buttons###
${Tab_PRODUCTS_BUTTON}           xpath=//button[normalize-space()='Product']
${LIST_CATEGORY_BUTTON}        xpath=//button[normalize-space()='Category List']
${DELETE_PRODUCTS_BUTTON}        xpath=//button[normalize-space()='Delete product']
${CONFIRM_PRODUCTS_BUTTON}        xpath=//button[normalize-space()='Confirm']
###API###
${Delete_Product_API}            api/products/

${Random_click...}        //tr[     .//td[1]//span[@class="ml-2 text-sm font-medium leading-none"][text()!='UNKNOWN']     and     number(normalize-space(.//td[2]//span[@class="ml-2 text-sm font-medium leading-none"]/text()[1])) = 0 ]//button[contains(@aria-haspopup,'menu')]

*** Keywords ***



Select Category Random Category From List
    [Documentation]    Select a random category with 0 products (excluding "UNKNOWN") and click the (...) menu button.
    SeleniumLibrary.Wait Until Element Is Visible    ${Random_click...}    10s
    ${valid_rows}=    SeleniumLibrary.Get WebElements    ${Random_click...}
    Log    ${valid_rows}
    ${total_rows}=    Get Length    ${valid_rows}
    SeleniumLibrary.Click Element    ${Random_click...}
    Sleep    2s
    ${url}=    SeleniumLibrary.Get Element Attribute    //a[contains(@href,'edit')]    href
    Log    ${url}
    # SeleniumLibrary.Click Element    //a[contains(@href,'edit')]


Click Submit button and wait for response Delete Category
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
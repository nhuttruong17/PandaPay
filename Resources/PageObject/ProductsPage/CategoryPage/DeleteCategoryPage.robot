*** Settings ***
Documentation    Page Object for Delete Category functionality
Resource    ../../../../TestData/Browser/Global.robot
Resource    ../../../../TestKeyWords/Common.robot
Library    SeleniumLibrary
Library    Collections

*** Variables ***
###Buttons###
${Tab_PRODUCTS_BUTTON}           xpath=//button[normalize-space()='Product']
${LIST_CATEGORY_BUTTON}          xpath=//button[normalize-space()='Category List']
${DELETE_PRODUCTS_BUTTON}        xpath=//button[normalize-space()='Delete product']
${CONFIRM_PRODUCTS_BUTTON}       xpath=//button[normalize-space()='Confirm']
###API###
${Delete_Category_API}            api/categories/
${Random_click...}        //tr[     .//td[1]//span[@class="ml-2 text-sm font-medium leading-none"][text()!='UNKNOWN']     and     number(normalize-space(.//td[2]//span[@class="ml-2 text-sm font-medium leading-none"]/text()[1])) = 0 ]//button[contains(@aria-haspopup,'menu')]

*** Keywords ***
Select Category and Click on Delete Category From List
    SeleniumLibrary.Wait Until Element Is Visible    ${Random_click...}    10s
    ${valid_rows}=    SeleniumLibrary.Get WebElements    ${Random_click...}
    Log    ${valid_rows}
    ${total_rows}=    Get Length    ${valid_rows}
    SeleniumLibrary.Click Element    ${Random_click...}
    Sleep    2s
    ${url}=    SeleniumLibrary.Get Element Attribute    //a[contains(@href,'edit')]    href
    Log    ${url}
    ${id}=    Evaluate    re.search(r'/edit/([0-9]+)(?:[/?]|$)', """${url}""").group(1)    re
    Log    ${id}
    ${driver}=    Get Library Instance    SeleniumLibrary
    Click on Element    //p[normalize-space()='Delete']
    Network.Start Network Interception    ${driver.driver}
    Network.Clear Intercepted Requests    ${driver.driver}
    #Get Request
    ${profile_request}=    Network.Wait For Request    ${driver.driver}    ${Delete_Category_API}${id}/    ${Method_DELETE}    timeout=10
    Log    ${profile_request}
    #Get Response
    ${response}=    Set Variable    ${profile_request['response']}
    Log    ${response}
    ${parsed}=    Parse Response API    ${response}
    Log    ${parsed}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_True}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_202}
    Should Be Equal As Strings    ${parsed.message}    DELETE_DATA_SUCCEEDED
    Network.Stop Network Interception    ${driver.driver}

    
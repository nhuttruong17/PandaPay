*** Settings ***
Documentation    Page Object for Update Category functionality
Resource    ../../../../TestData/Browser/Global.robot
Resource    ../../../../TestKeyWords/Common.robot
Library    SeleniumLibrary
Library    Collections
Library    FakerLibrary

*** Variables ***
###Buttons###
${Tab_PRODUCTS_BUTTON}           xpath=//button[normalize-space()='Product']
${LIST_CATEGORY_BUTTON}          xpath=//button[normalize-space()='Category List']
${DELETE_PRODUCTS_BUTTON}        xpath=//button[normalize-space()='Delete product']
${CONFIRM_PRODUCTS_BUTTON}       xpath=//button[normalize-space()='Confirm']
${Submit_BUTTON_Category}        xpath=/html/body/div[1]/div/main/div/form/button
###API###
${Update_Category_API}            api/categories/
${Random_ClickEdit}        //tr[     .//td[1]//span[@class="ml-2 text-sm font-medium leading-none"][text()!='UNKNOWN'] ]//button[contains(@aria-haspopup,'menu')]
${CATEGORY_NAME_INPUT}            xpath=//input[@placeholder='Enter Category Name']
###Data###
${Category_exist}                NikeSchoe
${MIN_STRING_1}                  A    
${LONG_STRING_51}                AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
${EMPTY}
${Category_exist}                NikeSchoe

*** Keywords ***
Input Category Name
    [Arguments]    ${category_name}
    SeleniumLibrary.Wait Until Element Is Visible    ${CATEGORY_NAME_INPUT}    10s
    Clear Element Text        ${CATEGORY_NAME_INPUT}
    Fill Text Input    ${CATEGORY_NAME_INPUT}    ${category_name}

Select Category Random Category From List
    [Documentation]    Select a random category with 0 products (excluding "UNKNOWN") and click the (...) menu button.
    SeleniumLibrary.Wait Until Element Is Visible    ${Random_ClickEdit}    10s
    ${valid_rows}=    SeleniumLibrary.Get WebElements    ${Random_ClickEdit}
    Log    ${valid_rows}
    ${total_rows}=    Get Length    ${valid_rows}
    SeleniumLibrary.Click Element    ${Random_ClickEdit}
    Sleep    2s
    Click on Element    //a[contains(@href,'edit')]
    
Click Submit button and wait for response Existing Category Name
    Sleep    5s
    ${url}=    SeleniumLibrary.Get Location
    Log    ${url}
    ${id}=     Evaluate    re.search(r'/edit/([0-9]+)(?:[/?]|$)', """${url}""").group(1)    re
    Log    ${id}
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    ${Update_Category_API}${id}/
    Click on Element    ${Submit_BUTTON_Category}
    Sleep    2s
    #Get Sign In Request
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_400}
    #Verify request payload
    ${request_payload}=    Evaluate    json.loads('''${result.payload}''')    json
    Should Be Equal As Strings    ${request_payload['name']}    ${Category_exist}
    Log    ${request_payload}
    #Verify response
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_False}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_400}
    Should Be Equal As Strings    ${parsed.message}    INVALID_INPUT
    Should Contain    ${parsed.data.name}    VAL024
    Log    ${parsed}

Click Submit button and wait for response Valid Category Name
    Sleep    5s
    ${url}=    SeleniumLibrary.Get Location
    Log    ${url}
    ${id}=     Evaluate    re.search(r'/edit/([0-9]+)(?:[/?]|$)', """${url}""").group(1)    re
    Log    ${id}
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    ${Update_Category_API}${id}/
    Click on Element    ${Submit_BUTTON_Category}
    Sleep    2s
    #Get Sign In Request
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_202}
    #Verify request payload
    ${request_payload}=    Evaluate    json.loads('''${result.payload}''')    json
    Should Be Equal As Strings    ${request_payload['name']}    ${New_Name_Category}
    Log    ${request_payload}
    #Verify response
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_True}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_202}
    Should Be Equal As Strings    ${parsed.message}    UPDATE_DATA_SUCCEEDED
    Log    ${parsed}

Generate Random Data New Category
    ${New_Name_Category}=    FakerLibrary.Word
    Log    ${New_Name_Category}
    Set Suite Variable    ${New_Name_Category}
*** Settings ***
Documentation    Page Object for Update Product functionality
Resource    ../../../TestData/Browser/Global.robot
Resource    ../../../TestKeyWords/Common.robot
Library    SeleniumLibrary
Library    Collections
Library    FakerLibrary

*** Variables ***
${UPDATE_PRODUCTS_BUTTON}        xpath=//button[normalize-space()='Update product']

###Input Fields###
${SKU_INPUT}                     xpath=//input[@placeholder='Enter SKU']
${PRODUCT_NAME_INPUT}            xpath=//input[@placeholder='Enter Product Name']
${UNIT_PRICE_INPUT}              xpath=//input[@placeholder='Enter Unit Price']
${DESCRIPTION_INPUT}             xpath=//textarea[@placeholder='Enter Description']
###Buttons###
${Tab_PRODUCTS_BUTTON}           xpath=//button[normalize-space()='Product']
${Submit_BUTTON_Product}         xpath=/html/body/div[1]/div/main/div/div/div[2]/div[2]/div/div[1]/form/button
###API###
${Update_Product_API}            api/products/
###Data###
${SKU_exist}                     AP2021
${LONG_STRING_51}                AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
${LONG_STRING_101}               AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
${Long_String_501}               v


*** Keywords ***
Input SKU
    [Arguments]    ${sku}
    SeleniumLibrary.Wait Until Element Is Visible    ${SKU_INPUT}    10s
    Clear Element Text        ${SKU_INPUT}
    Fill Text Input    ${SKU_INPUT}    ${sku}

Input Product Name
    [Arguments]    ${product_name}
    SeleniumLibrary.Wait Until Element Is Visible    ${PRODUCT_NAME_INPUT}    10s
    Clear Element Text        ${PRODUCT_NAME_INPUT}
    Fill Text Input    ${PRODUCT_NAME_INPUT}    ${product_name}

Input Unit Price
    [Arguments]    ${unit_price}
    SeleniumLibrary.Wait Until Element Is Visible    ${UNIT_PRICE_INPUT}    10s
    Clear Element Text        ${UNIT_PRICE_INPUT}
    Fill Text Input    ${UNIT_PRICE_INPUT}    9${unit_price}

Input Description
    [Arguments]    ${description}
    SeleniumLibrary.Wait Until Element Is Visible    ${DESCRIPTION_INPUT}    10s
    Clear Element Text        ${DESCRIPTION_INPUT}
    Fill Text Input    ${DESCRIPTION_INPUT}    ${description}

Select Category
    SeleniumLibrary.Wait Until Element Is Visible    xpath=//select[@aria-hidden='true']/option[2]        20s
    Click on Element    xpath=//select[@aria-hidden='true']/option[2]
    
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
    # Sleep    2s
    # ${url}=    SeleniumLibrary.Get Location
    # ${id}=     Evaluate    re.search(r'/detail/([0-9]+)', """${url}""").group(1)    re
    # Log    ${id}

Click Submit button and wait for response Invalid Price
    ${url}=    SeleniumLibrary.Get Location
    ${id}=     Evaluate    re.search(r'/detail/([0-9]+)(?:[/?]|$)', """${url}""").group(1)    re
    Log    ${id}
    Sleep    2s
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    ${Update_Product_API}${id}/
    Click on Element    ${Submit_BUTTON_Product}
    Sleep    2s
    #Get Sign In Request
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_400}
    #Verify request payload
    ${request_payload}=    Evaluate    json.loads('''${result.payload}''')    json
    Should Be Equal As Strings    ${request_payload['price']}    0
    Log    ${request_payload}
    #Verify response
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_False}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_400}
    Should Be Equal As Strings    ${parsed.message}    INVALID_INPUT
    Should Contain    ${parsed.data.price}    VAL174
    Log    ${parsed}

Click Submit button and wait for response Existing SKU
    ${url}=    SeleniumLibrary.Get Location
    ${id}=     Evaluate    re.search(r'/detail/([0-9]+)(?:[/?]|$)', """${url}""").group(1)    re
    Log    ${id}
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    ${Update_Product_API}${id}/
    Click on Element    ${Submit_BUTTON_Product}
    Sleep    2s
    #Get Sign In Request
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_400}
    #Verify request payload
    ${request_payload}=    Evaluate    json.loads('''${result.payload}''')    json
    Should Be Equal As Strings    ${request_payload['code']}    ${SKU_exist}
    Log    ${request_payload}
    #Verify response
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_False}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_400}
    Should Be Equal As Strings    ${parsed.message}    INVALID_INPUT
    Should Contain    ${parsed.data.code}    VAL607
    Log    ${parsed}

Click Submit button and wait for response Valid Information
    ${url}=    SeleniumLibrary.Get Location
    ${id}=     Evaluate    re.search(r'/detail/([0-9]+)(?:[/?]|$)', """${url}""").group(1)    re
    Log    ${id}
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    ${Update_Product_API}${id}/
    Click on Element    ${Submit_BUTTON_Product}
    Sleep    2s
    #Get Sign In Request
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_202}
    #Verify request payload
    ${request_payload}=    Evaluate    json.loads('''${result.payload}''')    json
    Should Be Equal As Strings    ${request_payload['code']}    ${New_SKU}
    Log    ${request_payload}
    #Verify response
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_True}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_202}
    Should Be Equal As Strings    ${parsed.message}    UPDATE_DATA_SUCCEEDED
    Log    ${parsed}


Click Random Product AndGetCodeFromResponse
    [Documentation]    Click random product; nếu DOM không có code thì lấy code từ response GET chi tiết.
    ${driver}=    Get Library Instance    SeleniumLibrary
    Network.Start Network Interception    ${driver.driver}
    Network.Clear Intercepted Requests    ${driver.driver}

    # Click random product (bạn có sẵn keyword)
    Select Product Random Product From List
    Sleep    3s
    
    # SeleniumLibrary.Wait Until Element Is Visible    //p[contains(normalize-space(.), '#')]      15s
    # ${text}=    SeleniumLibrary.Get Text    //p[contains(normalize-space(.), '#')]
    # Log    ${text}
    # ${sku}=    Evaluate    re.search(r'#([A-Za-z0-9]+)', """${text}""").group(1)    re
    # Log    ${sku}
    
    # # Lấy requests api/products/ có response
    # @{reqs}=    Network.Get Intercepted Requests    ${driver.driver}    api/products/    GET    10    require_response=True
    # Log    ${reqs}
    # Network.Stop Network Interception    ${driver.driver}

Generate Random Data New SKU
    ${New_SKU}=    FakerLibrary.Word
    Log    ${New_SKU}
    Set Suite Variable    ${New_SKU}
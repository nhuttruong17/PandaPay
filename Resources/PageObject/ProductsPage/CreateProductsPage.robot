*** Settings ***
Documentation    Page Object for Create Products functionality
Resource    ../../../TestData/Browser/Global.robot
Resource    ../../../TestKeyWords/Common.robot
Library    SeleniumLibrary
Library    Collections

*** Variables ***
###Buttons###
${Tab_PRODUCTS_BUTTON}           xpath=//button[normalize-space()='Product']
${CREATE_PRODUCTS_BUTTON}        xpath=//button[normalize-space()='Create New Product']
${Submit_BUTTON_Product}         xpath=/html/body/div[1]/div/main/div/form/button
###Input Fields###
${SKU_INPUT}                     xpath=//input[@placeholder='Enter SKU']
${PRODUCT_NAME_INPUT}            xpath=//input[@placeholder='Enter Product Name']
${UNIT_PRICE_INPUT}              xpath=//input[@placeholder='Enter Unit Price']
${DESCRIPTION_INPUT}             xpath=//textarea[@placeholder='Enter Description']
###API###
${Create_Product_API}            api/products/
###Data###
${SKU_exist}                     ChickenUS
${LONG_STRING_51}                AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
${LONG_STRING_101}               AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
${Long_String_501}               AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaa

*** Keywords ***
Input SKU
    [Arguments]    ${sku}
    Fill Text Input    ${SKU_INPUT}    ${sku}

Input Product Name
    [Arguments]    ${product_name}
    Fill Text Input    ${PRODUCT_NAME_INPUT}    ${product_name}

Input Unit Price
    [Arguments]    ${unit_price}
    Fill Text Input    ${UNIT_PRICE_INPUT}    9${unit_price}

Input Description
    [Arguments]    ${description}
    Fill Text Input    ${DESCRIPTION_INPUT}    ${description}

Select Category
    # [Arguments]    ${category}
    Click on Element    //select[@aria-hidden='true']/option[@value='18797']
    # Click on Element    xpath=//li[normalize-space()='${category}']

Click Submit button and wait for response Existing SKU
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    ${Create_Product_API}
    Click on Element    xpath=/html/body/div[1]/div/main/div/form/button
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
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    ${Create_Product_API}
    Click on Element    xpath=/html/body/div[1]/div/main/div/form/button
    Sleep    2s
    #Get Sign In Request
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_201}
    #Verify request payload
    ${request_payload}=    Evaluate    json.loads('''${result.payload}''')    json
    Should Be Equal As Strings    ${request_payload['code']}    Cownsdown
    Log    ${request_payload}
    #Verify response
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_True}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_201}
    Should Be Equal As Strings    ${parsed.message}    CREATE_SUCCESS
    Log    ${parsed}
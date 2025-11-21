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
${SKU_Empty}                     xpath=//p[normalize-space(text())='SKU is required.']
${Expected_empty_SKU}            SKU is required.
${SKU_min}                       xpath=//p[normalize-space(text())='SKU must be at least 2 characters.']
${Expected_min_SKU}              SKU must be at least 2 characters.
${SKU_max}                       xpath=//p[normalize-space(text())='SKU must be at most 50 characters.']
${Expected_max_SKU}              SKU must be at most 50 characters.
${ProductName_empty}             xpath=//p[normalize-space(text())='Product name is required.']
${Expected_empty_ProductName}    Product name is required.
${ProductName_min}               xpath=//p[normalize-space(text())='Product name must be at least 2 characters.']
${Expected_min_ProductName}      Product name must be at least 2 characters.
${ProductName_max}               xpath=//p[normalize-space(text())='Product name must be at most 100 characters.']
${Expected_max_ProductName}      Product name must be at most 100 characters.
${Category_empty}                xpath=//p[normalize-space(text())='Category is required.']
${Expected_empty_Category}       Category is required.
${Price_empty}                   xpath=//p[normalize-space(text())='Unit Price is required']
${Expected_empty_Price}          Unit Price is required
${Description_min}               xpath=//p[normalize-space(text())='Description must be at least 2 characters.']
${Expected_min_Description}      Description must be at least 2 characters.
${Description_max}               xpath=//p[normalize-space(text())='Description must be at most 500 characters.']
${Expected_max_Description}      Description must be at most 500 characters.
${SKU_exist}                     AP2021
${LONG_STRING_51}                AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
${LONG_STRING_101}               AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
${Long_String_501}               v
#Toast message
${Toast_message}                 //div[@class="text-sm opacity-90"]    
${Toast_SKU_Exist}               • SKU code already exists
${Toast_Update_Product_Success}  Update product success
${Price_Invalid}                 • Product price must be between 1 and 10,000,000

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
    Fill Text Input           ${UNIT_PRICE_INPUT}    9${unit_price}.00

Input Description
    [Arguments]    ${description}
    SeleniumLibrary.Wait Until Element Is Visible    ${DESCRIPTION_INPUT}    10s
    Clear Element Text        ${DESCRIPTION_INPUT}
    Fill Text Input    ${DESCRIPTION_INPUT}    ${description}

Select Category
    SeleniumLibrary.Wait Until Element Is Visible    xpath=//select[@aria-hidden='true']/option[2]        20s
    Click on Element    xpath=//select[@aria-hidden='true']/option[2]
    
Open Browser and Go To Update Product Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_PRODUCTS_BUTTON}
    Select Product Random Product From List
    Sleep    2s
    Click on Element    ${UPDATE_PRODUCTS_BUTTON}
    Generate Random Data New SKU

User on at Update Product Page
    No Operation

User Input Information with Existing SKU
    Input SKU    ${SKU_exist}
    Input Product Name    ${Product_Name}
    # Select Category
    Input Unit Price     ${Price}
    Input Description    ${Description}

User Input Valid Information Product
    Input SKU    ${New_SKU}
    Input Product Name    ${Product_Name}
    # Select Category
    Input Unit Price     ${Price}
    Input Description    ${Description}

###SKU###
Verify Error Message For Empty SKU
    Check validation error message    ${SKU_Empty}    ${Expected_empty_SKU}
    
Verify Error Message For Min SKU
    Check validation error message    ${SKU_min}    ${Expected_min_SKU}

Verify Error Message For Max SKU
    Check validation error message    ${SKU_max}    ${Expected_max_SKU}    
    
Verify No Error Message For Valid SKU
    Page Should Not Contain           ${SKU_max}    ${Expected_max_SKU}

###Product Name###
Verify Error Message For Empty Product Name
    Check validation error message    ${ProductName_empty}    ${Expected_empty_ProductName}
    
Verify Error Message For Min Product Name
    Check validation error message    ${ProductName_min}     ${Expected_min_ProductName}
    
Verify Error Message For Max Product Name
    Check validation error message    ${ProductName_max}     ${Expected_max_ProductName}

Verify No Error Message For Valid Product Name
    Page Should Not Contain           ${ProductName_max}     ${Expected_max_ProductName}

###Category###
Verify Error Message For Empty Category
    Check validation error message    ${Category_empty}     ${Expected_empty_Category}
    
Verify No Error Message For Valid Category
    Page Should Not Contain           ${Category_empty}     ${Expected_empty_Category}

###Price###
Verify Error Message For Empty Price
    Check validation error message    ${Price_empty}        ${Expected_empty_Price}
    
Verify No Error Message For Valid Price
    Page Should Not Contain           ${Price_empty}        ${Expected_empty_Price}

###Description###
Verify Error Message For Min Description
    Check validation error message    ${Description_min}    ${Expected_min_Description}    
    
Verify Error Message For Max Description
    Check validation error message    ${Description_max}    ${Expected_max_Description}    
    
Verify No Error Message For Valid Description
    Page Should Not Contain           ${Description_max}    ${Expected_max_Description}

###Existing SKU on Create Product###
Verify Error Message For Existing SKU
    Check validation error message    ${Toast_message}    ${Toast_SKU_Exist}

Veridy Success Message For Update Product
    Check validation error message    ${Toast_message}    ${Toast_Update_Product_Success}

Verify Error Message For Valid Price
    Check validation error message    ${Toast_message}    ${Price_Invalid}

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
    Should Be Equal As Strings    ${parsed.success}        ${Boolean_False}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_400}
    Should Be Equal As Strings    ${parsed.message}        INVALID_INPUT
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
    Should Be Equal As Strings    ${parsed.success}        ${Boolean_False}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_400}
    Should Be Equal As Strings    ${parsed.message}        INVALID_INPUT
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
    Should Be Equal As Strings    ${parsed.success}        ${Boolean_True}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_202}
    Should Be Equal As Strings    ${parsed.message}        UPDATE_DATA_SUCCEEDED
    Log    ${parsed}

Generate Random Data New SKU
    ${New_SKU}=    FakerLibrary.Word
    Log    ${New_SKU}
    Set Suite Variable    ${New_SKU}
    ${Product_Name}=    FakerLibrary.Name Male
    Set Suite Variable    ${Product_Name}
    ${Price}=    FakerLibrary.Random Int    min=1    max=50
    Log    ${Price}
    Set Suite Variable    ${Price}
    ${Description}=    FakerLibrary.Paragraph
    Log    ${Description}
    Set Suite Variable    ${Description}
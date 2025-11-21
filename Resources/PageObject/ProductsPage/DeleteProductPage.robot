*** Settings ***
Documentation    Page Object for Delete Product functionality
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
#Toast message
${Toast_message}              //div[@class="text-sm opacity-90"]
${Toast_Delete_Success}        Delete product success

*** Keywords ***
Open Browser and Go To Delete Products Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_PRODUCTS_BUTTON}
    
Choose Product Random Product From List
    Select Product Random Product From List
    Sleep    2s
    Click on Element    ${DELETE_PRODUCTS_BUTTON}

Verify Success Message For Delete Product
    Check validation error message    ${Toast_message}    ${Toast_Delete_Success}

Select Product Random Product From List
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
    ${driver}=    Get Library Instance    SeleniumLibrary
    Click on Element    //p[normalize-space()='Confirm']
    Network.Start Network Interception    ${driver.driver}
    Network.Clear Intercepted Requests    ${driver.driver}
    #Get Request
    ${profile_request}=    Network.Wait For Request    ${driver.driver}    ${Delete_Product_API}${id}/    ${Method_DELETE}    timeout=10
    Log    ${profile_request}
    #Get Response
    ${response}=    Set Variable    ${profile_request['response']}
    Log    ${response}
    ${parsed}=    Parse Response API    ${response}
    Log    ${parsed}
    Should Be Equal As Strings     ${parsed.success}        ${Boolean_True}
    Should Be Equal As Integers    ${parsed.statusCode}     ${Status_202}
    Should Be Equal As Strings     ${parsed.message}        DELETE_DATA_SUCCEEDED
    Network.Stop Network Interception    ${driver.driver}
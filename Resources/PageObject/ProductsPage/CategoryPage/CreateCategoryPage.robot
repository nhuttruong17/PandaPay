*** Settings ***
Documentation    Page Object for Create Products functionality
Resource    ../../../../TestData/Browser/Global.robot
Resource    ../../../../TestKeyWords/Common.robot
Library    SeleniumLibrary
Library    Collections
Library     FakerLibrary

*** Variables ***
###Buttons###
${Tab_PRODUCTS_BUTTON}           xpath=//button[normalize-space()='Product']
${CREATE_CATEGORY_BUTTON}        xpath=//button[normalize-space()='Create New Category']
${Submit_BUTTON_Product}         xpath=/html/body/div[1]/div/main/div/form/button
###Input Fields###

${CATEGORY_NAME_INPUT}            xpath=//input[@placeholder='Enter Category Name']

###API###
${Create_Category_API}            api/categories/
###Data###
${Category_exist}                NikeSchoe
${MIN_STRING_1}                  A    
${LONG_STRING_51}                AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

*** Keywords ***
Input Category Name
    [Arguments]    ${category_name}
    Fill Text Input    ${CATEGORY_NAME_INPUT}    ${category_name}

Click Submit button and wait for response Existing Category Name
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    ${Create_Category_API}
    Click on Element    ${Submit_BUTTON_Product}
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
    #Prepare for request interception
    ${driver}=    Prepare For Request Interception    ${Create_Category_API}
    Click on Element    ${Submit_BUTTON_Product}
    Sleep    2s
    #Get Sign In Request
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_201}
    #Verify request payload
    ${request_payload}=    Evaluate    json.loads('''${result.payload}''')    json
    Should Be Equal As Strings    ${request_payload['name']}    ${New_Name_Category}
    Log    ${request_payload}
    #Verify response
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_True}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_201}
    Should Be Equal As Strings    ${parsed.message}    CREATE_SUCCESS
    Log    ${parsed}

Generate Random Data New Category
    ${New_Name_Category}=    FakerLibrary.Word
    Log    ${New_Name_Category}
    Set Suite Variable    ${New_Name_Category}
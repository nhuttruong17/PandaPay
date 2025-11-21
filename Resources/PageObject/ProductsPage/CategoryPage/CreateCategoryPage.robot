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
${CATEGORY_NAME_INPUT}           xpath=//input[@placeholder='Enter Category Name']
###API###
${Create_Category_API}           api/categories/
###Data###
${Category_exist}                NikeSchoe
${MIN_STRING_1}                  A    
${LONG_STRING_51}                AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
${Category_empty}                xpath=//p[normalize-space(text())='Category Name is required']
${Expected_empty_Category}       Category Name is required
#Toast message
${Toast_message}                     xpath=//div[@class="text-sm opacity-90"]
${Toast_invalid_Category}            • Category name must be between 3 and 50 characters
${Toast_Category_Exist}              • Category name already exists
${Toast_Create_Category_Success}     Create new category success
*** Keywords ***
Input Category Name
    [Arguments]    ${category_name}
    Fill Text Input    ${CATEGORY_NAME_INPUT}    ${category_name}

Open Browser and Go To Create Category Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_PRODUCTS_BUTTON}
    Click on Element    ${CREATE_CATEGORY_BUTTON}
    Generate Random Data New Category

User on at Create Category Page
    No Operation

Verify Error Message For Empty Category Name
    Check validation error message    ${Category_empty}    ${Expected_empty_Category}

Verify Error Message For Min Category Name
    Check validation error message    ${Toast_message}    ${Toast_invalid_Category}    
    Sleep    2s

Verify Error Message For Max Category Name
    Check validation error message    ${Toast_message}    ${Toast_invalid_Category}
    Sleep    2s

Verify Error Message For Exist Category Name
    Check validation error message    ${Toast_message}    ${Toast_Category_Exist}
    Sleep    2s

Veridy Success Message For Create Category
    Check validation error message    ${Toast_message}     ${Toast_Create_Category_Success}

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
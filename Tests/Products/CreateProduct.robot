*** Settings ***
Documentation    Test cases for Create Products functionality
Resource    ../../Resources/PageObject/ProductsPage/CreateProductsPage.robot

*** Test Cases ***
# Check validation empty SKU error on Create Product Page
#     Given Open Browser and Go To Create Product Page
#     When Fill Text Input    ${SKU_INPUT}    ${EMPTY}
#     And Click on Element    ${Submit_BUTTON_Product}
#     Then Verify Error Message For Empty SKU
#     [Teardown]    Basic TearDowns
#Waiting for fix SKU is required validation issue

Check validation min SKU error on Create Product Page
    [Documentation]    Verify that the system shows validation error when SKU has less than minimum allowed characters.
    [Tags]    validation    create_product    regression
    Given Open Browser and Go To Create Product Page
    When Input SKU    A
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Min SKU
    
Check validation max SKU error on Create Product Page
    [Documentation]    Verify that the system shows validation error when SKU exceeds maximum allowed characters.
    [Tags]    validation    create_product    regression
    Given User on at Create Product Page
    When Input SKU    ${LONG_STRING_51}
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Max SKU
    
Check no validation error for valid SKU on Create Product Page
    [Documentation]    Verify that no validation error appears when entering a valid SKU.
    [Tags]    validation    create_product    regression
    Given User on at Create Product Page
    When Input SKU    Chicken123
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify No Error Message For Valid SKU
    
Check validation min Product Name error on Create Product Page
    [Documentation]    Verify that the system shows validation error when Product Name has less than minimum allowed characters.
    [Tags]    validation    create_product    regression
    Given User on at Create Product Page
    When Input Product Name    A
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Min Product Name   

Check validation max Product Name error on Create Product Page
    [Documentation]    Verify that the system shows validation error when Product Name exceeds maximum allowed characters.
    [Tags]    validation    create_product    regression
    Given User on at Create Product Page
    When Input Product Name    ${LONG_STRING_101}
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Max Product Name

Check no validation error for valid Product Name on Create Product Page
    [Documentation]    Verify that no validation error appears when entering a valid Product Name.
    [Tags]    validation    create_product    regression
    Given User on at Create Product Page
    When Input Product Name    Chicken Product
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify No Error Message For Valid Product Name

Check validation empty Category error on Create Product Page
    [Documentation]    Verify that a validation error appears when Category field is empty.
    [Tags]    validation    create_product    regression
    Given User on at Create Product Page
    When Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Empty Category

Check no validation error for valid Category on Create Product Page
    [Documentation]    Verify that Category field passes validation when a valid category is selected.
    [Tags]    validation    create_product    regression
    Given User on at Create Product Page
    When Select Category
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify No Error Message For Valid Category
       
Check validation empty Price error on Create Product Page
    [Documentation]    Verify that validation error appears when Price field is empty.
    [Tags]    validation    create_product    regression
    Given User on at Create Product Page
    When Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Empty Price
    
Check no validation error for valid Price on Create Product Page
    [Documentation]    Verify that no validation error appears when a valid price is entered.
    [Tags]    validation    create_product    regression
    Given User on at Create Product Page
    When Input Unit Price    ${Price}
    Then Verify No Error Message For Valid Price
    
Check validation min Description error on Create Product Page
    [Documentation]    Verify validation error when Description contains fewer than minimum required characters.
    [Tags]    validation    create_product    regression
    Given User on at Create Product Page
    When Input Description    A
    Then Verify Error Message For Min Description
    
Check validation max Description error on Create Product Page
    [Documentation]    Verify validation error when Description exceeds maximum allowed characters.
    [Tags]    validation    create_product    regression
    Given User on at Create Product Page
    When Input Description    ${Long_String_501}
    Then Verify Error Message For Max Description
    
Check no validation error for valid Description on Create Product Page
    [Documentation]    Verify no validation error when entering a valid description.
    [Tags]    validation    create_product    regression
    Given User on at Create Product Page
    When Input Description    This is a valid product description.
    Then Verify No Error Message For Valid Description

Create Product existing SKU error on Create Product Page
    [Documentation]    Verify the system returns correct error when creating a product using an already existing SKU.
    [Tags]    functional    create_product    negative
    Given User on at Create Product Page
    When User Input Information with Existing SKU
    And Click Submit button and wait for response Existing SKU
    Then Verify Error Message For Existing SKU

Create Product With Valid Information on Create Product Page
    [Documentation]    Verify the system successfully creates a new product when all valid data is provided.
    [Tags]    functional    create_product    positive
    Given User on at Create Product Page
    When User Input Valid Information Product
    And Click Submit button and wait for response Valid Information
    Then Verify Success Message For Create Product
    [Teardown]    Basic TearDowns
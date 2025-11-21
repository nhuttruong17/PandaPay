*** Settings ***
Documentation    Test cases for Update Products functionality
Resource    ../../Resources/PageObject/ProductsPage/UpdateProductsPage.robot

*** Test Cases ***
# Check validation empty SKU error on Update Product Page
#     Given Open Browser and Go To Create Product Page
#     When Fill Text Input    ${SKU_INPUT}    ${EMPTY}
#     And Click on Element    ${Submit_BUTTON_Product}
#     Then Verify Error Message For Empty SKU
#     [Teardown]    Basic TearDowns
#Waiting for fix SKU is required validation issue

Check validation min SKU error on Update Product Page
    [Documentation]    Verify that the system displays a validation error when SKU has fewer than the minimum allowed characters on Update Product Page.
    [Tags]    validation    update_product    regression
    Given Open Browser and Go To Update Product Page
    When Input SKU    A
    Then Verify Error Message For Min SKU
    
Check validation max SKU error on Update Product Page
    [Documentation]    Verify that the system displays a validation error when SKU exceeds maximum allowed characters on Update Product Page.
    [Tags]    validation    update_product    regression
    Given User on at Update Product Page
    When Input SKU    ${LONG_STRING_51}
    Then Verify Error Message For Max SKU
    
Check no validation error for valid SKU on Update Product Page
    [Documentation]    Verify that no validation error appears for a valid SKU on Update Product Page.
    [Tags]    validation    update_product    regression
    Given User on at Update Product Page
    When Input SKU    Chicken123
    Then Verify No Error Message For Valid SKU
    
Check validation min Product Name error on Update Product Page
    [Documentation]    Verify that the system displays a validation error when Product Name has fewer than minimum allowed characters on Update Product Page.
    [Tags]    validation    update_product    regression
    Given User on at Update Product Page
    When Input Product Name    A
    Then Verify Error Message For Min Product Name   

Check validation max Product Name error on Update Product Page
    [Documentation]    Verify that the system displays a validation error when Product Name exceeds the maximum allowed characters on Update Product Page.
    [Tags]    validation    update_product    regression
    Given User on at Update Product Page
    When Input Product Name    ${LONG_STRING_101}
    Then Verify Error Message For Max Product Name

Check no validation error for valid Product Name on Update Product Page
    [Documentation]    Verify that no validation error appears for a valid Product Name on Update Product Page.
    [Tags]    validation    update_product    regression
    Given User on at Update Product Page
    When Input Product Name    Chicken Product
    Then Verify No Error Message For Valid Product Name

# Check validation empty Category error on Update Product Page
#     Given User on at Update Product Page
#     When Click on Element    ${Submit_BUTTON_Product}
#     Then Verify Error Message For Empty Category

# Check no validation error for valid Category on Update Product Page
#     Given User on at Update Product Page
#     When Select Category
#     And Click on Element    ${Submit_BUTTON_Product}
#     Then Verify No Error Message For Valid Category
       
# Check validation empty Price error on Update Product Page
#     Given User on at Update Product Page
#     When Click on Element    ${Submit_BUTTON_Product}
#     Then Verify Error Message For Empty Price
    
# Check no validation error for valid Price on Update Product Page
#     Given User on at Update Product Page
#     When Input Unit Price    15.99
#     Then Verify No Error Message For Valid Price
    
Check validation min Description error on Update Product Page
    [Documentation]    Verify that the system shows a validation error when Description contains fewer than the minimum allowed characters on the Update Product Page.
    [Tags]    validation    update_product    regression
    Given User on at Update Product Page
    When Input Description    A
    Then Verify Error Message For Min Description
    
# Check validation max Description error on Update Product Page
#    [Documentation]    Verify that the system shows a validation error when Description exceeds the maximum allowed length on the Update Product Page.
#    [Tags]    validation    update_product    regression
#     Given User on at Update Product Page
#     When Input Description    ${Long_String_501}
#     Then Verify Error Message For Max Description
    
Check no validation error for valid Description on Update Product Page
    [Documentation]    Verify that no validation error appears when entering a valid Description on the Update Product Page.
    [Tags]    validation    update_product    regression
    Given User on at Update Product Page
    When Input Description    This is a valid product description.
    Then Verify No Error Message For Valid Description

Update Product Invalid Price error on Update Product Page
    [Documentation]    Verify that the system shows the correct error message when entering an invalid price on the Update Product Page.
    [Tags]    functional    update_product    negative
    Given User on at Update Product Page
    When Input Unit Price    0.0000000
    And Click Submit button and wait for response Invalid Price
    Then Verify Error Message For Valid Price

Update Product existing SKU error on Update Product Page
    [Documentation]    Verify that the system returns the correct validation error when using an existing SKU while updating a product.
    [Tags]    functional    update_product    negative
    Given User on at Update Product Page
    When User Input Information with Existing SKU
    And Click Submit button and wait for response Existing SKU
    Then Verify Error Message For Existing SKU

Update Product With Valid Information on Update Product Page
    [Documentation]    Verify that the system successfully updates the product when all valid information is provided on the Update Product Page.
    [Tags]    functional    update_product    positive
    Given User on at Update Product Page
    When User Input Valid Information Product
    And Click Submit button and wait for response Valid Information
    Then Veridy Success Message For Update Product
    [Teardown]    Basic TearDowns
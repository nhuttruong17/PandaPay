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
    Given Open Browser and Go To Update Product Page
    When Input SKU    A
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Min SKU
    
Check validation max SKU error on Update Product Page
    Given User on at Update Product Page
    When Input SKU    ${LONG_STRING_51}
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Max SKU
    
Check no validation error for valid SKU on Update Product Page
    Given User on at Update Product Page
    When Input SKU    Chicken123
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify No Error Message For Valid SKU
    
Check validation min Product Name error on Update Product Page
    Given User on at Update Product Page
    When Input Product Name    A
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Min Product Name   

Check validation max Product Name error on Update Product Page
    Given User on at Update Product Page
    When Input Product Name    ${LONG_STRING_101}
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Max Product Name

Check no validation error for valid Product Name on Update Product Page
    Given User on at Update Product Page
    When Input Product Name    Chicken Product
    And Click on Element    ${Submit_BUTTON_Product}
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
    Given User on at Update Product Page
    When Input Description    A
    Then Verify Error Message For Min Description
    
# Check validation max Description error on Update Product Page
#     Given User on at Update Product Page
#     When Input Description    ${Long_String_501}
#     Then Verify Error Message For Max Description
    
Check no validation error for valid Description on Update Product Page
    Given User on at Update Product Page
    When Input Description    This is a valid product description.
    Then Verify No Error Message For Valid Description
    [Teardown]    Basic TearDowns

Update Product Invalid Price error on Update Product Page
    Given Open Browser and Go To Update Product Page
    When Input Unit Price    0.00
    Click on Element    ${Submit_BUTTON_Product}
    # And Click Submit button and wait for response Invalid Price
    Then Verify Error Message For Valid Price
    [Teardown]    Basic TearDowns



# Update Product existing SKU error on Update Product Page
#     # Given User on at Update Product Page
#     Given Open Browser and Go To Update Product Page
#     When User Input Information with Existing SKU
#     And Click Submit button and wait for response Existing SKU
#     Then Verify Error Message For Existing SKU
#     [Teardown]    Basic TearDowns

# Update Product With Valid Information on Update Product Page
#     # Given User on at Update Product Page
#     Given Open Browser and Go To Update Product Page
#     When User Input Valid Information Product
#     And Click Submit button and wait for response Valid Information
#     Then Veridy Success Message For Update Product
#     [Teardown]    Basic TearDowns

*** Keywords ***
Open Browser and Go To Update Product Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_PRODUCTS_BUTTON}
    Select Product Random Product From List
    Sleep    2s
    Click on Element    ${UPDATE_PRODUCTS_BUTTON}

User on at Update Product Page
    No Operation

User Input Information with Existing SKU
    Input SKU    ${SKU_exist}
    Input Product Name    Test Product
    # Select Category
    Input Unit Price    10.99
    Input Description    This is a test product description.

User Input Valid Information Product
    Input SKU    PopEyes
    Input Product Name    Test Product
    # Select Category
    Input Unit Price    10.99
    Input Description    This is a test product description.

###SKU###
Verify Error Message For Empty SKU
    Check validation error message    xpath=//p[normalize-space(text())='SKU is required.']    SKU is required.

Verify Error Message For Min SKU
    Check validation error message    xpath=//p[normalize-space(text())='SKU must be at least 2 characters.']    SKU must be at least 2 characters.    

Verify Error Message For Max SKU
    Check validation error message    xpath=//p[normalize-space(text())='SKU must be at most 50 characters.']    SKU must be at most 50 characters.    

Verify No Error Message For Valid SKU
    Page Should Not Contain           xpath=//p[normalize-space(text())='SKU must be at most 50 characters.']    SKU must be at most 50 characters.

###Product Name###
Verify Error Message For Empty Product Name
    Check validation error message    xpath=//p[normalize-space(text())='Product name is required.']    Product name is required.

Verify Error Message For Min Product Name
    Check validation error message    xpath=//p[normalize-space(text())='Product name must be at least 2 characters.']    Product name must be at least 2 characters.

Verify Error Message For Max Product Name
    Check validation error message    xpath=//p[normalize-space(text())='Product name must be at most 100 characters.']    Product name must be at most 100 characters.

Verify No Error Message For Valid Product Name
    Page Should Not Contain           xpath=//p[normalize-space(text())='Product name must be at most 100 characters.']    Product name must be at most 100 characters.

###Category###
Verify Error Message For Empty Category
    Check validation error message    xpath=//p[normalize-space(text())='Category is required.']    Category is required.

Verify No Error Message For Valid Category
    Page Should Not Contain           xpath=//p[normalize-space(text())='Category is required.']    Category is required.

###Price###
Verify Error Message For Empty Price
    Check validation error message    xpath=//p[normalize-space(text())='Unit Price is required']    Unit Price is required

Verify No Error Message For Valid Price
    Page Should Not Contain           xpath=//p[normalize-space(text())='Unit Price is required']    Unit Price is required

###Description###
Verify Error Message For Min Description
    Check validation error message    xpath=//p[normalize-space(text())='Description must be at least 2 characters.']    Description must be at least 2 characters.    

Verify Error Message For Max Description
    Check validation error message    xpath=//p[normalize-space(text())='Description must be at most 500 characters.']    Description must be at most 500 characters.    

Verify No Error Message For Valid Description
    Page Should Not Contain           xpath=//p[normalize-space(text())='Description must be at most 500 characters.']    Description must be at most 500 characters.

###Existing SKU on Create Product###
Verify Error Message For Existing SKU
    Check validation error message    //div[@class="text-sm opacity-90"]    • SKU code already exists

Veridy Success Message For Update Product
    Check validation error message    //div[@class="text-sm opacity-90"]    Update product success

Verify Error Message For Valid Price
    Check validation error message    //div[@class="text-sm opacity-90"]    • Product price must be between 1 and 10,000,000
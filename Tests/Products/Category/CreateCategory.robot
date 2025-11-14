*** Settings ***
Documentation    Test cases for Create Category functionality
Resource    ../../../Resources/PageObject/ProductsPage/CategoryPage/CreateCategoryPage.robot

*** Test Cases ***
Check validation empty Category Name error on Create Product Page
    Given Open Browser and Go To Create Category Page
    When Input Category Name    ${EMPTY}
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Empty Category Name

Check validation min Category Name error on Create Product Page
    Given User on at Create Category Page
    When Input Category Name    ${MIN_STRING_1}
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Min Category Name

Check validation max Category Name error on Create Product Page
    Given User on at Create Category Page
    When Input Category Name    ${LONG_STRING_51}
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Max Category Name
    # [Teardown]    Basic TearDowns

Create Category with existing Category Name on Create Category Page
    Given User on at Create Category Page
    When Input Category Name    ${Category_exist}
    And Click Submit button and wait for response Existing Category Name
    Then Verify Error Message For Exist Category Name
    # [Teardown]    Basic TearDowns

Create Category with valid information on Create Category Page
    Given User on at Create Category Page
    When Input Category Name    ${New_Name_Category}
    And Click Submit button and wait for response Valid Category Name
    Then Veridy Success Message For Create Category
    [Teardown]    Basic TearDowns

*** Keywords ***
Open Browser and Go To Create Category Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_PRODUCTS_BUTTON}
    Click on Element    ${CREATE_CATEGORY_BUTTON}

User on at Create Category Page
    No Operation

Verify Error Message For Empty Category Name
    Check validation error message    xpath=//p[normalize-space(text())='Category Name is required']    Category Name is required

Verify Error Message For Min Category Name
    Check validation error message    xpath=//div[@class="text-sm opacity-90"]    • Category name must be between 3 and 50 characters    

Verify Error Message For Max Category Name
    Check validation error message    xpath=//div[@class="text-sm opacity-90"]    • Category name must be between 3 and 50 characters

# Verify No Error Message For Valid Category Name
#     Page Should Not Contain           xpath=//p[normalize-space(text())='SKU must be at most 50 characters.']    SKU must be at most 50 characters.

Verify Error Message For Exist Category Name
    Check validation error message    xpath=//div[@class="text-sm opacity-90"]    • Category name already exists

Veridy Success Message For Create Category
    Check validation error message    xpath=//div[@class="text-sm opacity-90"]     Create new category success
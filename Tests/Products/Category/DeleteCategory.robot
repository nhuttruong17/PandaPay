*** Settings ***
Documentation    Test cases for Delete Category functionality
Resource    ../../../Resources/PageObject/ProductsPage/CategoryPage/DeleteCategoryPage.robot
*** Test Cases ***
Delete Product Successfully
    Given Open Browser and Go To Delete Category Page
    When Choose Category Random Category From List
    # And Click Submit button and wait for response Delete Category
    # Then Verify Success Message For Delete Category
    [Teardown]    Basic TearDowns

** Keywords **
Open Browser and Go To Delete Category Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_PRODUCTS_BUTTON}
    Click on Element    ${LIST_CATEGORY_BUTTON}

Choose Category Random Category From List
    Select Category Random Category From List
    Sleep    2s
    # Click on Element    ${DELETE_PRODUCTS_BUTTON}

Verify Success Message For Delete Category
    Check validation error message    //div[@class="text-sm opacity-90"]    Delete category success
    
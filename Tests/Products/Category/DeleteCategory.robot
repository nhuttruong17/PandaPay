*** Settings ***
Documentation    Test cases for Delete Category functionality
Resource    ../../../Resources/PageObject/ProductsPage/CategoryPage/DeleteCategoryPage.robot
*** Test Cases ***
Verify System Delete Category Successfully
    [Documentation]    Verify that the system can delete a category successfully from the list
    [Tags]    Category    Delete    Positive
    Given Open Browser and Go To Delete Category Page
    When Choose Category Random And Delete Category From List
    Then Verify Success Message For Delete Category
    [Teardown]    Basic TearDowns

** Keywords **
Open Browser and Go To Delete Category Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_PRODUCTS_BUTTON}
    Click on Element    ${LIST_CATEGORY_BUTTON}

Choose Category Random And Delete Category From List
    Select Category and Click on Delete Category From List
    Sleep    2s

Verify Success Message For Delete Category
    Check validation error message    //div[@class="text-sm opacity-90"]    Delete category success
    
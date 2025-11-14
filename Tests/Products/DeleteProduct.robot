*** Settings ***
Documentation    Test cases for Delete Products functionality
Resource    ../../Resources/PageObject/ProductsPage/DeleteProductPage.robot
*** Test Cases ***
Delete Product Successfully
    Given Open Browser and Go To Delete Products Page
    When Choose Product Random Product From List
    And Click Submit button and wait for response Delete Product
    Then Verify Success Message For Delete Product
    [Teardown]    Basic TearDowns

** Keywords **
Open Browser and Go To Delete Products Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_PRODUCTS_BUTTON}
    
Choose Product Random Product From List
    Select Product Random Product From List
    Sleep    2s
    Click on Element    ${DELETE_PRODUCTS_BUTTON}

Verify Success Message For Delete Product
    Check validation error message    //div[@class="text-sm opacity-90"]    Delete product success
    
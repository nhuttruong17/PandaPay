*** Settings ***
Documentation    Test cases for Delete Products functionality
Resource    ../../Resources/PageObject/ProductsPage/DeleteProductPage.robot
*** Test Cases ***
Verify the system Delete Product Successfully
    [Documentation]    Verify that the system successfully deletes a product and displays the correct success message on the Delete Product Page.
    [Tags]    functional    delete_product    positive
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
    
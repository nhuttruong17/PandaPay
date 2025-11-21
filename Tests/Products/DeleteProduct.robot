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
    
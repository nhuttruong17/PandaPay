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
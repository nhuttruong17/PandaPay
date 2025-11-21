*** Settings ***
Documentation    Test cases for Create Category functionality
Resource    ../../../Resources/PageObject/ProductsPage/CategoryPage/CreateCategoryPage.robot

*** Test Cases ***    
Check validation empty Category Name error on Create Product Page
    [Documentation]    Verify that the system displays a validation error when Category Name is empty on the Create Category Page.
    [Tags]    validation    create_category    regression
    Given Open Browser and Go To Create Category Page
    When Input Category Name    ${EMPTY}
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Empty Category Name

Check validation min Category Name error on Create Product Page
    [Documentation]    Verify that the system displays a validation error when Category Name has fewer than the minimum allowed characters.
    [Tags]    validation    create_category    regression
    Given User on at Create Category Page
    When Input Category Name    ${MIN_STRING_1}
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Min Category Name

Check validation max Category Name error on Create Product Page
    [Documentation]    Verify that the system displays a validation error when Category Name exceeds the maximum allowed characters.
    [Tags]    validation    create_category    regression
    Given User on at Create Category Page
    When Input Category Name    ${LONG_STRING_51}
    And Click on Element    ${Submit_BUTTON_Product}
    Then Verify Error Message For Max Category Name

Create Category with existing Category Name on Create Category Page
    [Documentation]    Verify that the system returns the correct validation error when using an existing Category Name on the Create Category Page.
    [Tags]    functional    create_category    negative
    Given User on at Create Category Page
    When Input Category Name    ${Category_exist}
    And Click Submit button and wait for response Existing Category Name
    Then Verify Error Message For Exist Category Name

Create Category with valid information on Create Category Page
    [Documentation]    Verify that the system successfully creates a new category when valid information is provided.
    [Tags]    functional    create_category    positive
    Given User on at Create Category Page
    When Input Category Name    ${New_Name_Category}
    And Click Submit button and wait for response Valid Category Name
    Then Veridy Success Message For Create Category
    [Teardown]    Basic TearDowns
*** Settings ***
Documentation    Test cases for Update Category functionality
Resource    ../../../Resources/PageObject/ProductsPage/CategoryPage/UpdateCategoryPage.robot
*** Test Cases ***
# Check validation empty Category Name error on Create Product Page
#     [Documentation]    Verify that Category Name shows validation error when input is empty on Create Product Page
#     [Tags]    Category    Validation    Empty
#     Given Open Browser and Go To Update Category Page
#     When Input Category Name    ${EMPTY}
#     And Click on Element    ${Submit_BUTTON_Category}
#     Then Verify Error Message For Empty Category Name

Check validation min Category Name error on Create Product Page
    [Documentation]    Verify validation error when Category Name has minimum invalid length
    [Tags]    Category    Validation    MinLength
    Given Open Browser and Go To Update Category Page
    When Input Category Name    ${MIN_STRING_1}
    And Click on Element    ${Submit_BUTTON_Category}
    Then Verify Error Message For Min Category Name

Check validation max Category Name error on Create Product Page
    [Documentation]    Verify validation error when Category Name exceeds maximum length on Update Category Page
    [Tags]    Category    Validation    MaxLength
    Given User on at Update Category Page
    When Input Category Name    ${LONG_STRING_51}
    And Click on Element    ${Submit_BUTTON_Category}
    Then Verify Error Message For Max Category Name

Update Category with existing Category Name on Update Category Page
    [Documentation]    Verify updating Category with an already existing name shows proper error message
    [Tags]    Category    Update    Negative
    Given User on at Update Category Page
    When Input Category Name    ${Category_exist}
    And Click Submit button and wait for response Existing Category Name
    Then Verify Error Message For Exist Category Name

Update Category with valid information on Update Category Page
    [Documentation]    Verify that category is updated successfully when input information is valid
    [Tags]    Category    Update    Positive
    Given User on at Update Category Page
    When Input Category Name    ${New_Name_Category}
    And Click Submit button and wait for response Valid Category Name
    Then Verify Success Message For Update Category
    [Teardown]    Basic TearDowns

** Keywords **
Open Browser and Go To Update Category Page
    Basic Setup
    Restore Browser Session
    Click on Element    ${Tab_PRODUCTS_BUTTON}
    Click on Element    ${LIST_CATEGORY_BUTTON}
    Select Category Random Category From List
    Generate Random Data New Category
    Sleep    5s

Choose Category Random Category From List
    Select Category Random Category From List
    Sleep    5s

User on at Update Category Page
    No Operation

Verify Error Message For Empty Category Name
    Check validation error message    xpath=//p[normalize-space(text())='Category Name is required']    Category Name is required

Verify Error Message For Min Category Name
    Check validation error message    xpath=//div[@class="text-sm opacity-90"]    • Category name must be between 3 and 50 characters    

Verify Error Message For Max Category Name
    Check validation error message    xpath=//div[@class="text-sm opacity-90"]    • Category name must be between 3 and 50 characters

Verify Error Message For Exist Category Name
    Check validation error message    xpath=//div[@class="text-sm opacity-90"]    • Category name already exists

Verify Success Message For Update Category
    Check validation error message    //div[@class="text-sm opacity-90"]    Edit Category success
    
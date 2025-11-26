*** Settings ***
Resource        ../../Resources/PageObject/LoginPage/LoginPage.robot
Resource        ../../TestData/LoginData/LoginData.robot
Suite Setup     Basic Setup iOS
Suite Teardown  Basic TearDowns iOS
*** Test Cases ***
#Test case validation text UserID
payment with Sale card
    Sleep    5s
    Click on Element mobile    //XCUIElementTypeStaticText[@name="Sale"]
    Click on Element mobile    //XCUIElementTypeKey[@name="2"]
    Click on Element mobile    //XCUIElementTypeKey[@name="0"]
    Click on Element mobile    //XCUIElementTypeKey[@name="0"]

    Click on Element mobile     xpath=//XCUIElementTypeStaticText[contains(normalize-space(@name), "Proceed Payment")]
    Click on Element mobile    xpath=//XCUIElementTypeStaticText[@name="Confirm"]
    
    Sleep    3s
    
    Check validation error message mobile    //XCUIElementTypeStaticText[@name="Payment successfully"]    Payment successfully
    ${Get_value}=        AppiumLibrary.Get Element Attribute      //XCUIElementTypeStaticText[contains(@name, "$")]      name
    Log    ${Get_value}
    Click on Element mobile    //XCUIElementTypeStaticText[@name="Skip"]

    Check validation error message mobile    //XCUIElementTypeStaticText[@name="Batch close"]    Batch close
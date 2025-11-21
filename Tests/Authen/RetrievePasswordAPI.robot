*** Settings ***
Resource        ../../Resources/PageObject/RetrievePasswordPage/RetrievePasswordPage.robot
*** Test Cases ***
Verify Retrieve Password with API, Check API invalid userid
    Check API userid invalid
Verify Retrieve Password with API, Check API valid userid
    Check API userid valid with email & phone number
Verify Retrieve Password with API, Check API userid valid with email & not phone number
    Check API userid valid with email & not phone number
Verify Retrieve Password with API, Check API SendOTP userid not phone number
    Check API userid not phone number
Verify Retrieve Password with API, Check API verify token invalid
    Check API verify token invalid
Verify Retrieve Password with API, Check API send OTP, check token, retrieve password failed with same old password
    Check API send OTP, check token, retrieve password failed with same old password
Verify Retrieve Password with API, Check API send OTP, check token, retrieve password success with phone number
    Check API send OTP, check token, retrieve password success with phone number
Verify Retrieve Password with API, Check API Send OTP, Check token, Retrieve password successfully
    Check API send OTP, check token, retrieve password success with email
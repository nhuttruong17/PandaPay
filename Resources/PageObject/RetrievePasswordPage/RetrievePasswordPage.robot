*** Settings ***
Resource    ../../Locators/RetrievePasswordLocator.robot
Resource    ../../../TestData/RetrivePasswordData/RetrivePasswordData.robot
Resource    ../../../TestKeyWords/Common.robot
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Library    BuiltIn
Library    ../../../LibPy/FinalNetwork.py    WITH NAME    Network

*** Keywords ***
Navigate to Retrieve Password Page
    Click on Element    ${elm_A_RetrivePassword}
    Wait Until Element Is Visible    ${elm_H1_RetrivePassword}    5s
    ${title}=    Get Text    ${elm_H1_RetrivePassword}
    Should Be Equal As Strings    ${title}    ${Expected_H1_RetrivePassword}

Click on Retrieve Password with Wait Request Payload User not existing
    ${driver}=    Prepare For Request Interception    ${CheckUserID_API}
    Click on Element    ${btn_Submit_Retrive}
    Sleep    2s
    #Get Sign In Request
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_200}
    #Verify request parameters
    Should Contain    ${result.url}    ${userID_Invalid}
    #Verify response
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_True}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_200}
    Should Be Equal As Strings    ${parsed.message}    ${EXPECTED_MESSAGE_Retrieve_Payload}
    Should Be Equal As Strings    ${parsed.data.phone_number}    None
    Should Be Equal As Strings    ${parsed.data.email}    None

Check validation text new password & confirm password
    Fill Text Input    ${input_NewPassword}    ${Empty_textPassword}
    Click on Element   ${btn_Submit_Retrive}
    Check validation error message    ${error_empty_New_Password}    ${EXPECTED_ERROR_EmptyPassword}
    Fill Text Input    ${input_NewPassword}    ${Min_textPassword}
    Click on Element   ${btn_Submit_Retrive}
    Check validation error message    ${error_Min_New_Password}    ${EXPECTED_ERROR_MinPassword}
    Fill Text Input    ${input_NewPassword}    ${Missing_Uppercase}
    Click on Element   ${btn_Submit_Retrive}
    Check validation error message    ${error_Missing_Uppercase}    ${EXPECTED_Missing_Uppercase}
    Fill Text Input    ${input_NewPassword}    ${Missing_Lowercase}
    Click on Element   ${btn_Submit_Retrive}
    Check validation error message    ${error_Missing_Lowercase}    ${EXPECTED_Missing_Lowercase}
    Fill Text Input    ${input_NewPassword}    ${Missing_OneNumber}
    Click on Element   ${btn_Submit_Retrive}
    Check validation error message    ${error_Missing_OneNumber}    ${EXPECTED_Missing_OneNumber}
    Fill Text Input    ${input_NewPassword}    ${Missing_OneSpecialCharacter}
    Click on Element   ${btn_Submit_Retrive}
    Check validation error message    ${error_Missing_OneSpecialCharacter}    ${EXPECTED_Missing_OneSpecialCharacter}
    Fill Text Input    ${input_ConfirmPassword}    ${Empty_textPassword}
    Click on Element   ${btn_Submit_Retrive}
    Check validation error message    ${error_empty_Confirm_New_Password}    ${EXPTECTED_empty_ConfirmPassword}
    Fill Text Input    ${input_ConfirmPassword}    ${Min_textPassword}
    Click on Element   ${btn_Submit_Retrive}
    Check validation error message    ${error_Min_Confirm_New_Password}    ${EXPECTED_ERROR_MinConfirmPassword}
    Fill Text Input    ${input_NewPassword}    ${Old_password}
    Fill Text Input    ${input_ConfirmPassword}    ${Missing_Uppercase}
    Click on Element   ${btn_Submit_Retrive}
    Check validation error message    ${error_Confirm_New_Password_NotMatch}    ${EXPECTED_ConfirmPassword_NotMatch}

Click on Verify Retrieve Password with Wait Request Payload
    Click on Element    ${btn_Submit_Retrive}
    Fill Text Input    ${elm_input_OTP}    ${token_empty}
    Click on Element    ${btn_Verify_Retrive}
    Check validation error message    ${error_empty_OTP}    ${EXPECTED_OTP code is required}
    ${driver}=    Prepare For Request Interception    ${CheckToken_API}
    Fill Text Input    ${elm_input_OTP}    ${token_Invalid}
    Click on Element    ${btn_Verify_Retrive}
    Sleep    2s
    ${result}=    Get Request API    ${driver}
    Should Be Equal As Integers    ${result.status}    ${Status_400}
    Should Contain    ${result.payload}    ${token_Invalid}
    Should Contain    ${result.payload}    ${Valid_userID}
    &{parsed}=    Parse Response API   ${result.body}
    Should Be Equal As Strings    ${parsed.success}    ${Boolean_False}
    Should Be Equal As Integers    ${parsed.statusCode}    ${Status_400}
    Should Be Equal As Strings    ${parsed.message}    ${EXPECTED_INVALID_INPUT}
    Should Contain    ${parsed.data.token}    ${EXPECTED_ERROR_MESSAGE_Tokeninvalid}

Click on Retrieve with Wait Request Payload New Password Same Old Password
    ${driver_send_otp}=    Prepare For Request Interception    ${SENDOTP_API}
    Click on Element    ${btn_Submit_Retrive}
    Click on Element    ${btn_radio_Email}
    Click on Element    ${btn_Confirm_Retrive}
    Sleep    2s
    ${result}=    Get Request API    ${driver_send_otp}
    Should Be Equal As Integers    ${result.status}    ${Status_202}
    Should Contain    ${result.payload}    ${userID_SchoolLe}
    Should Contain    ${result.payload}    ${Type_Email}
    &{parsed}=    Parse Response API   ${result.body}
    ${parsed.data.token}=    Set Variable    ${parsed.data.token}
    ${driver_check_token}=    Prepare For Request Interception    ${CheckToken_API}
    Fill Text Input    ${elm_input_OTP}    ${parsed.data.token}
    Click on Element    ${btn_Verify_Retrive}
    Check validation error message    ${elm_message}    ${EXPECTED_CheckToken_Success}
    Sleep    2s
    ${checktoken}=   Get Request API    ${driver_check_token}
    Should Be Equal As Integers    ${checktoken.status}    ${Status_200}
    Should Contain    ${checktoken.payload}    ${userID_SchoolLe}
    &{parsedRetoken}=    Parse Response API   ${checktoken.body}
    ${messageRetoken}=    Set Variable    ${parsedRetoken.message}
    Should Be Equal As Strings    ${messageRetoken}    ${EXPECTED_TOKEN_API_Success}
    Check validation text new password & confirm password
    Fill Text Input    ${input_NewPassword}    ${Old_password}
    Fill Text Input    ${input_ConfirmPassword}    ${Old_password}
    ${driver_retrieve_pass}=    Prepare For Request Interception    ${RetrivePassword_API}
    Click on Element   ${btn_Submit_Retrive}
    Sleep    2s
    ${retrieve_password}=   Get Request API    ${driver_retrieve_pass}
    Should Be Equal As Integers    ${retrieve_password.status}    ${Status_400}
    ${parsed_retrieve_password}=    Parse Response API   ${retrieve_password.body}
    Should Be Equal As Strings    ${parsed_retrieve_password.success}    ${Boolean_False}
    Should Be Equal As Integers    ${parsed_retrieve_password.statusCode}    ${Status_400}
    Should Be Equal As Strings    ${parsed_retrieve_password.message}    ${EXPECTED_INVALID_INPUT}

Click on Retrieve with Wait Request Payload UserID valid with email
    ${driver_send_otp}=    Prepare For Request Interception    ${SENDOTP_API}
    Click on Element    ${btn_Submit_Retrive}
    Sleep    2s
    ${result}=    Get Request API    ${driver_send_otp}
    Should Be Equal As Integers    ${result.status}    ${Status_202}
    Should Contain    ${result.payload}    ${Valid_userID}
    Should Contain    ${result.payload}    ${Type_Email}
    &{parsed}=    Parse Response API   ${result.body}
    ${parsed.data.token}=    Set Variable    ${parsed.data.token}
    ${driver_check_token}=    Prepare For Request Interception    ${CheckToken_API}
    Fill Text Input    ${elm_input_OTP}    ${parsed.data.token}
    Click on Element    ${btn_Verify_Retrive}
    Check validation error message    ${elm_message}    ${EXPECTED_CheckToken_Success}
    Sleep    2s
    ${checktoken}=   Get Request API    ${driver_check_token}
    Should Be Equal As Integers    ${checktoken.status}    ${Status_200}
    Should Contain    ${checktoken.payload}    ${Valid_userID}
    &{parsedRetoken}=    Parse Response API   ${checktoken.body}
    ${messageRetoken}=    Set Variable    ${parsedRetoken.message}
    Should Be Equal As Strings    ${messageRetoken}    ${EXPECTED_TOKEN_API_Success}
    Check validation text new password & confirm password
    ${newpassword}=  Generate Secure Password
    ${confirmpassword}=    Set Variable    ${newpassword}
    Fill Text Input    ${input_NewPassword}    ${newpassword}
    Fill Text Input    ${input_ConfirmPassword}    ${confirmpassword}
    ${driver_retrieve_pass}=    Prepare For Request Interception    ${RetrivePassword_API}
    Click on Element   ${btn_Submit_Retrive}
    Sleep    2s
    ${retrieve_password}=   Get Request API    ${driver_retrieve_pass}
    Should Be Equal As Integers    ${retrieve_password.status}    ${Status_200}
    ${parsed_retrieve_password}=    Parse Response API   ${retrieve_password.body}
    Should Be Equal As Strings    ${parsed_retrieve_password.success}    ${Boolean_True}
    Should Be Equal As Integers    ${parsed_retrieve_password.statusCode}    ${Status_200}
    Should Be Equal As Strings    ${parsed_retrieve_password.message}    ${EXPECTED_SUCCESS_MESSAGE_Retrieve}

Click on Retrieve with Wait Request Payload UserID valid with phone number
    ${driver_send_otp}=    Prepare For Request Interception    ${SENDOTP_API}
    Click on Element    ${btn_Submit_Retrive}
    Click on Element    ${btn_radio_SMS}
    Click on Element    ${btn_Confirm_Retrive}
    Sleep    2s
    ${result}=    Get Request API    ${driver_send_otp}
    Should Be Equal As Integers    ${result.status}    ${Status_202}
    Should Contain    ${result.payload}    ${userID_Johny}
    Should Contain    ${result.payload}    ${Type_PhoneNumber}
    &{parsed}=    Parse Response API   ${result.body}
    ${parsed.data.token}=    Set Variable    ${parsed.data.token}
    ${driver_check_token}=    Prepare For Request Interception    ${CheckToken_API}
    Fill Text Input    ${elm_input_OTP}    ${parsed.data.token}
    Click on Element    ${btn_Verify_Retrive}
    Check validation error message    ${elm_message}    ${EXPECTED_CheckToken_Success}
    Sleep    2s
    ${checktoken}=   Get Request API    ${driver_check_token}
    Should Be Equal As Integers    ${checktoken.status}    ${Status_200}
    Should Contain    ${checktoken.payload}    ${userID_Johny}
    &{parsedRetoken}=    Parse Response API   ${checktoken.body}
    ${messageRetoken}=    Set Variable    ${parsedRetoken.message}
    Should Be Equal As Strings    ${messageRetoken}    ${EXPECTED_TOKEN_API_Success}
    Check validation text new password & confirm password
    ${newpassword}=  Generate Secure Password
    ${confirmpassword}=    Set Variable    ${newpassword}
    Fill Text Input    ${input_NewPassword}    ${newpassword}
    Fill Text Input    ${input_ConfirmPassword}    ${confirmpassword}
    ${driver_retrieve_pass}=    Prepare For Request Interception    ${RetrivePassword_API}
    Click on Element   ${btn_Submit_Retrive}
    Sleep    2s
    ${retrieve_password}=   Get Request API    ${driver_retrieve_pass}
    Should Be Equal As Integers    ${retrieve_password.status}    ${Status_200}
    ${parsed_retrieve_password}=    Parse Response API     ${retrieve_password.body}
    Should Be Equal As Strings    ${parsed_retrieve_password.success}    ${Boolean_True}
    Should Be Equal As Integers    ${parsed_retrieve_password.statusCode}    ${Status_200}
    Should Be Equal As Strings    ${parsed_retrieve_password.message}    ${EXPECTED_SUCCESS_MESSAGE_Retrieve}

##API Retrieve Password###
Check API userid invalid
    ${params}=    Create Dictionary    user_id=${userID_Invalid}
    ${response}=  API Request With Params   ${Method_GET}    ${URL_CheckUserID}    ${params}    ${Status_200}
    ${json}=    Evaluate    json.loads('''${response.content}''')    modules=json
    ${data_email}=    Get From Dictionary    ${json['data']}    email
    ${data_phonenumber}=    Get From Dictionary    ${json['data']}    phone_number
    Should Be Equal As Strings    ${data_email}    None
    Should Be Equal As Strings    ${data_phonenumber}    None

Check API userid valid with email & phone number
    ${params}=    Create Dictionary    user_id=${userID_Johny}
    ${response}=  API Request With Params   ${Method_GET}    ${URL_CheckUserID}    ${params}    ${Status_200}
    ${json}=    Evaluate    json.loads('''${response.content}''')    modules=json
    ${data_email}=    Get From Dictionary    ${json['data']}    email
    ${data_phonenumber}=    Get From Dictionary    ${json['data']}    phone_number
    Should Be Equal As Strings    ${data_email}   ${Email_Johny}
    Should Be Equal As Strings    ${data_phonenumber}    ${PhoneNumber_Johny}

Check API userid valid with email & not phone number
    ${params}=    Create Dictionary    user_id=${Valid_userID}
    ${response}=  API Request With Params   ${Method_GET}    ${URL_CheckUserID}    ${params}    ${Status_200}
    ${json}=    Evaluate    json.loads('''${response.content}''')    modules=json
    ${data_email}=    Get From Dictionary    ${json['data']}    email
    Should Be Equal As Strings    ${data_email}   ${Email_UserID_Valid}

Check API userid not phone number
    ${response}=  API Request   ${Method_PUT}    ${SendOTP_URL}    ${PAYLOAD_NotPhoneNumber}    ${Status_400}
    ${json}=    Evaluate    json.loads('''${response.content}''')    modules=json
    ${code}=    Get From Dictionary    ${json['data']}    user_id
    Should Contain    ${code}    ${EXPECTED_ERROR_MESSAGE_NotPhoneNumber}

Check API verify token invalid
    ${response}=  API Request    ${Method_PUT}    ${URL_Checktoken}    ${PAYLOAD_TokenInvalid}    ${Status_400}
    ${json}=    Evaluate    json.loads('''${response.content}''')    modules=json
    ${code}=    Get From Dictionary    ${json['data']}    token
    Should Contain    ${code}    ${EXPECTED_ERROR_MESSAGE_Tokeninvalid}

Check API send OTP, check token, retrieve password failed with same old password
    ${response}=  API Request   ${Method_PUT}    ${SendOTP_URL}    ${PAYLOAD_Faild_UserIdinactive}    ${Status_202}
    ${json}=    Evaluate    json.loads('''${response.content}''')    modules=json
    ${token}=    Get From Dictionary    ${json['data']}    token
    Should Contain    ${response.content}    ${EXPECTED_SUCCESS_MESSAGE_API}
    #Check token success API
    &{PAYLOAD_CheckToken}=     Create Dictionary     user_id=${userID_Schoolinactive}   token=${token}
    ${checktoken}=   API Request    ${Method_PUT}    ${URL_Checktoken}    ${PAYLOAD_CheckToken}    ${Status_200}
    Should Contain    ${checktoken.content}    ${EXPECTED_TOKEN_API_Success}
    # Retrieve password failed API with same old password
    &{PAYLOAD_RetriveFailed}=   Create Dictionary     user_id=${userID_Schoolinactive}   token=${token}   new_password=${Old_password}   confirm_new_password=${Old_password}
    ${retrieve_password}=   API Request   ${Method_PUT}   ${URL_Retrive}   ${PAYLOAD_RetriveFailed}   ${Status_400}
    Should Contain     ${retrieve_password.content}     ${EXPECTED_INVALID_INPUT}

Check API send OTP, check token, retrieve password success with phone number
    ${newpassword}=  Generate Secure Password
    ${confirmpassword}=    Set Variable    ${newpassword}
    #Send OTP success API
    ${response}=  API Request   ${Method_PUT}    ${SendOTP_URL}    ${PAYLOAD_SUCCESS_Phonenumber}    ${Status_202}
    ${json}=    Evaluate    json.loads('''${response.content}''')    modules=json
    ${token}=    Get From Dictionary    ${json['data']}    token
    Should Contain    ${response.content}    ${EXPECTED_SUCCESS_MESSAGE_API}
    #Check token success API
    &{PAYLOAD_CheckToken}=     Create Dictionary     user_id=${userID_Johny}   token=${token}
    ${checktoken}=   API Request    ${Method_PUT}    ${URL_Checktoken}    ${PAYLOAD_CheckToken}    ${Status_200}
    Should Contain    ${checktoken.content}    ${EXPECTED_TOKEN_API_Success}
    # Retrieve password success API
    &{PAYLOAD_RetriveSuccess}=    Create Dictionary     user_id=${userID_Johny}    token=${token}    new_password=${newpassword}    confirm_new_password=${confirmpassword}
    ${retrieve_password}=   API Request    ${Method_PUT}    ${URL_Retrive}    ${PAYLOAD_RetriveSuccess}    ${Status_200}
    Should Contain    ${retrieve_password.content}    ${EXPECTED_SUCCESS_MESSAGE_Retrieve}

Check API send OTP, check token, retrieve password success with email
    ${newpassword}=  Generate Secure Password
    ${confirmpassword}=    Set Variable    ${newpassword}
    #Send OTP success API
    ${response}=  API Request    ${Method_PUT}    ${SendOTP_URL}    ${PAYLOAD_SUCCESS_UserId}    ${Status_202}
    ${json}=    Evaluate    json.loads('''${response.content}''')    modules=json
    ${token}=    Get From Dictionary    ${json['data']}    token
    Should Contain    ${response.content}    ${EXPECTED_SUCCESS_MESSAGE_API}
    #Check token success API
    &{PAYLOAD_CheckToken}=     Create Dictionary     user_id=${Valid_userID}   token=${token}
    ${checktoken}=   API Request    ${Method_PUT}    ${URL_Checktoken}    ${PAYLOAD_CheckToken}    ${Status_200}
    Should Contain    ${checktoken.content}    ${EXPECTED_TOKEN_API_Success}
    # Retrieve password success API
    &{PAYLOAD_RetriveSuccess}=    Create Dictionary     user_id=${Valid_userID}    token=${token}    new_password=${newpassword}    confirm_new_password=${confirmpassword}
    ${retrieve_password}=   API Request    ${Method_PUT}    ${URL_Retrive}    ${PAYLOAD_RetriveSuccess}    ${Status_200}
    Should Contain    ${retrieve_password.content}    ${EXPECTED_SUCCESS_MESSAGE_Retrieve}
*** Variables ***
#elements Login
${input_UserID}     //input[@id='user_code']
${input_Password}   //input[@id='password']
${btn_SignIn}       //button[@type='submit']
${btn_Logout}       //div[contains(text(),"Logout")]

#elements message Expected Result Login successfully
${EXPECTED_ERROR_Sucess_Payload}    true
${EXPECTED_SUCCESS_MESSAGE}  Daily Batch Report
${EXPECTED_SUCCESS_MESSAGE_API}    SIGN_IN_SUCCESSFULLY

#elements message Expected Result Logout successfully
${elm_Logout}      //h1[normalize-space()='Welcome!']
${EXPECTED_SUCCESS_LOGOUT}  Welcome!
${Expected_message_Signout}    Sign out successfully

#elements message Expected Result Login Failed
${elm_error_message}        //div[contains(text(),'Incorrect User ID or Password')]
${EXPECTED_ERROR_MESSAGE}    Incorrect User ID or Password
#Error Payload
${EXPECTED_ERROR_False_Payload}    False
${EXPECTED_ERROR_MESSAGE_SignIn_Payload}    AUTHENTICATION_FAILED
#Error API
${EXPECTED_ERROR_MESSAGE_API}   AUT001

#elements message Expected Result Login Failed with account inactive
${elm_error_message_inactive}        //div[contains(text(),'Account Deactivated. Please contact admin.')]
${EXPECTED_ERROR_MESSAGE_inactive}    Account Deactivated. Please contact admin.
${EXPECTED_ERROR_MESSAGE_API_inactive}    AUT014

#elements Error Message & Expected Result of Validation text UserID
${error_empty_UserID}     //p[contains(@id, ':r2:-form-item-message') and contains(text(), 'The User ID cannot be empty')]
${EXPECTED_ERROR_EmptyUserID}    The User ID cannot be empty

${error_invalid_UserID}     //p[contains(@id, ':r2:-form-item-message') and contains(text(), 'The User ID must be alphanumeric')]
${EXPECTED_ERROR_InvalidUserID}    The User ID must be alphanumeric

${error_min_UserID}     //p[contains(@id, ':r2:-form-item-message') and contains(text(), 'Username must be at least 5 characters.')]
${EXPECTED_ERROR_MinUserID}    Username must be at least 5 characters.

${error_max_UserID}     //p[contains(@id, ':r2:-form-item-message') and contains(text(), 'Username must be at most 20 characters.')]
${EXPECTED_ERROR_MaxUserID}    Username must be at most 20 characters.

#elements Error Message & Expected Result of Validation text Password
${error_empty_Password}     //p[contains(@id, ':r3:-form-item-message') and contains(text(), 'The Password cannot be empty')]
${EXPECTED_ERROR_EmptyPassword}    The Password cannot be empty

${error_min_Password}     //p[contains(@id, ':r3:-form-item-message') and contains(text(), 'Password must be at least 8 characters')]
${EXPECTED_ERROR_MinPassword}    Password must be at least 8 characters.

${error_Missing_Uppercase}     //p[contains(@id, ':r3:-form-item-message') and contains(text(), 'Password must contain at least one uppercase letter.')]
${EXPECTED_Missing_Uppercase}    Password must contain at least one uppercase letter.

${error_Missing_Lowercase}     //p[contains(@id, ':r3:-form-item-message') and contains(text(), 'Password must contain at least one lowercase letter.')]
${EXPECTED_Missing_Lowercase}    Password must contain at least one lowercase letter.

${error_Missing_OneNumber}     //p[contains(@id, ':r3:-form-item-message') and contains(text(), 'Password must contain at least one number.')]
${EXPECTED_Missing_OneNumber}    Password must contain at least one number.

${error_Missing_OneSpecialCharacter}     //p[contains(@id, ':r3:-form-item-message') and contains(text(), 'Password must contain at least one special character.')]
${EXPECTED_Missing_OneSpecialCharacter}    Password must contain at least one special character.

# Varibale Endpoint API
${SIGNIN_API}     api/user/sign-in/
${Profile_API}    api/user/me/profile/
${SIGNOUT_API}    api/logout/


*** Variables ***
#elements Login
${input_UserID}     //input[@id='user_code']
${input_Password}   //input[@id='password']
${btn_SignIn}       //button[@type='submit']
${btn_Logout}       //div[contains(text(),"Logout")]

#elements message Expected Result Login successfully
${EXPECTED_ERROR_Sucess_Payload}    true
${EXPECTED_SUCCESS_MESSAGE}         Daily Batch Report
${EXPECTED_SUCCESS_MESSAGE_API}     SIGN_IN_SUCCESSFULLY

#elements message Expected Result Logout successfully
${elm_Logout}                   //h1[normalize-space()='Welcome!']
${EXPECTED_SUCCESS_LOGOUT}      Welcome!
${Expected_message_Signout}     Sign out successfully

#elements message Expected Result Login Failed
${elm_error_message}          //div[contains(text(),'Incorrect User ID or Password')]
${EXPECTED_ERROR_MESSAGE}     Incorrect User ID or Password
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
${error_empty_UserID}            //p[contains(@id, ':r2:-form-item-message') and contains(text(), 'The User ID cannot be empty')]
${EXPECTED_ERROR_EmptyUserID}    The User ID cannot be empty

${error_invalid_UserID}            //p[contains(@id, ':r2:-form-item-message') and contains(text(), 'The User ID must be alphanumeric')]
${EXPECTED_ERROR_InvalidUserID}    The User ID must be alphanumeric

${error_min_UserID}            //p[contains(@id, ':r2:-form-item-message') and contains(text(), 'Username must be at least 5 characters.')]
${EXPECTED_ERROR_MinUserID}    Username must be at least 5 characters.

${error_max_UserID}            //p[contains(@id, ':r2:-form-item-message') and contains(text(), 'Username must be at most 20 characters.')]
${EXPECTED_ERROR_MaxUserID}    Username must be at most 20 characters.

#elements Error Message & Expected Result of Validation text Password
${error_empty_Password}            //p[contains(@id, ':r3:-form-item-message') and contains(text(), 'The Password cannot be empty')]
${EXPECTED_ERROR_EmptyPassword}    The Password cannot be empty

${error_min_Password}             //p[contains(@id, ':r3:-form-item-message') and contains(text(), 'Password must be at least 8 characters')]
${EXPECTED_ERROR_MinPassword}     Password must be at least 8 characters.

${error_Missing_Uppercase}       //p[contains(@id, ':r3:-form-item-message') and contains(text(), 'Password must contain at least one uppercase letter.')]
${EXPECTED_Missing_Uppercase}    Password must contain at least one uppercase letter.

${error_Missing_Lowercase}       //p[contains(@id, ':r3:-form-item-message') and contains(text(), 'Password must contain at least one lowercase letter.')]
${EXPECTED_Missing_Lowercase}    Password must contain at least one lowercase letter.

${error_Missing_OneNumber}       //p[contains(@id, ':r3:-form-item-message') and contains(text(), 'Password must contain at least one number.')]
${EXPECTED_Missing_OneNumber}    Password must contain at least one number.

${error_Missing_OneSpecialCharacter}     //p[contains(@id, ':r3:-form-item-message') and contains(text(), 'Password must contain at least one special character.')]
${EXPECTED_Missing_OneSpecialCharacter}    Password must contain at least one special character.

# Varibale Endpoint API
${SIGNIN_API}     api/user/sign-in/
${Profile_API}    api/user/me/profile/
${SIGNOUT_API}    api/logout/

# Element IOS
${input_UserID_IOS}      //XCUIElementTypeTextField[@name="Enter your User ID"]
${elm_clickscreen}       //XCUIElementTypeWindow/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeImage[2]
${btn_Login_IOS}         //XCUIElementTypeStaticText[@name="Login"]
${input_Password_IOS}    //XCUIElementTypeTextField[@name="Enter your Password"]
${elm_Settings_IOS}      //XCUIElementTypeStaticText[@name="Settings"]
${elem_SignOut_IOS}      //XCUIElementTypeStaticText[@name="Sign Out"]
${elm_confirm_Yes}       //XCUIElementTypeStaticText[@name="Yes"]
${elm_welcome_IOS}       //XCUIElementTypeStaticText[@name="Welcome!"]
${Expected_Welcome_IOS}    Welcome!

${elm_error_empty_UserID_IOS}      //XCUIElementTypeTextField[@name="Enter your User ID"]/following-sibling::XCUIElementTypeStaticText[@name="This field is required"]
${Expected_error_emptyfield}        This field is required

${elm_MinUserID}      //XCUIElementTypeStaticText[@name="User ID must be 5 characters or longer!"]
${Expected_MinUserID}        User ID must be 5 characters or longer!

${elm_MaxUserID}      //XCUIElementTypeStaticText[@name="User ID must be 20 characters or fewer!"]
${Expected_MaxUserID}        User ID must be 20 characters or fewer!

${elm_SpecialCharacters}      //XCUIElementTypeStaticText[@name="Special characters are not allowed"]
${EXPECTED_SpecialCharacters}        Special characters are not allowed

${elm_showPassword}      //XCUIElementTypeApplication[@name="Panda App Prod"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[1]/XCUIElementTypeOther


${elm_error_empty_Password_IOS}      //XCUIElementTypeStaticText[@name="This field is required"]

${elm_MinPassword}             //XCUIElementTypeStaticText[@name="Password must be 8 characters or longer!"]
${Expected_MinPassword}        Password must be 8 characters or longer!

${elm_validationtext_password}             //XCUIElementTypeStaticText[@name="Password should contain at least one upper case, lower case, digit and special character"]
${EXPECTED_validationtext_password}        Password should contain at least one upper case, lower case, digit and special character

${elm_validationtext_confirm_password}          //XCUIElementTypeStaticText[@name="Confirm password and password must be match"]
${EXPECTED_validationtext_confirmpassword}      Confirm password and password must be match
${Click_shownewpassword}                        //XCUIElementTypeApplication[@name="Panda App Prod"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[3]/XCUIElementTypeOther[1]/XCUIElementTypeOther
${elm_login_failed_IOS}                         //XCUIElementTypeOther[@name="Incorrect User ID or Password"]
${Expected_login_failed_IOS}                    Incorrect User ID or Password

${elm_login_success_IOS}         //XCUIElementTypeOther[@name="Sign in successful"]
${Expected_login_success_IOS}    Sign in successful

${elm_login_inactive_IOS}         //XCUIElementTypeOther[@name="Account Deactivated. Please contact admin."]
${Expected_login_inactive_IOS}    Account Deactivated. Please contact admin.


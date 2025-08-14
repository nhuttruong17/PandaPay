*** Variables ***
${elm_A_RetrivePassword}   //a[normalize-space()='Retrieve password']
${elm_H1_RetrivePassword}   //h1[normalize-space()='Retrieve Password']
${Expected_H1_RetrivePassword}   Retrieve Password
${input_UserID_Retrive}   //input[@placeholder='User ID']
${btn_Submit_Retrive}   //button[normalize-space()='Submit']
${btn_radio_Email}      //button[@value='EMAIL']
${btn_radio_SMS}      (//button[@value='PHONE_NUMBER'])
${btn_Confirm_Retrive}   //button[normalize-space()='Confirm']
${btn_Verify_Retrive}   //button[normalize-space()='Verify']
${elm_input_OTP}        //input[@class='disabled:cursor-not-allowed']
${input_NewPassword}   //input[@placeholder='New Password']
${input_ConfirmPassword}   //input[@placeholder='Confirm New Password']

## Elements
${elm_message}      //div[@class='text-sm opacity-90']
${error_empty_OTP}          //p[contains(@class, 'text-sm') and contains(text(), 'OTP code is required')]
${EXPECTED_OTP code is required}       OTP code is required
### Get success, Get failed, Get Retrieve Password success
${EXPECTED_CheckToken_Success}    OTP verified successfully. Redirecting to reset password...
${EXPETCTED_Message_Retrieve_Success}    Your password has been reset successfully.
#Error Elements
${EXPECTED_RERROR_MESSAGE_USERINVALID}    User not found
${EXPECTED_• The OTP you entered is incorrect. Please try again}       • The OTP you entered is incorrect. Please try again
${EXPECTED_• New password cannot be the same as current password}       • New password cannot be the same as current password
#Error Elements validation text
${elm_error_validationtext}   //p[contains(@id, ':r8:-form-item-message')]
${EXPECTED_ERROR_EmptyUserID}   User ID is required
${EXPECTED_ERROR_InvalidUserID}    User ID must contain only alphanumeric characters
${EXPECTED_ERROR_MinUserID}    User ID must be between 5 and 20 characters
${EXPECTED_ERROR_MaxUserID}    User ID must be between 5 and 20 characters

#Error Elements validation text Password
${error_empty_New_Password}     //p[contains(@class, 'text-sm') and contains(text(), 'The Password cannot be empty')]
${error_Min_New_Password}     //p[contains(@class, 'text-sm') and contains(text(), 'Password must be at least 8 characters.')]
${error_Missing_Uppercase}     //p[contains(@class, 'text-sm') and contains(text(), 'Password must contain at least one uppercase letter.')]
${error_Missing_Lowercase}     //p[contains(@class, 'text-sm') and contains(text(), 'Password must contain at least one lowercase letter.')]
${error_Missing_OneNumber}     //p[contains(@class, 'text-sm') and contains(text(), 'Password must contain at least one number.')]
${error_Missing_OneSpecialCharacter}     //p[contains(@class, 'text-sm') and contains(text(), 'Password must contain at least one special character.')]

${error_empty_Confirm_New_Password}     //p[contains(@class, 'text-sm') and contains(text(), 'Required')]
${error_Min_Confirm_New_Password}     //p[contains(@class, 'text-sm') and contains(text(), 'Password must be at least 8 characters')]
${error_Confirm_New_Password_NotMatch}     //p[contains(@class, 'text-sm') and contains(text(), 'Passwords do not match')]

${EXPECTED_ERROR_EmptyPassword}    The Password cannot be empty
${EXPECTED_ERROR_MinPassword}    Password must be at least 8 characters.
${EXPECTED_Missing_Uppercase}    Password must contain at least one uppercase letter.
${EXPECTED_Missing_Lowercase}    Password must contain at least one lowercase letter.
${EXPECTED_Missing_OneNumber}    Password must contain at least one number.
${EXPECTED_Missing_OneSpecialCharacter}    Password must contain at least one special character.
${EXPTECTED_empty_ConfirmPassword}      Required
${EXPECTED_ERROR_MinConfirmPassword}    Password must be at least 8 characters
${EXPECTED_ConfirmPassword_NotMatch}    Passwords do not match
#Error Payload
${EXPECTED_MESSAGE_Retrieve_Payload}    GET_DATA_SUCCEEDED
${EXPECTED_INVALID_INPUT}       INVALID_INPUT

#Error API
${EXPECTED_ERROR_MESSAGE_Usernotexist}   VAL233
${EXPECTED_ERROR_MESSAGE_Tokeninvalid}  VAL643
${EXPECTED_ERROR_MESSAGE_NotPhoneNumber}  VAL636
#Success API
${EXPECTED_SUCCESS_MESSAGE_Retrieve}    Retrive your password successfully
${EXPECTED_TOKEN_API_Success}           Your token is correct
# Varibale Endpoint API
${CheckUserID_API}     api/v2/retrive/user-info/?user_id=
${SENDOTP_API}     api/v2/retrive/send-otp/
${CheckToken_API}     api/v2/retrive/check-token/
${RetrivePassword_API}     api/v2/retrive/password/


#Element IOS#
${elm_RetrivePassword_IOS}     //XCUIElementTypeLink[@name="Retrieve password"]
${input_UserID_RetrievePassword_IOS}    //XCUIElementTypeTextField[@name="Enter your User ID"]
${elm_minUserID_IOS}    //XCUIElementTypeStaticText[@name="User ID must be 5 characters or longer!"]
${Expected_minUserID_IOS}    User ID must be 5 characters or longer!
${elm_maxUserID_IOS}    //XCUIElementTypeStaticText[@name="User ID must be 20 characters or fewer!"]
${Expected_maxUserID_IOS}    User ID must be 20 characters or fewer!
${elm_specialcharacters_IOS}    //XCUIElementTypeStaticText[@name="Special characters are not allowed"]
${Expected_specialcharacters_IOS}    Special characters are not allowed
${elm_Continue_IOS}    //XCUIElementTypeStaticText[@name="Continue"]
${elm_UserID_notfound_IOS}    //XCUIElementTypeOther[@name="User ID not found"]
${Expected_UserID_notfound_IOS}    User ID not found
${elm_Signout_IOS}    //XCUIElementTypeStaticText[@name="Your password has been update successfully\nDone"]
${Expected_Signout_IOS}    Your password has been update successfully\nDone
${elm_Confirm_IOS}      //XCUIElementTypeStaticText[@name="Confirm"]
${elm_Submit_IOS}      //XCUIElementTypeStaticText[@name="Submit"]
${elm_newPassword_IOS}    //XCUIElementTypeTextField[@name="Enter your new password"]
${elm_confirmPassword_IOS}    //XCUIElementTypeTextField[@name="Repeat your new password"]
${elm_title_NewPassword_IOS}    //XCUIElementTypeStaticText[@name="New Password"]
${elm_showNewPassword}      //XCUIElementTypeApplication[@name="Panda App Prod"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[3]/XCUIElementTypeOther[1]/XCUIElementTypeOther
${elm_showConfirmPassword}      //XCUIElementTypeApplication[@name="Panda App Prod"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[3]/XCUIElementTypeOther[2]/XCUIElementTypeOther
${elm_empty_New_Password_IOS}     xpath=(//XCUIElementTypeStaticText[@name="This field is required"])[1]
${Expected_empty_Password_IOS}    This field is required

${elm_empty_ConfirmPassword_IOS}      //XCUIElementTypeStaticText[@name="This field is required"]

${elm_MinPassword}      //XCUIElementTypeStaticText[@name="Password must be 8 characters or longer!"]
${Expected_MinPassword}        Password must be 8 characters or longer!

${elm_validationtext_password}      //XCUIElementTypeStaticText[@name="Password should contain at least one upper case, lower case, digit and special character"]
${EXPECTED_validationtext_password}        Password should contain at least one upper case, lower case, digit and special character

${elm_validationtext_confirm_password}      //XCUIElementTypeStaticText[@name="Confirm password and password must be match"]
${EXPECTED_validationtext_confirmpassword}      Confirm password and password must be match

${elm_Newpassword_samecurrent}      //XCUIElementTypeStaticText[@name="New password cannot be the same as current password"]
${EXPECTED_NewPassword_SameCurrent}     New password cannot be the same as current password

${elm_popup_Newpassword_samecurrent}    //XCUIElementTypeOther[@name="Password reset failed"]
${Expected_popup_NewPassword_SameCurrent}    Password reset failed
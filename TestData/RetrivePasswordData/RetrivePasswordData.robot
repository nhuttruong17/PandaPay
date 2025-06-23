*** Settings ***
Resource    ../../TestKeyWords/Common.robot
*** Variables ***
${Valid_userID}    abc1111456
${Email_UserID_Valid}   abcd@yopmail.com
${userID_Invalid}    abc1111457
${userID_Johny}    HUYHOANGHUYNH123
${Email_Johny}   johnny@bizbookly.com
${PhoneNumber_Johny}   9722659011
${Type_Email}     EMAIL
${Type_PhoneNumber}    PHONE_NUMBER
${EXPECTED_SUCCESS_MESSAGE_API}    Send OTP successfully
${userID_Schoolinactive}    Schoolinactive
${userID_SchoolLe}    SchoolLe
${Old_password}    School123@
${token_Invalid}    100000
${token_empty}
## Data validation text Password
${Empty_textPassword}
${Min_textPassword}    ab
${Missing_Uppercase}    abcdefghijklmnop
${Missing_Lowercase}    ABCDEFGHIJKLMNOP
${Missing_OneNumber}    abcdefghijAA
${Missing_OneSpecialCharacter}    abcdefghij1A

### URL API ###
${SendOTP_URL}    https://api.panda.ennam.vn/api/v2/retrive/send-otp/
${URL_Retrive}    https://api.panda.ennam.vn/api/v2/retrive/password/
${URL_Checktoken}    https://api.panda.ennam.vn/api/v2/retrive/check-token/
${URL_CheckUserID}    https://api.panda.ennam.vn/api/v2/retrive/user-info/

### Payload API ###
&{PAYLOAD_SUCCESS_UserId}         user_id=${Valid_userID}    notify_type=${Type_Email}
&{PAYLOAD_Faild_UserIdinactive}         user_id=${userID_Schoolinactive}    notify_type=${Type_Email}
&{PAYLOAD_SUCCESS_Phonenumber}         user_id=${userID_Johny}    notify_type=${Type_PhoneNumber}
&{PAYLOAD_NotPhoneNumber}         user_id=${Valid_userID}    notify_type=${Type_PhoneNumber}
&{PAYLOAD_UserInvalid}         user_id=${userID_Invalid}    notify_type=${Type_PhoneNumber}
&{PAYLOAD_TokenInvalid}         user_id=${Valid_userID}    token=${token_Invalid}
### Validation text UserID ###
${Empty_textUserID}
${Specialcharacters_textUserID}    @#$%^&*
${Min_textUserID}    ab
${Max_textUserID}    abcd12345678901234567890


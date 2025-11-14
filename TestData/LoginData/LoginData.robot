*** Variables ***
#Data valid authentication
${Valid_UserID}   SchoolLe
${Valid_Password}   School123@
${Invalid_Password}   Schools123@@@
${Valid_UserID_inactive}   Schoolinactive
${Valid_Password_inactive}   School123@
#Data valid authentication

#Data validation text UserID
${Empty_textUserID}
${Specialcharacters_textUserID}    @#$%^&*
${Min_textUserID}    ab
${Max_textUserID}    abcd12345678901234567890
#Data validation text UserID

#Data validation text Password
${Empty_textPassword}
${Min_textPassword}     ab
${Missing_Uppercase}    abcdefghijklmnop
${Missing_Lowercase}    ABCDEFGHIJKLMNTT
${Missing_Number}       abcdefghijAA@
${Missing_Special}      abcdefghij1A
#Data validation text Password

#URL API#
${API_URL_SignIn}       https://api.panda.ennam.vn/api/user/sign-in/
#URL API#

## Payload API ##
${Type}     ORG_ADMIN
&{PAYLOAD_SUCCESS}              user_code=${Valid_UserID}    password=${Valid_Password}    type=${TYPE}
&{PAYLOAD}                      user_code=${Valid_UserID}    password=${Invalid_Password}    type=${TYPE}
&{PAYLOAD_UserInactive}         user_code=${Valid_UserID_inactive}    password=${Valid_Password_inactive}    type=${TYPE}
## Payload API ##

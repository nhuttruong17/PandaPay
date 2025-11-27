*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    Collections
Resource        ../../Resources/PageObject/LoginPage/LoginPage.robot
Resource        ../../TestData/LoginData/LoginData.robot
# Suite Setup     Basic Setup
# Suite Teardown  Basic TearDowns

Suite Teardown    Upload Results To AIO

*** Variables ***
${AIO_IMPORT_URL_BASE}    https://tcms.aiojiraapps.com/aio-tcms/api/v1
${AIO_AUTH_TOKEN}         YWVkNmMxMTEtYjBmNC0zMmIxLWEzMGEtOTMyZTM2ZjUyM2M1LjcyODZmMzM2LTAwNTUtNGJhNC1iZjQ3LTg1ODBmOTk2ZDgyMQ==
${PROJECT_KEY}            PPPA
${CYCLE_KEY}              PPPA-CY-6

*** Test Cases ***
# Check validation empty UserID error
#     [Documentation]    Verify that the system shows validation error when UserID input is empty
#     [Tags]    UserID    Validation    Empty
#     Given Fill Text Input  ${input_UserID}  ${Empty_textUserID}
#     When Click on Element  ${btn_SignIn}
#     Then Check validation error message    ${error_empty_UserID}    ${EXPECTED_ERROR_EmptyUserID}
Test case one to one Pass
    [Documentation]    1 pass
    Should Be Equal As Integers    1    1

Test case two to two Fail
    [Documentation]    2 fail
    Should Be Equal As Integers    1    2

*** Keywords ***
Upload Results To AIO
    [Documentation]    Upload Robot test results to AIO after suite execution.

    # 1. Use built-in variable for the output file to make it portable.
    ${output_xml}=    Normalize Path    ${OUTPUT_DIR}/output.xml
    File Should Exist    ${output_xml}

    ${filename}=    Get File    ${output_xml}
    &{files}=    Create Dictionary    file=(${output_xml}, ${filename}, application/xml)

    # Prepare URL and headers
    ${url}=    Set Variable    ${AIO_IMPORT_URL_BASE}/project/${PROJECT_KEY}/testcycle/${CYCLE_KEY}/import/results
    ${headers}=    Create Dictionary    Authorization=AioAuth ${AIO_AUTH_TOKEN}    Accept=application/json

    # Prepare params and data
    ${params}=    Create Dictionary    type=Robot
    ${data}=    Create Dictionary
    ...    createNewRun=true
    ...    addCaseToCycle=true
    ...    createCase=true
    # Consider enabling these options if your AIO project requires them
    # ...    mapAutomationKey=true
    # ...    forceUpdateCase=true

    # Upload file
    Log To Console   Uploading ${filename} to AIO for cycle ${CYCLE_KEY}...
    ${response}=    POST    ${url}    params=${params}    headers=${headers}    files=${files}     data=${data}


# Upload Results To AIO
#     [Documentation]    Upload Robot test results to AIO after suite execution
#     # ${output_xml}=    Set Variable    ${OUTPUT_DIR}${/}output.xml  # Thay bằng ${OUTPUT_DIR}${/}output.xml nếu có thể
#     ${output_xml}=    Set Variable    /Users/apple/Downloads/School/PycharmProjects/PandaPay/Result_Demo/output.xml
#     File Should Exist    ${output_xml}
#     &{files}=    Create Dictionary    file=(${output_xml}, ${output_xml} , application/xml)
#     # Prepare URL and headers
#     ${url}=    Set Variable    ${AIO_IMPORT_URL_BASE}/project/${PROJECT_KEY}/testcycle/${CYCLE_KEY}/import/results
#     ${headers}=    Create Dictionary    Authorization=AioAuth ${AIO_AUTH_TOKEN}    Accept=application/json;charset=utf-8
#     # Prepare params - with forceUpdateCase to handle mismatches
#     ${params}=    Create Dictionary
#     ...    type=Robot
#     ${data}=    Create Dictionary
#     ...    createNewRun=true
#     ...    addCaseToCycle=true
#     ...    createCase=true
#     # ...    mapAutomationKey=true
#     # ...    forceUpdateCase=true
#     # Upload file
#     Log To Console   Uploading ${output_xml} to AIO...
#     ${response}=    POST    ${url}    params=${params}    headers=${headers}    files=${files}     data=${data}
#     Log    Response: ${response}
    
#     # Check result
#     ${resp_json}=    Evaluate    json.loads('''${response.text}''')    json
#     ${status}=    Get From Dictionary    ${resp_json}    status
    
#     Run Keyword If    '${status}' == 'SUCCESS'    Log    ✅ Upload SUCCESS!    console=True
#     ...    ELSE    Log    ⚠️  Upload Status: ${status}    console=True

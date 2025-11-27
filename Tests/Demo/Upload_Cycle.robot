***Settings***
Library         RequestsLibrary        # Thư viện dùng để thực hiện các yêu cầu HTTP (POST, GET,...) đến API của AIO.
Library         OperatingSystem        # Thư viện dùng để kiểm tra sự tồn tại của file output.xml.
Library         Collections            # Thư viện dùng để thao tác với dictionary và list.

***Variables***    # Cấu hình biến cho việc upload lên AIO
# ${AIO_IMPORT_URL_BASE}: URL cơ sở của API AIO TCMS.
${AIO_IMPORT_URL_BASE}    https://tcms.aiojiraapps.com/aio-tcms/api/v1
# ${AIO_AUTH_TOKEN}: Token xác thực để truy cập API AIO TCMS.
# Access AIO Test -> Icon Setting > My Settings > API Token > Manage API token > Create API Token
${AIO_AUTH_TOKEN}         YWVkNmMxMTEtYjBmNC0zMmIxLWEzMGEtOTMyZTM2ZjUyM2M1LjcyODZmMzM2LTAwNTUtNGJhNC1iZjQ3LTg1ODBmOTk2ZDgyMQ==
# ${PROJECT_KEY}: Mã dự án trong AIO TCMS.
${PROJECT_KEY}            PPPA
# ${CYCLE_KEY}: Mã chu kỳ thử nghiệm trong AIO TCMS.
${CYCLE_KEY}              PPPA-CY-6
*** Test Cases ***
Upload Test Results To AIO
    [Documentation]    Uploads the test results from ${OUTPUT_FILE_PATH}.
    # Bước 1: Kiểm tra sự tồn tại của file output.xml
    Log To Console    Starting upload task...
    ${output_xml}=    Set Variable    Result_Demo/output.xml
    File Should Exist    ${output_xml}    msg=output.xml not found at ${output_xml}
    
    # Chuẩn bị dữ liệu để upload lên AIO
    # Đọc nội dung file output.xml
    ${file_content}=    Get Binary File    ${output_xml}
    # Tạo dictionary files để gửi file trong yêu cầu POST
    @{file_list}=       Create List    output.xml    ${file_content}    application/xml
    # Tạo dictionary files để gửi file trong yêu cầu POST
    &{files}=           Create Dictionary    file=${file_list}
    # Tạo URL, headers, params và data cho yêu cầu POST
    ${url}=    Set Variable    ${AIO_IMPORT_URL_BASE}/project/${PROJECT_KEY}/testcycle/${CYCLE_KEY}/import/results
    # Tạo headers với Authorization và Accept
    ${headers}=    Create Dictionary    Authorization=AioAuth ${AIO_AUTH_TOKEN}    Accept=application/json;charset=utf-8
    # Tạo params và data cho yêu cầu POST
    ${params}=    Create Dictionary    type=Robot
    ${data}=    Create Dictionary
    ...    createNewRun=true
    ...    addCaseToCycle=true
    ...    createCase=true
    # Gửi yêu cầu POST để upload file lên AIO
    Log To Console   Uploading ${output_xml} to AIO for cycle ${CYCLE_KEY}...
    ${response}=    POST    ${url}    params=${params}    headers=${headers}    files=${files}     data=${data}
    
    # Kiểm tra kết quả
    Log    Response: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    200
    ${resp_json}=    Set Variable    ${response.json()}
    ${status}=    Get From Dictionary    ${resp_json}    status
    Run Keyword If    '${status}' == 'SUCCESS'
    ...    Log    ✅ AIO Upload SUCCESS!    console=True
    ...    ELSE
    ...    FAIL    AIO upload failed with status: ${status}
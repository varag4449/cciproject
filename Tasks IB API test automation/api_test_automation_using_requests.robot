*** Settings ***
Documentation    This suite automates endpoint http://api.shoutcloud.io/ using Process library
Library    RequestsLibrary

*** Variables ***
${url}    HTTP://API.SHOUTCLOUD.IO
${api}    /V1/SHOUT
&{data}    INPUT=hello world
*** Test Cases ***
Test End Point API Shout Cloud
    Test API Shout Cloud    ${url}    ${api}    ${data}

*** Keywords ***
Test API Shout Cloud
    [Arguments]    ${url}    ${api}    ${data}
    [Documentation]    This keyword tests API Shout cloud using process library
    ...    Arguments:
    ...    data- Data content to be passed with the post command
    ...    url - url of the API
    Create Session    test    ${url}
    ${headers}=    BuiltIn.Create Dictionary    Content-Type    application/json
    ${response}=  Post Request    uri=${api}    headers=${headers}    data=${data}    alias=test
    ${json_response}=  Convert To String    ${response.status_code}
    Should Be Equal    ${json_response}    200
    BuiltIn.Should Be Equal As Strings   ${response.json()}    {'INPUT': 'hello world', 'OUTPUT': 'HELLO WORLD'}

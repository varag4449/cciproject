*** Settings ***
Documentation    This suite automates endpoint http://api.shoutcloud.io/ using Process library
Library    Process

*** Variables ***
${url}    HTTP://API.SHOUTCLOUD.IO/V1/SHOUT
${data}    "{\\"INPUT\\": \\"hello world\\"}"
*** Test Cases ***
Test End Point API Shout Cloud
    Test API Shout Cloud    ${data}    ${url}

*** Keywords ***
Test API Shout Cloud
    [Arguments]    ${data}    ${url}
    [Documentation]    This keyword tests API Shout cloud using process library
    ...    Arguments:
    ...    data- Data content to be passed with the post command
    ...    url - url of the API
    Run Process    curl -i -c cookie.txt -X POST -d ${data} -H "Content-Type: application/json" ${url}    shell=True    alias=test
    ${stdout}    ${stderr}=    Get Process Result    test    stdout=yes    stderr=yes
    Should Contain    ${stdout}    {"INPUT":"hello world","OUTPUT":"HELLO WORLD"}

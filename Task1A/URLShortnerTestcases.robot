*** Settings ***
Documentation    This suite automates different testcases for URL shortner that is running on http://127.0.0.1:5000/
Library    SeleniumLibrary
Test Setup    Open Browser   http://127.0.0.1:5000/    chrome
Test Teardown    Close All Browsers

*** Variables ***
${page_heading}    //h1[contains(text(),'Welcome to FlaskShortener')]
${submit_button}    //button[contains(text(),'Submit')]
${required_element}    //div[contains(text(),'The URL is required!')]
${url_textbox}    //input[@placeholder="URL to shorten"]
${shortened_url_element}    //input[@placeholder="URL to shorten"]//following::span
${cci_long_link}    https://www.google.com/search?q=cci+global+technologies&sxsrf=ALiCzsb1hCafUQ7iTQwhalDCgL1DAG0igg%3A1651902212579&ei=BAd2Yo6AI7ygseMP0by-6A4&oq=cci+global&gs_lcp=Cgdnd3Mtd2l6EAMYATIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyCAgAEIAEEMkDMgsILhCABBDHARCvATIFCAAQgAQyBQgAEIAEMgUIABCABDoECCMQJzoECAAQQzoQCC4QsQMQgwEQxwEQ0QMQQzoKCAAQsQMQgwEQQzoLCAAQgAQQsQMQgwE6CAgAEIAEELEDOg0ILhCxAxDHARDRAxBDOgsILhCABBDHARDRAzoRCC4QgAQQsQMQgwEQxwEQ0QM6CAgAELEDEIMBOgoIABCABBCHAhAUSgQIQRgASgQIRhgAUABY8TNg20BoAnAAeACAAdwKiAH1UpIBCTQtMS4wLjYuNJgBAKABAcABAQ&sclient=gws-wiz
${cci_company_text}    //span[contains(text(),'CCi Global Technologies')]//following::span[contains(text(),'Automation company in Hamilton, Canada')]
${invalid_url_element}    //div[contains(text(),'Invalid URL')]
${google_ip_url}    http://142.250.195.78
# Note this IP might change. Pls check it and update before running the test
${google_search_element}    //input[@value="Google Search"]

*** Test Cases ***
Testcase01: Verify URL Shortner Service Is Running
    [Documentation]
    ...    [Pre-Requisite]: Make sure URL shortner service http://127.0.0.1:5000/ is up and running
    ...    [Steps]:
    ...    1. Open http://127.0.0.1:5000/
    ...    2. Verify the if page heading "Welcome to FlaskShortener", URL textbox and submit button exists.
    [Tags]    T01
    Page Should Contain Element    ${page_heading}
    Page Should Contain Element    ${url_textbox}
    Page Should Contain Element    ${submit_button}

Testcase02: Verify Required field for URL
    [Documentation]
    ...    [Pre-Requisite]: Make sure URL shortner service http://127.0.0.1:5000/ is up and running
    ...    [Steps]:
    ...    1. Open http://127.0.0.1:5000/
    ...    2. Provide empty/no URL
    ...    3. Click on submit button
    ...    4. Verify mandatory field text "The URL is required!"
    [Tags]    T02
    Click Button    ${submit_button}
    Page Should Contain Element    ${required_element}

Testcase03: Verify CCI website URL Is Shortnened
    [Documentation]
    ...    [Pre-Requisite]: Make sure URL shortner service http://127.0.0.1:5000/ is up and running
    ...    [Steps]:
    ...    1. Opens http://127.0.0.1:5000/
    ...    2. Provide CCI website Long URL
    ...    3. Click on submit button
    ...    4. Verifiy that URL is shortened
    ...    5. Open the shorted URL and verify that CCI website is opened
    [Tags]    T03
    Provide URL To Be Shorted And Click On Submit Button    ${cci_long_link}
    ${shortened_url}    Get Text    ${shortened_url_element}
    Log   ${shortened_url}
    Go To    ${shortened_url}
    Page Should Contain Element    ${cci_company_text}

Testcase04: Test Invalid URL
    [Documentation]
    ...    [Pre-Requisite]: Make sure URL shortner service http://127.0.0.1:5000/ is up and running
    ...    [Steps]:
    ...    1. Opens http://127.0.0.1:5000/
    ...    2. Provide invalid URL eg: test
    ...    3. Click on submit button
    ...    4. Verifiy that URL is shortened URL
    ...    5. Open the shorted URL and verify that url is invalid. Verify invalid url error message
    ...    [Note] This can be a bug 1. When a invalid URL is provided(eg: test), it doesnt throw any error and gives us the shortened URL. When we access the shortened URL,
    ...    then it gives "Invalid URL". Instead of this behaviour , the error should be thrown immediately when we provide invalid url and click on submit button
    [Tags]    T04
    Provide URL To Be Shorted And Click On Submit Button    test
    ${shortened_url}    Get Text    ${shortened_url_element}
    Log   ${shortened_url}
    Go To    ${shortened_url}
    Page Should Contain Element    ${invalid_url_element}

Testcase05: Verify CCI website URL With Extra Spaces At The End Is Shortnened Successfully
    [Documentation]
    ...    [Pre-Requisite]: Make sure URL shortner service http://127.0.0.1:5000/ is up and running
    ...    [Steps]:
    ...    1. Opens http://127.0.0.1:5000/
    ...    2. Provide CCL long URL with extra spaces at the end
    ...    3. Click on submit button
    ...    4. Verifiy that URL is shortened
    ...    5. Open the shorted URL and verify that CCI website is opened
    [Tags]    T05
    Provide URL To Be Shorted And Click On Submit Button    ${cci_long_link}${SPACE}${SPACE}${SPACE}
    ${shortened_url}    Get Text    ${shortened_url_element}
    Log   ${shortened_url}
    Go To    ${shortened_url}
    Page Should Contain Element    ${cci_company_text}

Testcase06: Verify Google URL With IP Address Is Shortnened Successfully
    [Documentation]
    ...    [Pre-Requisite]: Make sure URL shortner service http://127.0.0.1:5000/ is up and running
    ...    [Steps]:
    ...    1. Opens http://127.0.0.1:5000/
    ...    2. Provide Google URL with IP Address eg: http://142.250.195.78
    ...    3. Click on submit button
    ...    4. Verifiy that URL is shortened
    ...    5. Open the shorted URL and verify that Google is opened
    ...    # Note the Google IP might change. Pls check it and update before running the test
    [Tags]    T06
    Provide URL To Be Shorted And Click On Submit Button    ${google_ip_url}
    ${shortened_url}    Get Text    ${shortened_url_element}
    Log   ${shortened_url}
    Go To    ${shortened_url}
    Page Should Contain Element    ${google_search_element}

*** Keywords ***
Provide URL To Be Shorted And Click On Submit Button
    [Arguments]    ${url}
    Input Text    ${url_textbox}    ${url}
    Click Button    ${submit_button}
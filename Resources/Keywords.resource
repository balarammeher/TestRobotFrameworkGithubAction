*** Settings ***
Library           SeleniumLibrary
Variables    Credential.yml
*** Variables ***


${username}    //input[@id="user-name"]    
${password}    //input[@id="password"]
${loginButton}    //input[@id="login-button"]

${cartIcon}    //*[@id="shopping_cart_container"]
${errorMessage}    //*[@class="error-message-container error"]
*** Keywords ***
Open browser with url
    [Arguments]    ${url}
    ${Chrome_options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method  ${Chrome_options}  add_argument  --disable-notifications
    Call Method  ${Chrome_options}  add_argument  --disable-gpu
    Call Method  ${Chrome_options}  add_argument  --disable-extensions
    Call Method  ${Chrome_options}  add_argument  --no-sandbox
    Call Method  ${Chrome_options}  add_argument  --enable-unsafe-swiftshader
    Call Method  ${Chrome_options}  add_argument  --disable-dev-shm-usage
    ${prefs}=      Create Dictionary    credentials_enable_service=${False}   profile.password_manager_leak_detection=${False}    password_manager_enabled=${False}    # Disable password manager
    Call Method    ${Chrome_options}    add_experimental_option    prefs    ${prefs}

    
    Open Browser    ${url}   chrome    options=${Chrome_options}

    Maximize Browser Window
Login to the application
    [Arguments]    ${usernameValue}    ${passwordValue}
    Wait Until Keyword Succeeds    60s    2s    Element Should Be Visible    ${username}
    Input Text    ${username}    ${usernameValue}
    Wait Until Keyword Succeeds    60s    2s    Element Should Be Visible    ${password}
    Input Password    ${password}    ${passwordValue}
    Click Element    ${loginButton}

verify login successful
    Wait Until Keyword Succeeds    60s    2s    Element Should Be Visible    ${cartIcon}
    Sleep    2s

verify login unsuccessful
    Wait Until Keyword Succeeds    60s    2s    Element Should Be Visible    ${errorMessage}
        
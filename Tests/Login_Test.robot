*** Settings ***

Library    SeleniumLibrary
Library    BuiltIn
Library    OperatingSystem
Resource    ../Resources/Keywords.resource
Test Setup    Setup
Test Teardown    Close All Browsers

*** Variables ***
${url}    https://www.saucedemo.com/

*** Keywords ***
Setup
    Open browser with url   ${url}

*** Test Cases ***
Login test successful login
    Login to the application    standard_user    secret_sauce
    verify login successful
 Login test unsuccessful login
    Login to the application    standard_user    secret_sauce1
    verify login unsuccessful
Login test to with visual user
    Login to the application    visual_user    secret_sauce
    verify login successful    
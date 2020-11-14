*** Settings ***
Library  OperatingSystem
Library  SeleniumLibrary

*** Test Cases ***
Check invoice manager page
    Comment    We're learning how to create a custom keyword.
    Navigate to the home page
    Page Should Contain     Invoice Manager

*** Keywords ***
Navigate to the home page
    comment    navigating to the home page
    Open Browser  http://34.225.240.91/   chrome



*** Settings ***
Resource    ../Resources/PageObject/InvoiceManagerPage.robot
Resource    ../Resources/CommonWeb.robot
Library    DataDriver   ../TestDriven.xlsx     sheet_name=Sheet1


Suite Setup  run keyword    Navigate To Home Page
Suite Teardown   run keyword     End of the TestCase
Test Template   Add Some Invoices

*** Variables ***


*** Test Cases ***
Invoice Test with Excel    ${Name}    ${Company}      ${Type}     ${Cost}     ${Date}     ${Comments}     ${Status}


*** Keywords ***
Add Some Invoices
    [Arguments]     ${Name}    ${Company}  ${Type}     ${Cost}     ${Date}     ${Comments}     ${Status}
    Click Add Invoice
    Add Invoice     ${Name}    ${Company}  ${Type}     ${Cost}     ${Date}     ${Comments}     ${Status}




   # sleep   ${Delay}
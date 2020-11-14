*** Settings ***
Resource    ../Resources/CommonWeb.robot
Resource    ../Resources/PageObject/InvoiceManagerPage.robot
Test Setup     Navigate To The HomePage
Test Teardown    End of the TestCase

*** Variables ***


*** Test Cases ***
Add New Invoice
    InvoiceManagerPage.Invoice Creation Page Is Open
    ${InvoiceNumber}=   InvoiceManagerPage.Generate Random Number
    Input Invoice Number    ${InvoiceNumber}
    ${CompanyName}=     InvoiceManagerPage.Generate Random String With Defaults
    Input Company Name   ${CompanyName}
    InvoiceManagerPage.String Lenght Should Be And It Should Consist Of     ${CompanyName}  8   ${LETTERS}${NUMBERS}



    sleep    ${Delay}
    click element    xpath://button[normalize-space()='Cancel']


*** Keywords ***
Input Invoice Number
    [Arguments]    ${randomNumber}
    input text    ${invoiceNumberInput}   ${randomNumber}
   # sleep    ${Delay}

Input Company Name
    [Arguments]    ${randomName}
    input text   ${companyNameInput}     ${randomName}
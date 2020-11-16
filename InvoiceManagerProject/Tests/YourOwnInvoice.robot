*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library  String
Library  Screenshot
Resource    ../Resources/PageObject/InvoiceManagerPage.robot



Suite Setup  Run Keywords   Navigate To Home Page  Delete Invoice If Exists
Suite Teardown  Run Keywords    Close Browser


*** Variables ***
${SiteUrl}    http://34.225.240.91
${Browser}     Chrome
${CompanyName}  ACME, Inc
${TypeOfWork}   Roadrunner Extermination
${Amount}   1.00
${DueDate}  11/7/2019
${Description}  Warning: Roadrunners can be tricky.
${Status}   Paid

*** Test Cases ***
Create an Invoice
    Click Add Invoice
    ${invoiceNumber}=    Create Invoice Number
    Set Suite Variable   ${invoiceNumber}
    Add Invoice  ${invoiceNumber}    ${CompanyName}  ${TypeOfWork}   ${Amount}     ${DueDate}    ${Description}    ${Status}
    Page Should Contain     ${invoiceNumber}
    Delete Invoice  ${invoiceNumber}
    Take Screenshot


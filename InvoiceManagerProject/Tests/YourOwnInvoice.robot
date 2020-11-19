*** Settings ***
Library  OperatingSystem
Library  String
Library  Screenshot
Library     AWSLibrary
Resource    ../Resources/PageObject/InvoiceManagerPage.robot
Resource    ../Resources/CommonWeb.robot



Test Setup      Navigate To The HomePage
Test Teardown     End of the TestCase


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


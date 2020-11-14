*** Settings ***
Resource    ../Resources/CommonWeb.robot
Resource    ../Resources/PageObject/InvoiceManagerPage.robot
Test Setup     Navigate To The HomePage
Test Teardown    End of the TestCase


*** Variables ***
${InvoiceName}=     Ahmet


*** Test Cases ***
Get Invoices
    ${Invoices}=    InvoiceManagerPage.Get All Invoices
    log to console    ${Invoices}

Go To The Spesific Invoice
    InvoiceManagerPage.Get Details Of Invoice    ${InvoiceName}



*** Keywords ***




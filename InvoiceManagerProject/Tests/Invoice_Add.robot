*** Settings ***
Resource    ../Resources/CommonWeb.robot
Resource    ../Resources/PageObject/InvoiceManagerPage.robot
Test Setup      Navigate To The HomePage
Test Teardown    End of the TestCase

*** Variables ***
${Date}=    2020-11-25


*** Test Cases ***
Add New Invoice
    InvoiceManagerPage.Fill The Invoice Necessary Part
    InvoiceManagerPage.Create Invoice
    sleep    1
    InvoiceManagerPage.Validate Invoice Created     ${InvoiceNumber}
    InvoiceManagerPage.Delete Invoice    ${InvoiceNumber}



*** Keywords ***

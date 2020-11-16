*** Settings ***
Resource    ../Resources/CommonWeb.robot
Resource    ../Resources/PageObject/InvoiceManagerPage.robot
Test Setup     Navigate To The HomePage
Test Teardown    End of the TestCase

*** Variables ***
${Date}=    2020-11-25


*** Test Cases ***
Add New Invoice
    Fill The Invoice Necessary Part
    Create Invoice
    sleep    1
    Validate Invoice Created    ${InvoiceNumber}
    Delete Invoice    ${InvoiceNumber}


*** Keywords ***

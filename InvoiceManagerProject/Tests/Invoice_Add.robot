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
    Validate Invoice Created     ${InvoiceNumber}
    Delete Invoice    ${InvoiceNumber}


*** Keywords ***
Input Invoice Number
    [Arguments]    ${randomNumber}
    input text    ${invoiceNumberInput}   ${randomNumber}
   # sleep    ${Delay}

Input Company Name
    [Arguments]    ${randomName}
    input text   ${companyNameInput}     ${randomName}

Input Type Of Work
    [Arguments]    ${randomName}
    input text    ${typeOfNameInput}   ${randomName}

Input Amount
    [Arguments]    ${randomAmount}
    input text    ${amountInput}     ${randomAmount}

Input Due Date
    [Arguments]    ${randomDate}
    input text    ${dueDate}    ${randomDate}

Select Status
    InvoiceManagerPage.Select Random Status

Input Description
    [Arguments]    ${randomComment}
    input text    ${descriptionInput}   ${randomComment}

Save Invoice
    click element    ${saveButton}

Create Invoice
    click element    ${createButton}

Validate Invoice Created
    [Arguments]    ${InvoiceNumber}
    ${listOfInvoices}=  InvoiceManagerPage.Get All Invoices
    ${strInvoiceNumber}=    convert to string    ${InvoiceNumber}
    list should contain value   ${listOfInvoices}   ${strInvoiceNumber}

Delete Invoice If Exists
    [Arguments]    ${invoiceNumber}
    ${invoice_count}=   Get Element Count    xpath://a[normalize-space()='${invoiceNumber}']
    log to console      ${invoice_count}
    Run Keyword If      ${invoice_count} > 0    Delete Invoice  ${invoiceNumber}

Delete Invoice
    [Arguments]  ${invoiceNumber}
    Click Link      xpath://a[normalize-space()='${invoiceNumber}']
    Click Button    deleteButton

Fill The Invoice Necessary Part
    InvoiceManagerPage.Invoice Creation Page Is Open
    ${InvoiceNumber}=   InvoiceManagerPage.Generate Random Number
    set suite variable     ${InvoiceNumber}
    Input Invoice Number    ${InvoiceNumber}
    ${CompanyName}=     InvoiceManagerPage.Generate Random String With Defaults
    Input Company Name   ${CompanyName}
    ${TypeOfWork}=      InvoiceManagerPage.Generate Random String With Defaults
    Input Type Of Work   ${TypeOfWork}
    ${RandomAmount}=    InvoiceManagerPage.Generate Random Price
    Input Amount    ${RandomAmount}
    Input Due Date  ${Date}
    Select Status
    ${RandomComment}=   InvoiceManagerPage.Generate Random String With Defaults
    Input Description   ${RandomComment}
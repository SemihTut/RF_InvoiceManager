*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library  String
Library  Screenshot


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

*** Keywords ***
Navigate To Home Page
    Open Browser    ${SiteUrl}		${Browser}
    Set Selenium Speed    .25 Seconds

Click Add Invoice
    Click Link  Add Invoice
    Page Should Contain Element     invoiceNo_add


Add Invoice
    [Documentation]     This keywords fills out the invoice details page
    [Arguments]  ${Name}    ${Company}  ${Type}     ${Cost}     ${Date}     ${Comments}     ${Status}
    Input Text  invoice   ${Name}
    Input Text  company   ${Company}
    Input Text  type   ${Type}
    Input Text  price   ${Cost}
    Input Text  dueDate   ${Date}
    Input Text  comment   ${Comments}
    Select From List By Value   selectStatus    ${Status}
    Click Button    createButton

Delete Invoice If Exists
    ${invoice_count}=   Get Element Count    css:[id^='invoiceNo_paulm'] > a
    Run Keyword If      ${invoice_count} > 0    Delete Invoice  css:[id^='invoiceNo_paulm'] > a

Create Invoice Number
    ${RANUSER}    Generate Random String    10    [LETTERS]
    [Return]    ${RANUSER}

Delete Invoice
    [Arguments]  ${invoiceNumber}
    Click Link      xpath://a[normalize-space()='${invoiceNumber}']
    Click Button    deleteButton
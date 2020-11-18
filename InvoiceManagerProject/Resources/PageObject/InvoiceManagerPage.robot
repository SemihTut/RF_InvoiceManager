*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String



*** Variables ***
${LOWER}          qwertyuiopasdfghjklzxcvbnm
${UPPER}          QWERTYUIOPASDFGHJKLZXCVBNM
${LETTERS}        ${LOWER}${UPPER}
${NUMBERS}        1234567890
${SiteUrl}    http://34.225.240.91
${Browser}     Chrome
${Date}     12-12-2020

${addInvoiceButton}=    Add Invoice
${invoiceNumberInput}=  invoice
${companyNameInput}=    company
${typeOfNameInput}=     type
${amountInput}=  price
${dueDate}=     dueDate
${selectStatus}=    selectStatus
${descriptionInput}=    comment
${saveButton}=  saveButton
${createButton}=    createButton
${allInvoicesLocator}   xpath: (//tr[@class='invoice ng-scope']//td[1]//a)


*** Keywords ***
Get All Invoices
    @{invoices}=    get webelements    ${allInvoicesLocator}
    ${count}    get element count    ${allInvoicesLocator}
    ${Invo}=    create list
    FOR     ${i}  IN RANGE  1  ${count}
        ${text}=    get text    xpath: (//tr[@class='invoice ng-scope']//td[1]//a)[${i}]
        append to list    ${Invo}   ${text}
       #LOG TO CONSOLE    ${text}
    END
    [Return]   ${Invo}

Get Details Of Invoice
    [Arguments]    ${Invoice Number}
    click element    xpath://a[normalize-space()='${Invoice Number}']
    sleep    1s
    ${companyName}=    get element attribute    xpath://input[@name='company']  value
    ${typeOfWork}=  get element attribute    xpath://input[@name='type']  value
    ${amount}=  get element attribute    xpath://input[@name='price']  value
    ${status}=  get element attribute    xpath://select[@id='selectStatus']  value
    ${dueDate}=     get element attribute    xpath://input[@name='dueDate']  value
    ${description}=    get element attribute    xpath://input[@name='comment']  value
    &{dict}     create dictionary   CompanyName=${companyName}  TypeOfWork=${typeOfWork}    Amount=${amount}    Status=${status}    DueDate=${dueDate}  Description=${description}
    [Return]    &{dict}

Generate Random Number
    ${random_number}    Evaluate    random.randint(1000000, 9999999)   random
    [Return]    ${random_number}

Generate Random Price
    ${random_number}    Evaluate    random.randint(0, 100000)   random
    [Return]    ${random_number}

Create Invoice Number
    ${RANUSER}    Generate Random String    10    [LETTERS]
    [Return]    ${RANUSER}

Invoice Creation Page Is Open
    Click Link  Add Invoice
    Page Should Contain Element     invoiceNo_add


Generate Random String With Defaults
    ${result} =    Generate Random String
    String Lenght Should Be And It Should Consist Of    ${result}    8    ${LETTERS}${NUMBERS}
    [Return]    ${result}

String Lenght Should Be And It Should Consist Of
    [Arguments]    ${string}    ${length}    ${allowed chars}
    Length Should Be    ${string}    ${length}
    FOR    ${i}    IN RANGE    0    ${length}
        Should Contain    ${allowed chars}    ${string[${i}]}
        ...    String '${string}' contains character '${string[${i}]}' which is not in allowed characters '${allowed chars}'.
    END

Generate Random String From Non Default Characters And [NUMBERS]
    Test Random String With    %=}$+^~*äö#${NUMBERS}    %=}$+^~*äö#[NUMBERS]
    Test Random String With    %=}$+^~*äö#${NUMBERS}    [NUMBERS]%=}$+^~*äö#
    Test Random String With    %=}$+^~*äö#${NUMBERS}    %=}[NUMBERS]$+^~*äö#

Test Random String With
    [Arguments]    ${expected characters}    ${given characters}
    ${result} =    Generate Random String    100    ${given characters}
    String Lenght Should Be And It Should Consist Of    ${result}    100   ${expected characters}

Generate Random String From Non Default Characters
    Test Random String With    %=}$+^~*äö#    %=}$+^~*äö#

Select Random Status
    ${random_number}=    Evaluate    random.randint(1, 4)   random
    ${randomNum}=   convert to string   ${random_number}
    select from list by index    ${selectStatus}  ${randomNum}

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


Navigate To The HomePage
    open browser    ${SiteUrl}     ${Browser}
    maximize browser window
    Set Selenium Implicit Wait    10 Seconds
    Set Selenium Speed     .10 seconds

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

*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String



*** Variables ***
${LOWER}          qwertyuiopasdfghjklzxcvbnm
${UPPER}          QWERTYUIOPASDFGHJKLZXCVBNM
${LETTERS}        ${LOWER}${UPPER}
${NUMBERS}        1234567890

${addInvoiceButton}=    Add Invoice
${invoiceNumberInput}=  invoice
${companyNameInput}=    company


*** Keywords ***
Get All Invoices
    @{invoices}=    get webelements    xpath: (//tr[@class='invoice ng-scope']//td[1]//a)
    ${count}    get element count    xpath: (//tr[@class='invoice ng-scope']//td[1]//a)
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

Create Invoice Number
    ${RANUSER}    Generate Random String    10    [LETTERS]
    [Return]    ${RANUSER}

Invoice Creation Page Is Open
    Click Link  Add Invoice
    Page Should Contain Element     invoiceNo_add

Delete Invoice
    [Arguments]  ${invoice_element}
    Click Link  ${invoice_element}
    Click Button    deleteButton

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
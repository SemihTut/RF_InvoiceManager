*** Settings ***
Library    SeleniumLibrary
Library    Collections



*** Variables ***



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


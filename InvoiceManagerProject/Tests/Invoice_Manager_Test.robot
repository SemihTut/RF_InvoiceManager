*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/CommonWeb.robot
Resource    ../Resources/PageObject/InvoiceManagerPage.robot
Test Setup     Navigate To The HomePage
Test Teardown    End of the TestCase


*** Variables ***



*** Test Cases ***
#Create Invoice
 #   ${Invoices}=    InvoiceManagerPage.Get All Invoices
  #  log to console    ${Invoices}

Go To The Invoice
    InvoiceManagerPage.Get Details Of Invoice    Ahmet



*** Keywords ***




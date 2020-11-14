*** Settings ***
Library    SeleniumLibrary
Library     OperatingSystem


*** Variables ***
${Browser}        Chrome
${SiteUrl}        http://34.225.240.91/#/
${Delay}          2s


*** Keywords ***
Navigate To The HomePage
    open browser    ${SiteUrl}     ${Browser}
    maximize browser window
    Set Selenium Implicit Wait    10 Seconds
    Set Selenium Speed     .25 seconds
   # sleep   ${Delay}

End of the TestCase
    close all browsers


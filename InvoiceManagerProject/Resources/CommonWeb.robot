*** Settings ***
Library    SeleniumLibrary
Library     OperatingSystem


*** Variables ***
${Browser}        chrome
${SiteUrl}        http://34.225.240.91
${Delay}          2s


*** Keywords ***


End of the TestCase
    close all browsers


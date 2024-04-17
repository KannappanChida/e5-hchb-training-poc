*** Settings ***
Library     RPA.Browser.Playwright
Library     OperatingSystem
Library     RPA.Desktop

*** Keywords ***
OpenMenu
    [Documentation]    This keyword is used to add coordination notes in HCHB application.
    [Arguments]    ${MenuName}
    Log To Console    Opening menu Started: "${MenuName}"
    Sleep    10s
    Set Default Confidence   40
    RPA.Desktop.Click    image:${EXECDIR}/assets/ClinicalInput.png
    Log To Console    OpenMenu function Ended
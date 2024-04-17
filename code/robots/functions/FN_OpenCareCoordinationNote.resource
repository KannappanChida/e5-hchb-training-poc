*** Settings ***
Library     RPA.Browser.Playwright
Library     OperatingSystem
Library     RPA.Desktop
Library     OperatingSystem
Library     String
Library     Collections
Library     DateTime
Library     json
Library     ScreenCapLibrary
Library     app.py
Library     Process




*** Keywords ***
OpenCN
    Log To Console    Open CN Notes Function Started
    RPA.Desktop.Wait For Element    image:${EXECDIR}/assets/CI-FolderIcon.PNG    60
    RPA.Desktop.Click    image:${EXECDIR}/assets/CI-FolderIcon.PNG + offset:50,0
    Log To Console    Clicked on Record
    RPA.Desktop.Wait For Element    ${CI-MedicalReportInfo-Region}    60    0.5
    RPA.Desktop.Click    ${CI-MedicalReportInfo-Region}
    Log To Console    Clicked on Medical Report Information Tab
    RPA.Desktop.Click    ${CI-coordinationNotes-Region}
    Log To Console    Clicked on Coordination Notes SubMenu
    Log To Console    Open CN Notes Function Ended

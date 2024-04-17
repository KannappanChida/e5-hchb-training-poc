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
PanelFilter
    [Tags]             Function
    [Documentation]    This keyword filter the panel with given patient Details.
    Log To Console    Panel Filter Function started
    Sleep	2s
    Log To Console    Entered Search By Value: "${CI-SearchBy-Value}"
    RPA.Desktop.Type Text into    ${CI-SearchFor-Region}    ${CI-SearchFor-Value}    ${True}    ${True}
    Log To Console    Entered    Search For Value: "${CI-SearchFor-Value}"
    RPA.Desktop.Click    ${CI-LoadButton-Region}
    Sleep    7s
    Log To Console    Clicked on "Load" button
    Log To Console    Panel Filter Function Ended

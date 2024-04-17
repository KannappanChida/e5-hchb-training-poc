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


*** Variables ***
${File_Path}                        /rf
${DOWNLOAD_DIR}=                    ${CURDIR}
${FILENAME}=                        citrix_client.ica
${IMAGE_DIR}                        ${EXECDIR}/assets
# --

*** Keywords ***
AddCN
    [Tags]    Function
    [Documentation]        Add Care Coordination Notes
    Log To Console    Add    CN Function Started
    RPA.Desktop.Wait For Element    image:CI_AddButton.png    60
    RPA.Desktop.Click    image:CI_AddButton.png
    RPA.Desktop.Wait For Element    image:CI_NoteType.png    60
    RPA.Desktop.Type Text into
    ...    image:CI_NoteType.png + offset:0,24
    ...    ${CI-NoteType-Value}
    ...    ${True}
    ...    ${True}
    Log To Console    Entered Note Type
    RPA.Desktop.Wait For Element    image:CI_NoteDetails.png    60
    RPA.Desktop.Type Text into
    ...    image:CI_NoteDetails.png + offset:0,24
    ...    ${CI_NoteDetails_Value}
    ...    ${True}
    ...    ${True}
    Log To Console    Entered Note Details
    RPA.Desktop.Press Keys    alt    S
    Log To Console    Clicked Save and Close

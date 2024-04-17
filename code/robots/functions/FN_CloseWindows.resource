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


*** Keywords ***
fn-close-all-windows
    Log To Console    Post Validation & Close Function started
    Log To Console    Close of Add CN WindowCompleted
    # RPA.Desktop.Click    image:CI_AddButton.png + offset:0,92
    # Log To Console    Click the recent record for post validation
    # RPA.Desktop.Wait For Element    image:CI_NoteDetails.png    60
    # RPA.Desktop.Click    image:CI_NoteDetails.png + offset:0,24
   # RPA.Desktop.Clear Clipboard
   # RPA.Desktop.Press Keys    ctrl    a
   # RPA.Desktop.Press Keys    ctrl    c
   # Sleep    2s
   # ${GetText}=    RPA.Desktop.Get Clipboard Value
   # Log To Console    Copied Text:${GetText}
   # Log To Console    Given Text:${CI_NoteDetails_Value}
    RPA.Desktop.Press Keys    alt    C
    RPA.Desktop.Click    image:${EXECDIR}/assets/CI_CloseButton.png
    Log To Console    Closed All HCHB Windows
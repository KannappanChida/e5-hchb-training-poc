*** Settings ***
Library     Collections
Library     DateTime
Library     Dialogs
Library     OperatingSystem
Library     String
Library     RPA.Browser.Playwright


*** Keywords ***
initialize-fb
    [Documentation]    To initialize fb
    [Tags]    function
    Log To Console    <<< APP_URL : ${ENV_VARS}[APP_URL] >>>
    New Browser    chromium    headless=False
    New Context    viewport={'width': 1280, 'height': 720}    acceptDownloads=True
    New Page    ${ENV_VARS}[APP_URL]

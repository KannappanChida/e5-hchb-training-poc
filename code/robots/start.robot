*** Settings ***
Library     Collections
Library     DateTime
Library     Dialogs
Library     OperatingSystem
Library     String
Library     e5_rf_fb_worker_core.FBCore
Library     RPA.Browser.Playwright


*** Tasks ***
initialize-fb-worker
    initialize-library


*** Keywords ***
initialize-library
    [Documentation]    To initialize fb
    [Tags]    to initialize library
    Start FB Worker

teardown-start
    [Documentation]    Teardown step in start.robot
    Log To Console    teardown-start

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
Resource    ./robots/modules/screens/common/SCREEN_HCHBLogin.resource
Resource    ./robots/modules/screens/common/SCREEN_CitrixDesktop.resource

*** Variables ***
${File_Path}                        /rf
${IMAGE_DIR}                        ${EXECDIR}/assets
${DOWNLOAD_DIR}=                    ${CURDIR}
${FILENAME}=                        citrix_client.ica

*** Keywords ***
loginHCHB
    [Tags]    Function
    [Documentation]    Login into the HCHB and selecting the Database
    Log To Console    Login into HCHB Started
    TRY
        mod-open-browser-with-context-and-page    chromium  False  1920  1080  https://login.hchb.com/vpn/index.html
        mod-set-username    id=Enter\ user\ name    element.five27
        mod-set-password    id=passwd    Welcomespring24!
        mod-click-login-button    input#Log_On
        RPA.Browser.Playwright.Click    a#protocolhandler-welcome-installButton
        Sleep    5
        Log To Console    ${EXECDIR}
        mod-click-cancel-button    image:${EXECDIR}/assets/ubuntu_citrix_cancel.png
        Sleep    10
        mod-click-already-installed-link    image:${EXECDIR}/assets/already_installed.png
        Sleep    6
        mod-click-citrix-desktop    //a/p[text()='HCHB R2 - AGAPE CARE TRAINING']
        sleep    6
        mod-click-citrix-workspace-action
        mod-start-citrix-process
        Sleep    10
        TRY
            mod-click-accept-terms-and-conditions    image:${EXECDIR}/assets/citrix_accept_button.png
            Sleep    7
        EXCEPT
            Log To Console    No Element found for citrix accept terms agreement
        END
        TRY
            mod-click-permit-all-access        image:${EXECDIR}/assets/permit_all_access.png
            Sleep    5
        EXCEPT
            Log To Console    No Element found for permit_all_access
        END
        Log To Console    Error while executing the script
    FINALLY
        Log To Console    Launch and Login HCHB Completed
    END
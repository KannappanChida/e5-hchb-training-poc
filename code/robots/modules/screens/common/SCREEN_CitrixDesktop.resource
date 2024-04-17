*** Variables ***
${File_Path}                        /rf
${IMAGE_DIR}                        ${EXECDIR}/assets
${DOWNLOAD_DIR}=                    ${CURDIR}
${FILENAME}=                        citrix_client.ica

*** Keywords ***
mod-click-accept-terms-and-conditions
    [Documentation]  Clicks accept terms and conditions button
    [Tags]  module
    [Arguments]  ${locator}
    RPA.Browser.Playwright.Click    ${locator}
    Log To Console    Clicked citrix accept terms agreement button

mod-click-permit-all-access
    [Documentation]  Clicks permit all access button
    [Tags]  module
    [Arguments]  ${locator}
    RPA.Browser.Playwright.Click    ${locator}
    Log To Console    Clicked permit all access button

mod-start-citrix-process
    [Documentation]  start citrix process
    [Tags]  module
    Process.Start Process    /opt/Citrix/ICAClient/wfica.sh    ${DOWNLOAD_DIR}${/}${FILENAME}
    Log To Console    Starting sample.ica Completed

mod-click-citrix-workspace-action
    [Documentation]  click citrix workspace action
    [Tags]  module
    ${promise}=    RPA.Browser.Playwright.Promise To Wait For Download    ${DOWNLOAD_DIR}${/}${FILENAME}
    Set Default Confidence    60
    RPA.Desktop.Click    image:${EXECDIR}/assets/launch.png
    RPA.Desktop.Click    image:${EXECDIR}/assets/citrix_tab_open.png
    Wait For    ${promise}
    Log To Console    Clicked launch citrix workspace action

mod-click-citrix-desktop
    [Documentation]  Selects the single citrix desktop out of multiple desktops available for login
    [Tags]  module
    [Arguments]  ${locator}
    RPA.Browser.Playwright.Click    ${locator}    left    2
    Log To Console    Clicked training citrix desktop

mod-click-already-installed-link
    [Documentation]  Clicks already_installed hyperlink
    [Tags]  module
    [Arguments]  ${locator}
    Set Default Confidence    60
    RPA.Desktop.Click    ${locator}

mod-click-cancel-button
    [Documentation]  Clicks cancel hyperlink
    [Tags]  module
    [Arguments]  ${locator}
    Set Default Confidence    80
    ${region}=    Wait For element    ${locator}
    RPA.Desktop.Click    ${locator}

*** Keywords ***
mod-open-browser-with-context-and-page
    [Documentation]  Opens a new browser with specified context and navigates to the given URL.
    [Tags]  module
    [Arguments]  ${browser}  ${headless}    ${viewport_width}  ${viewport_height}  ${url}
    New Browser  ${browser}  headless=${headless}
    New Context  viewport={'width': ${viewport_width}, 'height': ${viewport_height}}
    New Page  ${url}

mod-set-username
    [Documentation]  Types the given text into the username element specified by the given locator.
    [Tags]  module
    [Arguments]  ${locator}  ${text}
    RPA.Browser.Playwright.Handle Future Dialogs    action=accept
    RPA.Browser.Playwright.Type Text  ${locator}  ${text}
    Log To Console        Entered Username

mod-set-password
    [Documentation]  Types the given text into the password element specified by the given locator.
    [Tags]  module
    [Arguments]  ${locator}  ${text}
    RPA.Browser.Playwright.Handle Future Dialogs    action=accept
    RPA.Browser.Playwright.Type Text  ${locator}  ${text}
    Log To Console        Entered Password

mod-click-login-button
    [Documentation]  Clicks login button
    [Tags]  module
    [Arguments]  ${locator}
    RPA.Browser.Playwright.Click    ${locator}
    Log To Console    Logged in successfully


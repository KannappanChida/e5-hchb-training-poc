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
Resource    ./robots/functions/FN_AddCareCoordinationNote.resource
Resource    ./robots/functions/FN_CloseWindows.resource
Resource    ./robots/functions/FN_Login.resource
Resource    ./robots/functions/FN_OpenCareCoordinationNote.resource
Resource    ./robots/functions/FN_OpenMenu.resource
Resource    ./robots/functions/FN_PanelFilter.resource

*** Variables ***
${File_Path}                        /rf
${DOWNLOAD_DIR}=                    ${CURDIR}
${FILENAME}=                        citrix_client.ica
# --
${ClinicalInputSearchByImage}=      image:${EXECDIR}/assets/ClinicalInputSearchBy.png
${CI-SearchBy-Region}=              image:${EXECDIR}/assets/CI-SearchBy.PNG + offset:0,23
${CI-SearchBy-Value}=               Patient Name
${CI-SearchFor-Region}=             image:${EXECDIR}/assets/CI-SearchFor.PNG + offset:0,23
${CI-SearchFor-Value}=              John
${CI-LoadButton-Region}=            image:${EXECDIR}/assets/CI-Loadbtn.PNG
${CI-MedicalReportInfo-Region}=     image:${EXECDIR}/assets/CI-MedicareInfo.PNG
${CI-coordinationNotes-Region}=     image:${EXECDIR}/assets/CI-CN-SubMenu.PNG
${CI-NoteType-Value}=               ERMA
${CI_NoteDetails_Value}=            PAYER RETURNED INFORMATION IDENTIFIED ON ELIGIBILITY\n INQUIRY REJECTED - SUBSCRIBER DEMOGRAPHIC INFO \n REASONINVALID / MISSING SUBSCRIBER / INSURED IDACTIONPLEASE CORRECT AND RESUBMIT


*** Tasks ***
FB-AddCoodinationNotes
    [Documentation]    This task will add coordination notes in HCHB application.
    TRY 
        Set Default Confidence  80
        Log To Console      <<< started execution of FB : Add Coordination Notes  >>>
        FN_Login.loginHCHB
        # DemoDesktop
        Log To Console    <--- Adding Coordination Notes FB Started --->
        FN_OpenMenu.OpenMenu    Clinical Input
        Sleep	5
        FN_PanelFilter.PanelFilter
        # FN_OpenCareCoordinationNote.OpenCN
        # FN_AddCareCoordinationNote.AddCN
        FN_CloseWindows.fn-close-all-windows
        Log To Console    <--- Adding Coordination Notes FB Ended --->
        EXCEPT	AS	${Exception_msg}
        Log To Console	--Main Task Exception in : ${Exception_msg} --
    FINALLY
        Log To Console    <<< inside finally block >>>
    END

*** Keywords ***



PostValidate-Close
    Log To Console    Post Validation & Close Function started
    Log To Console    Close of Add CN WindowCompleted
    RPA.Desktop.Click    image:CI_AddButton.png + offset:0,92
    Log To Console    Click the recent record for post validation
    RPA.Desktop.Wait For Element    image:CI_NoteDetails.png    60
    RPA.Desktop.Click    image:CI_NoteDetails.png + offset:0,24
   # RPA.Desktop.Clear Clipboard
   # RPA.Desktop.Press Keys    ctrl    a
   # RPA.Desktop.Press Keys    ctrl    c
   # Sleep    2s
   # ${GetText}=    RPA.Desktop.Get Clipboard Value
   # Log To Console    Copied Text:${GetText}
   # Log To Console    Given Text:${CI_NoteDetails_Value}
    RPA.Desktop.Press Keys    alt    C
    RPA.Desktop.Click    image:CI_CloseButton.png
    Log To Console    Closed All HCHB Windows


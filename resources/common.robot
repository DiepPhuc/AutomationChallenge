*** Settings ***
Library  SeleniumLibrary  #run_on_failure=Nothing
Library  OperatingSystem
Variables  ${EXECDIR}/utils/constants.py
*** Keywords ***
Go To Home Page
    Go To  ${AUT_URL}
Begin Web Test
    ${system}=    Evaluate    platform.system()    platform
    Run Keyword If  '${BROWSER}'=='Chrome'  Open Chrome Browser  ${system}  ${HEADLESS}
    ...     ELSE IF  '${BROWSER}'=='Firefox'  Open Firefox Browser  ${system}  ${HEADLESS}
    Set Window Size  1920  1080
    SeleniumLibrary.Set Screenshot Directory    ./results/image
    Go To Home Page
    Create Session  test-session  ${API_URL}  verify=true
Open Firefox Browser
    [Arguments]  ${os_system}  ${has_headless}=False
    ${firefox_options} =     Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys, selenium.webdriver
    #Setup headless mode
    Run Keyword If  '${has_headless}'=='True'  Call Method    ${firefox_options}    add_argument    --headless
    #Setup MacOS
    Run Keyword If  '${os_system}'=='Darwin'  Run Keywords  Call Method    ${firefox_options}    add_argument    --no-sandbox
    ...  AND    Call Method    ${firefox_options}    add_argument    --ignore-certificate-errors
    #Setup linux
    Run Keyword If  '${os_system}'=='linux'  Run Keywords  Call Method    ${firefox_options}    add_argument    --no-sandbox
    ...  AND   Call Method    ${firefox_options}    add_argument    --ignore-certificate-errors
    ...  AND   Call Method    ${firefox_options}    add_argument    --disable-extensions
    ...  AND   Call Method    ${firefox_options}    add_argument    --disable-dev-shm-usage
    Create Webdriver    Firefox    options=${firefox_options}
Open Chrome Browser
    [Arguments]  ${os_system}  ${has_headless}=False
    ${chrome_options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    #Setup headless mode
    Run Keyword If  '${has_headless}'=='True'  Call Method    ${chrome_options}    add_argument    --headless
    #Setup MacOS
    Run Keyword If  '${os_system}'=='Darwin'  Run Keywords    Call Method    ${chrome_options}    add_argument    --no-sandbox
    ...  AND   Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    #Setup linux
    Run Keyword If  '${os_system}'=='linux'  Run Keywords  Call Method    ${chrome_options}    add_argument    --no-sandbox
    ...  AND    Call Method    ${chrome_options}    add_argument    --disable-extensions
    ...  AND    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    ...  AND    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    Create Webdriver    Chrome   chrome_options=${chrome_options}
End Web Test
    Close All Browsers
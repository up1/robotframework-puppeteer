*** Settings ***
Library    PuppeteerLibrary
Test Teardown    Close Browser

*** Variables ***
${HOME_PAGE_URL}    http://127.0.0.1:7272


*** Test Cases ***
Demo wait for element
    ${HEADLESS}     Get variable value    ${HEADLESS}    ${False}
    &{options} =    create dictionary   headless=${HEADLESS}
    Open browser    ${HOME_PAGE_URL}   options=${options}
    Wait Until Page Contains Element    id:username_field
    Run Keyword And Expect Error    STARTS: TimeoutError:    Wait Until Page Contains Element    css:no_element    timeout=5s

Demo wait for http response
    ${HEADLESS}     Get variable value    ${HEADLESS}    ${False}
    &{options} =    create dictionary   headless=${HEADLESS}
    Open browser    ${HOME_PAGE_URL}   options=${options}
    Run Async Keywords
    ...    Click Element    id:login_button    AND
    ...    Wait for response url    ${HOME_PAGE_URL}/error.html
    
Demo wait for navigation
    ${HEADLESS}     Get variable value    ${HEADLESS}    ${False}
    &{options} =    create dictionary   headless=${HEADLESS}
    Open browser    ${HOME_PAGE_URL}   options=${options}
    Run Async Keywords
    ...    Click Element    id:login_button    AND
    ...    Wait For Navigation

Demo wait for element hidden and visible
    ${HEADLESS}     Get variable value    ${HEADLESS}    ${False}
    &{options} =    create dictionary   headless=${HEADLESS}
    Open browser    ${HOME_PAGE_URL}   options=${options}
    Run Async Keywords
    ...    Click Element    id:login_button    AND
    ...    Wait For Navigation
    Wait Until Element Is Hidden    id:login_button
    Wait Until Page Contains    Invalid user name and/or password
    Wait Until Page Does Not Contains    Please input your user name
    
Demo wait for element contains text
    ${HEADLESS}     Get variable value    ${HEADLESS}    ${False}
    &{options} =    create dictionary   headless=${HEADLESS}
    Open browser    ${HOME_PAGE_URL}   options=${options}
    Wait Until Element Contains    css:#container p    Please input your user name
    Wait Until Element Does Not Contains    css:#container p    Invalid user name and/or password

*** Settings ***
Library  SeleniumLibrary  #run_on_failure=Nothing
Library  BuiltIn
Variables  ${EXECDIR}/utils/constants.py
*** Keywords ***
Scroll And Click
    [Arguments]  ${element_clickable}
    Wait Until Element Is Visible  ${element_clickable}  ${TIMED_OUT}  ${element_clickable} not found
    Scroll Element Into View  ${element_clickable}
    Click Element  ${element_clickable}
Wait And Click
    [Arguments]  ${element_click}
    Wait Until Element Is Visible  ${element_click}  ${TIMED_OUT}  ${element_click} not found
    Click Element  ${element_click}
Wait And Input
    [Arguments]  ${element_input}  ${text}
    Wait Until Element Is Visible  ${element_input}  ${TIMED_OUT}  ${element_input} not found
    Input Text  ${element_input}  ${text}
Clear Text
    [Arguments]  ${element_clear}  ${attribute_element}
    Wait Until Element Is Visible  ${element_clear}   ${TIMED_OUT}   ${element_clear}
    ${value} =     Get Element Attribute   ${element_clear}      ${attribute_element}
    ${backspaces count} =    Get Length      ${value}
    Run Keyword If    '${value}' != ''
    ...     Repeat Keyword  ${backspaces count +1}  Press Keys  ${element_clear}   DELETE
Wait And Get Text
    [Arguments]  ${text_element}
    Wait Until Element Is Visible  ${text_element}  ${TIMED_OUT}  ${text_element} not found
    ${text} =  Get Text  ${text_element}
    [Return]  ${text}
Count And Verify
    [Arguments]  ${count_numb}  ${actual}  ${expected}
    FOR  ${i}  IN RANGE  1  ${count_numb}+1
        ${result} =  helper_func.Wait And Get Text  ${DROPDOWN_MENU}[${i}]
        Should Contain  ${actual}  ${expected}
Convert Numb To Int
    [Arguments]  ${number}
    ${number} =  convert to number  ${number}  0
    ${number} =  convert to integer  ${number}
    [Return]  ${number}

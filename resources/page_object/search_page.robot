*** Settings ***
Library  SeleniumLibrary  #run_on_failure=Nothing
Library  BuiltIn
Library  Collections
Library  String
Resource  ${EXECDIR}/utils/helper_func.robot
Variables  ${EXECDIR}/resources/page_object/object_repository.py
Variables  ${EXECDIR}/utils/constants.py
*** Keywords ***
Input City
    [Arguments]  ${the_city}
    Wait Until Element Is Not Visible  ${LOADING_COVER}  ${TIMED_OUT}
    helper_func.Scroll And Click  ${SEARCH_FIELD}
    helper_func.Wait And Input  ${SEARCH_FIELD}  ${the_city}
Submit Field
    helper_func.Scroll And Click  ${SUBMIT_BTN}
Verify Results
    [Arguments]  ${the_city}
    ${check_valid} =  Run Keyword And Return Status  Wait Until Element Is Visible  ${DROPDOWN_MENU}/li  3s
    ${count_result} =  Get Element Count  ${DROPDOWN_MENU}/li
    # Cannot use multiple condition with IF statement in Robot Framework
    IF  '${check_valid}' == 'True'
        IF  ${count_result} > 1
            FOR  ${i}  IN RANGE  1  ${count_result}+1
            ${result} =  helper_func.Wait And Get Text  ${DROPDOWN_MENU}/li[${i}]/span
            Should Contain  ${result}  ${the_city}  ${the_city} not found
            END
        ELSE
        ${result} =  helper_func.Wait And Get Text  ${DROPDOWN_MENU}/li/span
        Should Contain  ${result}  ${the_city}  ${the_city} not found
        END
    ELSE
        Verify No Result
    END

Verify No Result
    ${actual_error_msg} =  helper_func.Wait And Get Text  ${ERROR_MSG_LOC}
    Should Be Equal As Strings  ${actual_error_msg}  ${ERROR_MSG}  ${actual_error_msg} message not found
Get Infos City
    ${city_name} =  helper_func.Wait And Get Text  ${DROPDOWN_MENU}/li[1]/span[1]
    ${temperature} =  helper_func.Wait And Get Text  ${DROPDOWN_MENU}/li[1]/span[2]
    ${lat_lng} =  helper_func.Wait And Get Text  ${DROPDOWN_MENU}/li[1]/span[4]
    ${city_infos} =  Create List  ${city_name}  ${temperature}  ${lat_lng}
    [Return]  ${city_infos}
Select Option City
    ${check_valid} =  Run Keyword And Return Status  Wait Until Element Is Visible  ${DROPDOWN_MENU}/li  3s
    IF  '${check_valid}' == 'True'
        helper_func.Scroll And Click  ${DROPDOWN_MENU}/li[1]
    ELSE
        Fail  "There is no option to select"
    END
Verify Section Content
    [Arguments]  ${selected_city}  ${city}
    Wait Until Element Is Not Visible  ${LOADING_COVER}  ${TIMED_OUT}
    ${actual_city_name} =  helper_func.Wait And Get Text  ${CITY_NAME_CONTENT}
    ${actual_city_name} =  Get Regexp Matches  ${actual_city_name}  ${city}
    ${expected_selected_city} =  Get Regexp Matches  ${selected_city}[0]  ${city}
    ${actual_city_temperature} =  helper_func.Wait And Get Text  ${CITY_TEMPERATURE_CONTENT}
    Should Be Equal As Strings  ${actual_city_name[0]}  ${expected_selected_city[0]}
    Should Be Equal As Strings  ${actual_city_temperature}  ${selected_city}[1]  ${actual_city_temperature} not match with ${selected_city}[1]
Verify Imperial
    ${actual_city_temperature} =  helper_func.Wait And Get Text  ${CITY_TEMPERATURE_CONTENT}
    ${actual_city_temperature} =  Get Substring  ${actual_city_temperature}  -1
    Should Be Equal As Strings  ${actual_city_temperature}  F

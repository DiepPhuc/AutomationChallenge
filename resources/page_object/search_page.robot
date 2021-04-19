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
    #Should Be Equal As Strings  ${actual_city_temperature}  ${selected_city}[1]  ${actual_city_temperature} not match with ${selected_city}[1]
Verify Imperial
    Wait Until Element Is Not Visible  ${LOADING_COVER}  ${TIMED_OUT}
    ${actual_city_temperature} =  helper_func.Wait And Get Text  ${CITY_TEMPERATURE_CONTENT}
    ${actual_city_temperature} =  Get Substring  ${actual_city_temperature}  -1
    Should Be Equal As Strings  ${actual_city_temperature}  F
Verify Weather Data
    [Arguments]  ${weather_city_data}  ${weather_infos_data}
    Wait Until Element Is Not Visible  ${LOADING_COVER}  ${TIMED_OUT}
    Scroll Element Into View  xpath://*[contains(@class,"weather-items")]//li

    ${actual_city_name} =  helper_func.Wait And Get Text  ${CITY_NAME_CONTENT}
    ${expected_city_name} =  Set Variable  ${weather_city_data}[0], ${weather_city_data}[1]

    ${actual_temp} =  helper_func.Wait And Get Text  ${CITY_TEMPERATURE_CONTENT}
    ${expected_temp} =  Set Variable  ${weather_infos_data}[0]°C

    ${actual_temp_feels_like} =  helper_func.Wait And Get Text  ${FEELS_LIKE_TEMPERATURE}
    ${actual_temp_feels_like} =  Get Regexp Matches  ${actual_temp_feels_like}  .[^.]*
    ${actual_weather_items} =  Get Weather Items

    ${expected_temp_feels_like} =  Set Variable  Feels like ${weather_infos_data}[1]°C
    ${expected_weather_desc} =  Set Variable  ${weather_infos_data}[2]
    ${expected_humidity} =  Set Variable  ${weather_infos_data}[3]
    ${expected_pressure} =  Set Variable  ${weather_infos_data}[4]
    ${expected_wind} =  Set Variable  ${weather_infos_data}[5]
    ${expected_visibility} =  Set Variable  ${weather_infos_data}[6]
    ${expected_dew_point} =  Set Variable  ${weather_infos_data}[7]

    Should Be Equal As Strings  ${actual_city_name}  ${expected_city_name}
    Should Be Equal As Strings  ${actual_temp}  ${expected_temp}
    Should Contain  ${actual_temp_feels_like}[0]  ${expected_temp_feels_like}
    Should Contain  ${actual_temp_feels_like}[1]  ${expected_weather_desc}  ignore_case=True
    ###Hard code title data###
    Should Contain  ${actual_weather_items}[0]    ${expected_wind}m/s
    Should Contain  '${actual_weather_items}[1]'      '${expected_pressure}hPa'
    Should Contain  '${actual_weather_items}[2]'      'Humidity:\n${expected_humidity}%'
    Should Contain  '${actual_weather_items}[3]'      'Dew point:\n${expected_dew_point}°C'
    Should Contain  '${actual_weather_items}[4]'      'Visibility:\n${expected_visibility}km'
Get Weather Items
    ${weather_items_length} =  Get Element Count  ${WEATHER_ITEMS}
    ${weather_items_list} =  Create List
    FOR  ${i}  IN RANGE  1  ${weather_items_length}+1
         ${weather_item} =  helper_func.Wait And Get Text  xpath://*[contains(@class,"weather-items")]//li[${i}]
         Append To List  ${weather_items_list}  ${weather_item}
    END
    [Return]  ${weather_items_list}
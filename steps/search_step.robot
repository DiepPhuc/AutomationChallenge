*** Settings ***
Library  SeleniumLibrary  #run_on_failure=Nothing
Resource  ${EXECDIR}/resources/page_object/search_page.robot
Resource  ${EXECDIR}/resources/common.robot
Resource  ${EXECDIR}/resources/api/get_api.robot
Variables  ${EXECDIR}/resources/page_object/object_repository.py
*** Keywords ***
user goes to homepage
    common.Go To Home Page
he inputs city in the text field
    [Arguments]  ${city}
    search_page.Input City  ${city}
he clicks on Submit button
    search_page.Submit Field
he selects the options city
    ${city_infos} =  search_page.Get Infos City
    search_page.Select Option City
    Set Test Variable  ${city_infos}
he clicks on Imperial button
    helper_func.Wait And Click   ${IMPERIAL_BTN}
he selects the first city
    [Arguments]  ${city}
    ${weather_city_data} =  get_api.Get info_city_weather  ${city}
    ${weather_infos_data} =  get_api.Get current_weather  ${city}
    search_page.Select Option City
    Set Test Variable  ${weather_city_data}
    Set Test Variable  ${weather_infos_data}
verify that the information weather is displayed same as response data
    search_page.Verify Weather Data  ${weather_city_data}  ${weather_infos_data}
verify that the temperature is changed from metric to imperial
    search_page.Verify Imperial
verify that the city is displayed correctly
    [Arguments]  ${the_city}
    search_page.Verify Results  ${the_city}
verify that the city is displayed correctly in section content
    [Arguments]  ${city}
    search_page.Verify Section Content  ${city_infos}  ${city}

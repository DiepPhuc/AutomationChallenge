*** Settings ***
Library  SeleniumLibrary  #run_on_failure=Nothing
Resource  ${EXECDIR}/resources/page_object/search_page.robot
Resource  ${EXECDIR}/resources/common.robot
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
    Set Suite Variable  ${city_infos}
he clicks on Imperial button
    helper_func.Wait And Click   ${IMPERIAL_BTN}

verify that the temperature is changed from metric to imperial
    search_page.Verify Imperial
verify that the city is displayed correctly
    search_page.Verify Results
verify that the city is displayed correctly in section content
    [Arguments]  ${city}
    search_page.Verify Section Content  ${city_infos}  ${city}

*** Settings ***
Documentation  Test Suites for Searching weather
Resource  ${EXECDIR}/resources/Common.robot
Resource  ${EXECDIR}/resources/page_object/search_page.robot
Variables  ${EXECDIR}/utils/constants.py
Library  DataDriver  ${EXECDIR}/test_data/country_data.csv

Test Setup  Begin Web Test
Test Teardown  End Web Test
Test Template  Searching Weather

*** Test Cases ***
Verify Searching Weather    ${country}

*** Keywords ***
Searching Weather
    [Arguments]  ${country}
    search_page.Input City  ${country}
    search_page.Submit Field
    search_page.Verify Results  ${country}

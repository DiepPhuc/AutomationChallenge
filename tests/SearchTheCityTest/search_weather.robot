*** Settings ***
Documentation  Test Suites for Searching weather
Resource  ${EXECDIR}/resources/Common.robot
Resource  ${EXECDIR}/resources/page_object/search_page.robot
Resource  ${EXECDIR}/steps/search_step.robot
Variables  ${EXECDIR}/utils/constants.py
Test Setup  Begin Web Test
Test Teardown  End Web Test
*** Test Cases ***
#User can search the city
#    [Tags]  TC-can_search_city
#    Given user goes to homepage
#    And he inputs city in the text field  Thanh pho Ho Chi Minh
#    When he clicks on Submit button
#    Then verify that the city is displayed correctly
#User can select the options city
#    [Tags]  TC-can_select_options_city
#    Given user goes to homepage
#    And he inputs city in the text field  Ho Chi Minh
#    When he clicks on Submit button
#    And he selects the options city
#    Then verify that the city is displayed correctly in section content  Ho Chi Minh
User can change temperature from metric to imperial
    [Tags]  TC-can_change from_metric_to_imperial
    Given user goes to homepage
    When he clicks on Imperial button
    Then verify that the temperature is changed from metric to imperial
Verify that information weather is displayed same as respsonse data
    [Tags]  TC-verify_that_information_weather_is_displayed_same_as_data
    Given user goes to homepage
    And he inputs city in the text field  Ho Chi Minh
    When he clicks on Submit button
    And he selects the options city
    Then verify that the information weather is displayed same as response data
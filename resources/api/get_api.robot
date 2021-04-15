*** Settings ***
Library  Collections
Library  RequestsLibrary
Library  BuiltIn
Library  String
Variables  ${EXECDIR}/utils/constants.py
*** Keywords ***
Get city_id
    [Arguments]  ${city}
    Create Session  test-session  ${API_URL}  verify=true
    ${city} =  Encode String To Bytes  ${city}  UTF-8
    ${res} =  Get Request  test-session  /data/2.5/find?q=${city}&appid=439d4b804bc8187953eb36d2a8c26a02&units=metric
    ${res_data} =  set variable   ${res.json()}
    ${list_city} =  set variable  ${res_data['list']}
    ${city_id} =  Get From Dictionary  ${list_city}[0]  id
    #log to console  ${city_id}
    [Return]  ${city_id}
Get info_weather
    [Arguments]  ${city_id}
    ${res} =  Get Request  test-session  /data/2.5/weather?id=${city_id}&units=metric&appid=439d4b804bc8187953eb36d2a8c26a02
    log to console  ${res.json()}
*** Test Cases ***
Get info weather
    ${city_id} =  Get city_id  Ho Chi Minh
    Get info_weather  ${city_id}
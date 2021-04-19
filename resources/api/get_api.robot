*** Settings ***
Library  Collections
Library  RequestsLibrary
Library  BuiltIn
Library  String
Resource  ${EXECDIR}/utils/helper_func.robot
Variables  ${EXECDIR}/utils/constants.py
*** Keywords ***
Get city_id
    [Arguments]  ${city}
    Create Session  test-session  ${API_URL}  verify=true
    ${city} =  Encode String To Bytes  ${city}  UTF-8
    ${res} =  Get Request  test-session  /data/2.5/find?q=${city}&appid=439d4b804bc8187953eb36d2a8c26a02&units=metric
    ${res_data} =  Set Variable   ${res.json()}
    ${list_city} =  Set Variable  ${res_data['list']}
    ${city_id} =  Get From Dictionary  ${list_city}[0]  id
    [Return]  ${city_id}
Get lat_lng
    [Arguments]  ${city}
    Create Session  test-session  ${API_URL}  verify=true
    ${city} =  Encode String To Bytes  ${city}  UTF-8
    ${res} =  Get Request  test-session  /data/2.5/find?q=${city}&appid=439d4b804bc8187953eb36d2a8c26a02&units=metric
    ${res_data} =  Set Variable   ${res.json()}
    ${list_city} =  Set Variable  ${res_data['list']}
    ${lat} =  Set Variable  ${list_city}[0][coord][lat]
    ${lng} =  Set Variable  ${list_city}[0][coord][lon]
    ${coord} =  Create List
    Append To List  ${coord}  ${lat}  ${lng}
    [Return]  ${coord}
Get current_weather
    [Arguments]  ${city}
    ${coord} =  Get lat_lng  ${city}
    ${res} =  Get Request  test-session  /data/2.5/onecall?lat=${coord}[0]&lon=${coord}[1]&units=metric&appid=439d4b804bc8187953eb36d2a8c26a02
    ${body_data} =  Set Variable  ${res.json()}
    ${temp} =  Set Variable  ${body_data}[current][temp]
    ${temp} =  Convert Numb To Int  ${temp}
    ${temp_feels_like} =  Set Variable  ${body_data}[current][feels_like]
    ${temp_feels_like} =  Convert Numb To Int  ${temp_feels_like}
    ${humidity} =  Set Variable  ${body_data}[current][humidity]
    ${pressure} =  Set Variable  ${body_data}[current][pressure]
    ${wind} =  Set Variable  ${body_data}[current][wind_speed]
    ${wind} =  Convert To Number  ${wind}  1
    ${visibility} =  Set Variable  ${body_data}[current][visibility]
    ${visibility} =  Evaluate  ${visibility}/1000
    ${weather_desc} =  Set Variable  ${body_data}[current][weather][0][description]
    ${dew_point} =  Set Variable  ${body_data}[current][dew_point]
    ${dew_point} =  Convert Numb To Int  ${dew_point}
    ${weather_infos_data} =  Create List  ${temp}  ${temp_feels_like}  ${weather_desc}  ${humidity}  ${pressure}  ${wind}  ${visibility}  ${dew_point}
    [Return]  ${weather_infos_data}
Get info_city_weather
    [Arguments]  ${city}
    ${city_id} =  Get city_id  ${city}
    ${res} =  Get Request  test-session  /data/2.5/weather?id=${city_id}&units=metric&appid=439d4b804bc8187953eb36d2a8c26a02
    ${body_data} =  Set Variable  ${res.json()}
    ${city_name} =  Set Variable  ${body_data}[name]
    ${country} =  Set Variable  ${body_data}[sys][country]
    ###Hard code data###
    ${weather_city_data} =  Create List  ${city_name}  ${country}
    [Return]  ${weather_city_data}
#*** Test Cases ***
#Get info weather
#    Get lat_lng  Ho Chi Minh
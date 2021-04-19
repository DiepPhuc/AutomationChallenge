# AutomationChallenge
- Before run test you need to install python 3 and pip3. 
    Please help me download it, before run test
    Link download python 3: https://www.python.org/downloads/
    Install pip3: python3 -m pip install --upgrade pip
- Open project and go to terminal:
- Run command line: pip3 install -r requirements.txt (It will install the package which need to run test)
- Run Data Driven Test:
    robot -d results tests/DataDrivenTest/search_weather.robot
- Run Search Weather City Test
     robot -d results tests/SearchTheCityTest/search_weather.robot
- Run Parallel:
    pabot --processes 2 --pabotlib -d results tests

# AutomationChallenge
- Before run test you need to install python 3 and pip3.(Important!!!)
    Please help me download it, before run test
    Link download python 3: https://www.python.org/downloads/
    Install pip3: python3 -m pip install --upgrade pip
1. Open project and go to terminal
2. Run command line: pip3 install -r requirements.txt (It will install the package which need to run test)
3. Run Test
- Data Driven Test:
    robot -d results tests/DataDrivenTest/search_weather.robot
- Run Search Weather City Test:
    robot -d results tests/SearchTheCityTest/search_weather.robot
- Run Parallel:
    pabot --processes 2 --pabotlib -d results tests
    
- I'm setting up 2 browser platform to run test (Chrome & Firefox), if you want to run with one of type,
 please follow below (Currently, the default is Chrome)
  - Chrome:  
        robot -d results -v BROWSER:Chrome tests/DataDrivenTest/search_weather.robot
  - Firefox: 
        robot -d results -v BROWSER:Firefox tests/DataDrivenTest/search_weather.robot
- If you want to run with headless mode, please follow below:
        robot -d results -v HEADLESS:True tests/DataDrivenTest/search_weather.robot
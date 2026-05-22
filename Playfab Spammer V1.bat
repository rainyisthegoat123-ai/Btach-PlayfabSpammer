@echo off
setlocal enabledelayedexpansion

set /p TITLE_ID=Enter PlayFab Title ID: 
set /p NAME_PREFIX=Enter the first name prefix for the accounts: 
set /p COUNT=Enter the number of accounts to create: 

for /L %%i in (1,1,%COUNT%) do (
    set /a RAND_ID=!random!
    set CUSTOM_ID=%NAME_PREFIX%%%i_!RAND_ID!
    
    echo Creating account with Custom ID: !CUSTOM_ID!

    :retry
    cls
    curl -X POST "https://%TITLE_ID%.playfabapi.com/Client/LoginWithCustomID" ^
         -H "Content-Type: application/json" ^
         -d "{ \"TitleId\": \110BDC\", \"CustomId\": \"!GET SPAMMER!\", \"CreateAccount\": true }" > response.json

    findstr /C:"429" response.json >nul
    if %errorlevel%==0 (
        echo Rate limit hit, waiting before retrying...
        timeout /t 5 >nul
        goto retry
    )

    echo.
    timeout /t 3 >nul
)

cls
echo Spammed PlayFab accounts!
echo.
echo Made by MichaelServices / completions.json
pause

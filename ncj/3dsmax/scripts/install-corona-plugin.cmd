set fairSaasUsername=%~1
set fairSaasPassword=%~2

rem If already installed, skip
if exist %AZ_BATCH_NODE_SHARED_DIR%\init_corona_plugin.txt exit /b 0

rem Extract and install Corona Plugin for 3ds Max 2018
7z x -y 3dsmax-corona-2018-plugin.zip -o %3DSMAX_2018%
if %errorlevel% neq 0 exit /b %errorlevel%

rem Extract and install Corona Plugin for 3ds Max 2019
7z x -y 3dsmax-corona-2019-plugin.zip -o %3DSMAX_2019%
if %errorlevel% neq 0 exit /b %errorlevel%

set corona_activation_path=%LOCALAPPDATA%\CoronaRenderer
if exist %corona_activation_path% goto CreateCoronaLicenseFile

rem Create directory for Corona License Activation
mkdir %corona_activation_path%
if %errorlevel% neq 0 exit /b %errorlevel%

:CreateCoronaLicenseFile
echo %fairSaasUsername%:%fairSaasPassword% > %corona_activation_path%\CoronaActivation.txt
if %errorlevel% neq 0 exit /b %errorlevel%

rem Write a flag so we know we're done
echo done > %AZ_BATCH_NODE_SHARED_DIR%\init_corona_plugin.txt

:Done
exit /b 0
@echo off
setlocal

:: This repo was made for linux so if this doesnt work on windows, I'm sorry but I might not fix it

:: == BELOW IS AI GENERATED ==

:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This only works as administrator lmao
    exit /b 1
)

:: Download and install nvm
curl -o install_nvm.bat https://raw.githubusercontent.com/coreybutler/nvm-windows/master/nvm-setup.zip
start /wait install_nvm.bat

:: Set NVM_DIR environment variable
set "NVM_DIR=%USERPROFILE%\.nvm"
if exist "%NVM_DIR%\nvm.exe" (
    call "%NVM_DIR%\nvm.exe"
)

:: Install pnpm globally
npm install -g pnpm

:: Get rid of old files
echo Removing old files...
rmdir /s /q remote

:: Scripts
echo Downloading userplugins...
cd scripts
node downloadPlugins.js
cd ..

:: Clone the repository
echo Cloning the repository...
git clone https://github.com/Vendicated/Vencord.git remote
cd remote

:: Install the dependencies
echo Installing dependencies...
pnpm install --frozen-lockfile

:: Pre build setup
:: Replace files in ./ with any found in ../overrides
echo Replacing files with overrides...
xcopy /e /i /y ..\overrides\* .\

:: Build the project
echo Building the project...
pnpm build

:: Inject into the client
echo Injecting into the client...
pnpm inject

:: Change file ownership of remote to the user who ran the script
:: This step is not applicable in Windows batch script

:: Finished
echo Finished installing. Feel free to close this terminal or run 'exit' to return to your normal shell

endlocal

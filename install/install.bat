@ECHO OFF

REM ---------------
REM | SLASHCODE INSTALLER
REM |-- version: dev-2

ECHO ---------------
ECHO | SLASHCODE INSTALLER
ECHO |-- versions: installer one
ECHO |-- slashcode dev-1

REM Check if Ruby is installed
ruby -v >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO | Error
    ECHO |-- Ruby not found. Please install Ruby manually.
    EXIT /B 1
)

REM Install slashcode gem
ECHO | Installing slashcode gem...
gem install slashcode

ECHO | Installation complete!

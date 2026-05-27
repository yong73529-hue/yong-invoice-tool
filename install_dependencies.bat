@echo off
cd /d "%~dp0"
chcp 65001 >nul
set PYTHONUTF8=1
set PYTHONIOENCODING=utf-8
set LOG_FILE=%~dp0install_log.txt

echo Installing dependencies for Invoice PDF Summary Tool... > "%LOG_FILE%"
echo Run time: %DATE% %TIME% >> "%LOG_FILE%"
echo Work folder: %CD% >> "%LOG_FILE%"
echo. >> "%LOG_FILE%"

echo Installing dependencies for Invoice PDF Summary Tool...
echo.

set PY_CMD=
py -3 --version >nul 2>nul
if not errorlevel 1 set PY_CMD=py -3
if "%PY_CMD%"=="" (
    python --version >nul 2>nul
    if not errorlevel 1 set PY_CMD=python
)

if "%PY_CMD%"=="" (
    echo Python was not found.
    echo Please install Python 3.11 or newer from https://www.python.org/downloads/
    echo During installation, select "Add python.exe to PATH".
    echo Python was not found. >> "%LOG_FILE%"
    echo.
    pause
    exit /b 1
)

echo Python command: %PY_CMD% >> "%LOG_FILE%"
%PY_CMD% --version >> "%LOG_FILE%" 2>&1

if not exist "%~dp0requirements.txt" (
    echo requirements.txt was not found.
    echo requirements.txt was not found. >> "%LOG_FILE%"
    echo Please make sure requirements.txt is in the same folder.
    echo.
    pause
    exit /b 1
)

%PY_CMD% -m pip install -r requirements.txt >> "%LOG_FILE%" 2>&1
set INSTALL_EXIT=%ERRORLEVEL%

type "%LOG_FILE%"

if not "%INSTALL_EXIT%"=="0" (
    echo.
    echo Dependency installation failed. Details were saved to install_log.txt.
    echo Please send install_log.txt back for checking.
    echo.
    pause
    exit /b %INSTALL_EXIT%
)

echo.
echo Dependency installation finished.
pause

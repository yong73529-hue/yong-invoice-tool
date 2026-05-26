@echo off
cd /d "%~dp0"
chcp 65001 >nul
set PYTHONUTF8=1
set PYTHONIOENCODING=utf-8

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
    echo.
    pause
    exit /b 1
)

%PY_CMD% -m pip install -r requirements.txt

echo.
echo Dependency installation finished.
pause

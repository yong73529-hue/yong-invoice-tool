@echo off
cd /d "%~dp0"
chcp 65001 >nul
set PYTHONUTF8=1
set PYTHONIOENCODING=utf-8
set LOG_FILE=%~dp0run_log.txt

echo Invoice PDF Summary Tool > "%LOG_FILE%"
echo Run time: %DATE% %TIME% >> "%LOG_FILE%"
echo Work folder: %CD% >> "%LOG_FILE%"
echo. >> "%LOG_FILE%"

echo Invoice PDF Summary Tool
echo.

set PY_CMD=
py -3 --version >nul 2>nul
if not errorlevel 1 set PY_CMD=py -3
if "%PY_CMD%"=="" (
    python --version >nul 2>nul
    if not errorlevel 1 set PY_CMD=python
)

if "%PY_CMD%"=="" (
    echo Python was not found. Please install Python 3.11 or newer.
    echo During installation, select "Add python.exe to PATH".
    echo Python was not found. >> "%LOG_FILE%"
    echo.
    pause
    exit /b 1
)

echo Python command: %PY_CMD% >> "%LOG_FILE%"
%PY_CMD% --version >> "%LOG_FILE%" 2>&1

%PY_CMD% -c "import importlib.util, sys; mods=['pdfplumber','pandas','openpyxl','rapidocr_onnxruntime','pypdfium2','PIL','numpy']; missing=[m for m in mods if importlib.util.find_spec(m) is None]; print('Missing dependencies: ' + (', '.join(missing) if missing else 'none')); sys.exit(1 if missing else 0)" >> "%LOG_FILE%" 2>&1
if errorlevel 1 (
    echo Missing dependencies. Please run this file first:
    echo install_dependencies.bat
    echo.
    echo Details were saved to run_log.txt.
    echo Please send run_log.txt back if it still cannot run.
    echo.
    pause
    exit /b 1
)

if not exist "%~dp0extract_invoices.py" (
    echo extract_invoices.py was not found.
    echo extract_invoices.py was not found. >> "%LOG_FILE%"
    echo Please make sure all update files were copied into the tool folder.
    echo.
    pause
    exit /b 1
)

echo Running extract_invoices.py... >> "%LOG_FILE%"
%PY_CMD% extract_invoices.py >> "%LOG_FILE%" 2>&1
set RUN_EXIT=%ERRORLEVEL%

type "%LOG_FILE%"

if not "%RUN_EXIT%"=="0" (
    echo.
    echo The program stopped with an error. Details were saved to run_log.txt.
    echo Please send run_log.txt back for checking.
    echo.
    pause
    exit /b %RUN_EXIT%
)

echo.
pause

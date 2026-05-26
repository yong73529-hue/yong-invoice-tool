@echo off
cd /d "%~dp0"
chcp 65001 >nul
set PYTHONUTF8=1
set PYTHONIOENCODING=utf-8

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
    echo.
    pause
    exit /b 1
)

%PY_CMD% -c "import pdfplumber, pandas, openpyxl, rapidocr_onnxruntime, pypdfium2, PIL" >nul 2>nul
if errorlevel 1 (
    echo Missing dependencies. Please run this command first:
    echo install_dependencies.bat
    echo.
    pause
    exit /b 1
)

%PY_CMD% extract_invoices.py

echo.
pause

@echo off
cd /d "%~dp0"
chcp 65001 >nul
set PYTHONUTF8=1
set PYTHONIOENCODING=utf-8
set LOG_FILE=%~dp0install_ocr_log.txt

echo Installing OCR dependencies... > "%LOG_FILE%"
echo Run time: %DATE% %TIME% >> "%LOG_FILE%"
echo Work folder: %CD% >> "%LOG_FILE%"
echo. >> "%LOG_FILE%"

echo Installing OCR dependencies...
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
    echo Please install Python 3.11 or newer and select "Add python.exe to PATH".
    echo Python was not found. >> "%LOG_FILE%"
    echo.
    pause
    exit /b 1
)

echo Python command: %PY_CMD% >> "%LOG_FILE%"
%PY_CMD% --version >> "%LOG_FILE%" 2>&1

%PY_CMD% -m pip install --upgrade pip >> "%LOG_FILE%" 2>&1
%PY_CMD% -m pip install rapidocr_onnxruntime pypdfium2 Pillow numpy >> "%LOG_FILE%" 2>&1
set INSTALL_EXIT=%ERRORLEVEL%

%PY_CMD% -c "import rapidocr_onnxruntime, pypdfium2, PIL, numpy; print('OCR dependencies are ready.')" >> "%LOG_FILE%" 2>&1
if errorlevel 1 set INSTALL_EXIT=1

type "%LOG_FILE%"

if not "%INSTALL_EXIT%"=="0" (
    echo.
    echo OCR dependency installation failed. Details were saved to install_ocr_log.txt.
    echo Please send install_ocr_log.txt back for checking.
    echo.
    pause
    exit /b %INSTALL_EXIT%
)

echo.
echo OCR dependency installation finished. Please run run.bat again.
pause

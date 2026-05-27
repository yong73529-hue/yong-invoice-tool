@echo off
cd /d "%~dp0"
chcp 65001 >nul
set LOG_FILE=%~dp0install_windows_runtime_log.txt
set VC_URL=https://aka.ms/vc14/vc_redist.x64.exe
set VC_EXE=%TEMP%\vc_redist.x64.exe

echo Installing Microsoft Visual C++ Runtime... > "%LOG_FILE%"
echo Run time: %DATE% %TIME% >> "%LOG_FILE%"
echo Download URL: %VC_URL% >> "%LOG_FILE%"
echo. >> "%LOG_FILE%"

echo Installing Microsoft Visual C++ Runtime...
echo This may show a Windows permission prompt. Please click Yes.
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri '%VC_URL%' -OutFile '%VC_EXE%'" >> "%LOG_FILE%" 2>&1
if errorlevel 1 (
    echo Download failed. Details were saved to install_windows_runtime_log.txt.
    echo Please download manually: %VC_URL%
    echo.
    pause
    exit /b 1
)

"%VC_EXE%" /install /passive /norestart >> "%LOG_FILE%" 2>&1
set INSTALL_EXIT=%ERRORLEVEL%

type "%LOG_FILE%"

if "%INSTALL_EXIT%"=="0" goto success
if "%INSTALL_EXIT%"=="3010" goto success

echo.
echo Microsoft Visual C++ Runtime installation may have failed.
echo Details were saved to install_windows_runtime_log.txt.
echo Please send install_windows_runtime_log.txt back for checking.
echo.
pause
exit /b %INSTALL_EXIT%

:success
echo.
echo Microsoft Visual C++ Runtime installation finished.
echo Please run install_ocr_dependencies.bat again, then run run.bat.
pause

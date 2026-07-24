@echo off
title Python for R Users - JSM 2026 Workshop
setlocal
cd /d "%~dp0"

echo.
echo ============================================================
echo   Python for R Users  -  JSM 2026 Workshop
echo ============================================================
echo.
echo This window will set up everything you need and then start
echo JupyterLab in your web browser.
echo.
echo The FIRST time you run this, it downloads Python and the
echo course packages (a few hundred MB). That can take 5-10
echo minutes. Please leave this window open and be patient.
echo Running it again later starts in just a few seconds.
echo.

REM Make sure uv's install folder is visible to this window.
set "PATH=%USERPROFILE%\.local\bin;%PATH%"

where uv >nul 2>nul
if %errorlevel%==0 goto have_uv

echo [1/3] Installing uv (this also installs Python for you)...
echo.
powershell -ExecutionPolicy Bypass -NoProfile -Command "irm https://astral.sh/uv/install.ps1 | iex"

REM uv was just installed - make it visible without restarting.
set "PATH=%USERPROFILE%\.local\bin;%PATH%"

where uv >nul 2>nul
if %errorlevel%==0 goto have_uv
goto failed_uv

:have_uv
echo.
echo [2/3] Installing the course packages...
echo.
uv sync
if errorlevel 1 goto failed_sync

echo.
echo [3/3] Starting JupyterLab...
echo.
echo JupyterLab will open in your web browser in a moment.
echo.
echo   *** KEEP THIS WINDOW OPEN while you are working. ***
echo.
echo When you are finished, close the browser tab and then
echo close this window.
echo.
uv run jupyter lab

echo.
echo JupyterLab has stopped. You can close this window now.
pause
exit /b 0

:failed_uv
echo.
echo ------------------------------------------------------------
echo  Sorry - uv could not be installed automatically.
echo ------------------------------------------------------------
goto help_and_exit

:failed_sync
echo.
echo ------------------------------------------------------------
echo  Sorry - the package installation step did not finish.
echo ------------------------------------------------------------
goto help_and_exit

:help_and_exit
echo.
echo  Please email Ethan.Meyers@gmail.com and include a photo or
echo  screenshot of this window so I can help you fix it.
echo.
echo  You can also use Google Colab instead - it needs no setup.
echo  See the workshop website for the Colab links.
echo.
pause
exit /b 1

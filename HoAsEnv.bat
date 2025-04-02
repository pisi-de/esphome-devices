echo ===%~f0===
title HoAsEnv launcher

cd /D %~dp0

set "PATH=%PATH%;c:\Program Files\Git\mingw64\bin\"
set "PATH=%PATH%;c:\Program Files\Git\bin\"


if not exist HoAsEnv\ (
    python -m venv HoAsEnv 
)

call HoAsEnv\Scripts\activate.bat

REM auto-upgrade
python.exe -m pip install --upgrade pip
python.exe -m pip install --upgrade esphome

REM display versions
python --version
pip --version
esphome version

start cmd.exe /K "title HoAsEnv"

REM stay open for inspection  - in case of errors
echo Press any key to close the launcher window ...
pause

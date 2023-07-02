@echo off

REM Check if the number of arguments is correct
if "%~2"=="" (
  echo Usage: %0 [input_file] [output_file]
  exit /b 1
)

set input_file=%~1
set output_file=%~2

REM Remove output file if it already exists
if exist "%output_file%" (
  del "%output_file%"
)

REM Regular expression pattern
set pattern=[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]-[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]-[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]

REM Extract keys from input file using findstr and regex
findstr /r "%pattern%" "%input_file%" >> "%output_file%"

REM Check if keys were found or not
if %errorlevel% equ 0 (
  echo No keys found in %input_file%.
) else (
  REM Count the number of keys
  set /a key_count=0
  for /f %%A in ('type "%output_file%" ^| find /c /v ""') do set /a key_count=%%A

  echo Extraction complete. %key_count% key(s) have been extracted to %CD%\%output_file%.
)

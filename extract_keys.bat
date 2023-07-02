@echo off

if "%~1"=="" (
  echo Usage: %0 input_file1 [input_file2 ...]
  exit /b 1
)

set "output_file=extracted_keys.txt"

rem Remove output file if it already exists
if exist "%output_file%" (
  del "%output_file%"
)

rem Regular expression pattern
set "pattern=[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]-[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]-[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]"

set /a count=0

rem Loop through each input file
for %%I in (%*) do (
  rem Extract matching rows from current input file using findstr and regex
  findstr /r /c:"%pattern%" "%%I" >> "%output_file%"

  rem Count the number of matches in current input file
  for /f %%C in ('type "%%I" ^| findstr /r /c:"%pattern%" /c:".*" /n ^| find /c ":"') do set /a match_count=%%C
  set /a count+=match_count
)

echo Extraction complete. Keys from selected files have been added to %cd%\%output_file%.
echo Total extracted keys: %count%

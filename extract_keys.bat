@echo off

setlocal enabledelayedexpansion

set "extract_game_name=false"
set "output_file=extracted_keys.txt"
set "key_pattern=[A-Z0-9][A-Z0-9]*-[A-Z0-9][A-Z0-9]*-[A-Z0-9][A-Z0-9]*"
set "game_name_pattern=Товар Корзина #[0-9][0-9]* (.*) \|"

REM Function to print the script usage
:print_usage
echo Usage: %~nx0 [options] <input_file1> [<input_file2> ...]
echo Options:
echo   -n, --game-name    Extract and append the game name to the key
goto :eof

REM Process command line arguments
set "args=%*"
:parse_args
for /f "tokens=1,*" %%i in ("%args%") do (
    set "arg=%%i"
    set "value=%%j"
    if "!arg!" == "-n" (
        set "extract_game_name=true"
    ) else if "!arg!" == "--game-name" (
        set "extract_game_name=true"
    ) else if "!arg!" == "-h" (
        call :print_usage
        exit /b 0
    ) else (
        goto :break_parse_args
    )
    set "args=!value!"
)
:break_parse_args

REM Check if at least one input file is provided
if "%args%" == "" (
    call :print_usage
    exit /b 1
)

REM Remove output file if it already exists
if exist "%output_file%" (
    del "%output_file%"
)

set "count=0"

REM Loop through each input file
for %%f in (%args%) do (
    REM Read the contents of the current input file
    for /f "usebackq delims=" %%l in ("%%~f") do (
        REM Extract the key using regex
        for /f "tokens=1 delims=:" %%k in ('echo %%l ^| findstr /r "%key_pattern%"') do (
            set "key=%%k"
        )

        REM Extract the game name using regex if the flag is set
        if "!extract_game_name!" == "true" (
            for /f "tokens=1 delims=:" %%g in ('echo %%l ^| findstr /r "%game_name_pattern%"') do (
                set "game_name=%%g"
            )
        )

        REM If both key and game name are extracted (or only key if the flag is not set), write them to the output file
        if defined key (
            if "!extract_game_name!" == "true" (
                echo !key! !game_name!>>"%output_file%"
            ) else (
                echo !key!>>"%output_file%"
            )
            set /a count+=1
            set "key="
            set "game_name="
        )
    )
)

echo Extraction complete. Keys
if "!extract_game_name!" == "true" (
    echo and game names
)
echo from selected files have been added to %cd%\%output_file%.
echo Total extracted keys: %count%

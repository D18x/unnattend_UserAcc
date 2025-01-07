@echo off
setlocal enabledelayedexpansion

:: Input files
set "template=template.xml"
set "csv=data.csv"
set "outputDir=output"

:: Create output directory if it doesn't exist
if not exist "%outputDir%" mkdir "%outputDir%"

:: Read the CSV file line by line
for /f "skip=1 tokens=1-3 delims=;" %%A in ('type "%csv%"') do (
    set "SN=%%A"
    set "KD=%%B"
    set "NAME=%%C"

    :: Create a new XML file for this entry
    set "newXml=%outputDir%\!SN!.xml"
    copy "%template%" "!newXml!" >nul

    :: Replace %KD% and %NAME% in the new XML file
    powershell -Command "(gc '!newXml!') -replace '%%KD%%', '!KD!' -replace '%%NAME%%', '!NAME!' | sc '!newXml!'"
)

echo All XML files have been generated in the '%outputDir%' directory.
pause

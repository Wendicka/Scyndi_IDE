@echo off
echo off
rem Make script for Windows

set BLITZDIR=S:\dev_tools\BlitzMax\Vanilla\Windows
set SCYNDIDIR=S:\Projects\Applications\Go\src\Scyndi

echo Compiling IDE
%BLITZDIR%\bin\bmk makeapp -r -t gui -o bin/Scyndi_IDE -a src/Scyndi_IDE
echo Compiling Scorpion
%SCYNDIDIR%\makeme

rem echo Combining IDE with Scorpion
rem #cp $SCYNDIDIR/bin/scorpion bin/Scyndi_IDE.app/Contents/Resources
rem mv bin/scorpion bin/Scyndi_IDE.app/Contents/Resources

echo Done

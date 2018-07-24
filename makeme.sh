# Make script for MacOS X

BLITZDIR=/Volumes/Scyndi/dev_tools/BlitzMax/Vanilla/Mac
SCYNDIDIR=/Volumes/Scyndi/Projects/Applications/Go/src/Scyndi

echo Compiling IDE
$BLITZDIR/bin/bmk makeapp -r -t gui -o bin/Scyndi_IDE -a src/Scyndi_IDE
echo Compiling Scorpion
$SCYNDIDIR/makeme.sh

echo Combining IDE with Scorpion
#cp $SCYNDIDIR/bin/scorpion bin/Scyndi_IDE.app/Contents/Resources
mv bin/scorpion bin/Scyndi_IDE.app/Contents/Resources

echo "Done"

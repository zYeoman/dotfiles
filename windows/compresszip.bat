@echo off
setlocal
mkdir out
for %%i in (*.rar *.zip) do (
    REM unzip the file with password argv[1]
    7z e "%%i" -o"tmp" -p%1
    echo unzip %%i
    if %%~zi gtr 10240000 (
        caesiumclt.exe -q 50 -R tmp/ -o output/
        7z a "out/%%~ni.zip" "%cd%/output/*.*"
        rm -r output
    ) else (
        7z a "out/%%~ni.zip" "%cd%/tmp/*.*"
    )
    echo update %%i
    rm -r tmp
    echo rm tmp and output
)

nircmd speak text 'OK!'

@echo off
setlocal enabledelayedexpansion

set "OLD_URL=https://raw.githubusercontent.com/AuroraLegacy/elements/master/"
set "NEW_URL=https://raw.githubusercontent.com/HarmSolong/elements/personal-library/"

set /a CHANGED=0
set /a UNCHANGED=0

for %%F in (*.xml) do (
    set "TEMPFILE=%%F.tmp"
    copy /y "%%F" "!TEMPFILE!" >nul

    powershell -NoProfile -Command ^
      "$p = '%%F'; $t = Get-Content -Raw -Encoding UTF8 $p;" ^
      "$t = $t.Replace('%OLD_URL%', '%NEW_URL%');" ^
      "$t = $t.Replace('<file name=\"fighter-arcane archer.xml\"', '<file name=\"fighter-arcane-archer.xml\"');" ^
      "$t = $t.Replace('<file name=\"background-familiar friend.xml\"', '<file name=\"background-familiar-friend.xml\"');" ^
      "[System.IO.File]::WriteAllText((Resolve-Path $p), $t, [System.Text.UTF8Encoding]::new($false))"

    fc /b "%%F" "!TEMPFILE!" >nul 2>&1
    if errorlevel 1 (
        set /a CHANGED+=1
        echo Geaendert: %%F
    ) else (
        set /a UNCHANGED+=1
        echo Keine Aenderung: %%F
    )

    del "!TEMPFILE!" >nul 2>&1
)

echo.
echo Fertig: %CHANGED% geaendert, %UNCHANGED% unveraendert.
pause
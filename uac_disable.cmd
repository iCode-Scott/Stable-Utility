@echo off
setlocal
color 0f
:ask_for_create_system_restore_point
cls
echo Let create system restore point(Used to undo all changes and restore if device brick)
echo.
echo.
echo.
set /p choice=Type "Y" to continue or "N" to cancel and press Enter: 

if /i "%choice%" == "Y" (
    cls
    echo Create system restore point, please wait...
    wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Stable Utility", 100, 7 > nul 2>&1
    cls
    echo System restore point created successfully.
    timeout /t 5 /nobreak > nul
) else (
    cls
    echo System restore point creation cancelled.
    timeout /t 5 /nobreak > nul
)
goto menu

:menu
cls
echo Script to perform various system tasks for Windows 10 Stable version.
echo Here is Task list:
echo.
echo.
echo 1 - Debloat services
echo 2 - Enable low latency mode
echo 3 - Run advanced temporary cleanup
echo 4 - Delete empty folder
echo 5 - Disabled memory compression
echo 6 - Do all task
echo.
echo.
echo.

set /p choice=Type the number of the task you want to perform and press Enter: 

if "%choice%" == "1" (
    call :debloat_services
    goto :menu
)

if "%choice%" == "2" (
    call :enable_low_latency_mode
    goto :menu
)

if "%choice%" == "3" (
    call :run_advanced_temporary_cleanup
    goto :menu
)

if "%choice%" == "4" (
    call :delete_empty_folder
    goto :menu
)

if "%choice%" == "5" (
    call :disabled_memory_compression
    goto :menu
)
if "%choice%" == "6" (
    call :do_all_task
    goto :menu
)

:debloat_services
cls
echo Debloat services
echo.
echo.
echo.

set /p choice=Type "Y" to continue or "N" to cancel and press Enter: 
if /i "%choice%" == "Y" (
    cls
    echo Debloat services, please wait...
    net stop "BITS" > nul 2>&1
    sc config "BITS" start=disabled > nul 2>&1
    net stop "SysMain" > nul 2>&1
    sc config "SysMain" start=disabled > nul 2>&1
    net stop "Schedule" > nul 2>&1
    sc config "Schedule" start=disabled > nul 2>&1
    net stop "TimeBrokerSvc" > nul 2>&1
    sc config "TimeBrokerSvc" start=disabled > nul 2>&1 
    reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v "Ctfmon" /t REG_SZ /d "C:\Windows\System32\ctfmon.exe"
    net stop "Themes" > nul 2>&1
    sc config "Themes" start=disabled > nul 2>&1
    net stop "WSearch" > nul 2>&1
    sc config "WSearch" start=disabled > nul 2>&1
    cls
    echo Debloat services successfully.
    timeout /t 5 /nobreak > nul
) else (
    cls
    echo Debloat services cancelled.
    timeout /t 5 /nobreak > nul
)
goto menu

:enable_low_latency_mode
cls
echo Enable low latency mode
echo.
echo.
echo.

set /p choice=Type "Y" to continue or "N" to cancel and press Enter: 
if /i "%choice%" == "Y" (
    cls
    echo Enable low latency mode, please wait...
    bcdedit /deletevalue useplatformclock > nul 2>&1
    bcdedit /set disabledynamictick yes > nul 2>&1
    cls
    echo Enable low latency mode successfully.
    timeout /t 5 /nobreak > nul
) else (
    cls
    echo Enable low latency mode cancelled.
    timeout /t 5 /nobreak > nul
)
goto menu

:run_advanced_temporary_cleanup
cls
echo Run advanced temporary cleanup
echo.
echo.
echo.

set /p choice=Type "Y" to continue or "N" to cancel and press Enter: 
if /i "%choice%" == "Y" (
    cls
    echo Run advanced temporary cleanup, please wait...
    takeown /f %windir%\System32\mcupdate_genuineintel.dll /r /d y > nul 2>&1
    takeown /f %windir%\System32\mcupdate authenticamd.dll /r /d y > nul 2>&1
    icacls %windir%\System32\mcupdate_genuineintel.dll /grant administrators:F /t > nul 2>&1
    icacls %windir%\System32\mcupdate authenticamd.dll /grant administrators:F /t > nul 2>&1
    del /F /S /Q %windir%\System32\mcupdate_genuineintel.dll
    del /F /S /Q %windir%\System32\mcupdate authenticamd.dll
    del /F /S /Q %temp% > nul 2>&1
    del /F /S /Q %windir%\Temp > nul 2>&1
    del /F /S /Q %windir%\Prefetch > nul 2>&1
    del /F /S /Q %windir%\SoftwareDistribution\Download > nul 2>&1
    del /F /S /Q %windir%\SoftwareDistribution\SLS > nul 2>&1
    del /F /S /Q "" > nul 2>&1
    start %windir%\System32\cleanmgr.exe /AUTOCLEAN > nul 2>&1
    cls
    echo Run advanced temporary cleanup successfully.
    timeout /t 5 /nobreak > nul
) else (
    cls
    echo Run advanced temporary cleanup cancelled.
    timeout /t 5 /nobreak > nul
)
goto menu

:delete_empty_folder
cls
echo Delete empty folder
echo.
echo.
echo.

set /p choice=Type "Y" to continue or "N" to cancel and press Enter: 
if /i "%choice%" == "Y" (
    cls
    echo Delete empty folder, pleas wait...
    set "rootFolder=C:"
    for /f "delims=" %%d in ('dir /ad/b/s "%rootFolder%" ^| sort /r') do (
        rd "%%d" 2>nul "%%d"
    )
    cls
    echo Delete empty folder successfully.
    timeout /t 5 /nobreak > nul
) else (
    cls
    echo Delete empty folder cancelled.
    timeout /t 5 /nobreak > nul
)
goto menu

:disabled_memory_compression
cls
echo Disabled memory compression
echo.
echo.
echo.

set /p choice=Type "Y" to continue or "N" to cancel and press Enter:
if /i "%choice%" == "Y" (
    cls
    echo
    Disabled memory compression, please wait...
    powershell Disable-MMAgent -mc > nul 2>&1
    cls
    echo Disabled memory compression successfully.
    timeout /t 5 /nobreak > nul
) else (
    cls
    echo Disabled memory compression cancelled.
    timeout /t 5 /nobreak > nul
)
goto menu

:do_all_task
cls
echo Do all task
echo.
echo.
echo.

set /p choice=Type "Y" to continue or "N" to cancel and press Enter: 
if /i "%choice%" == "Y" (
    cls
    echo Do all task, please wait...
    net stop "BITS" > nul 2>&1
    sc config "BITS" start=disabled > nul 2>&1
    net stop "SysMain" > nul 2>&1
    sc config "SysMain" start=disabled > nul 2>&1
    net stop "Schedule" > nul 2>&1
    sc config "Schedule" start=disabled > nul 2>&1
    net stop "TimeBrokerSvc" > nul 2>&1
    sc config "TimeBrokerSvc" start=disabled > nul 2>&1
    reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v "Ctfmon" /t REG_SZ /d "C:\Windows\System32\ctfmon.exe" 
    net stop "Themes" > nul 2>&1
    sc config "Themes" start=disabled > nul 2>&1
    net stop "WSearch" > nul 2>&1
    sc config "WSearch" start=disabled > nul 2>&1
    echo Debloat services successfully.
    bcdedit /deletevalue useplatformclock > nul 2>&1
    bcdedit /set disabledynamictick yes > nul 2>&1
    echo Enable low latency mode successfully.
    del /F /S /Q %temp% > nul 2>&1
    del /F /S /Q "C:\Windows\Temp" > nul 2>&1
    del /F /S /Q "C:\Windows\Prefetch" > nul 2>&1
    del /F /S /Q "C:\Windows\SoftwareDistribution\Download" > nul 2>&1
    del /F /S /Q "C:\Windows\SoftwareDistribution\SLS" > nul 2>&1
    del /F /S /Q "" > nul 2>&1
    start %windir%cleanmgr.exe /AUTOCLEAN > nul 2>&1
    echo Run advanced temporary cleanup successfully.
    set "rootFolder=C:"
    for /f "delims=" %%d in ('dir /ad/b/s "%rootFolder%" ^| sort /r') do (
        rd "%%d" 2>nul "%%d"
    )
    echo Delete empty folder successfully.
    powershell Disable-MMAgent -mc > nul 2>&1
    echo Disabled memory compression successfully.
    cls
    echo Debloat services successfully.
    echo Enable low latency mode successfully.
    echo Run advanced temporary cleanup successfully.
    echo Delete empty folder successfully.
    echo Disabled memory compression successfully.
    timeout /t 5 /nobreak > nul
) else (
    cls
    echo Do all task cancelled.
    timeout /t 5 /nobreak > nul
)
goto menu
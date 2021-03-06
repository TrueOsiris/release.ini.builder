rem @if (@X)==(@Y) @end /* Harmless hybrid line that begins a JScript comment
rem <Release.ini-Builder by Tim Chaubet - Last updated on 2014-10-31>
@echo off
setlocal enableextensions enabledelayedexpansion
:start
set thisversion=1.0.4
set versionupdated=2015-10-21
set addedrepos=0
set LOOKUP=0123456789abcdef 
set dec=0123456789
set testdecimal=-1
set result=
set replaced=
set logfile="%~dp0\Release.ini.builder.log"
set dts=
set _last=
call :setdts
echo. >>%logfile% 2>&1
echo ############################################################### >>%logfile% 2>&1
echo !dts! Log entry started. >>%logfile% 2>&1
	
rem colors init
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)
rem Prepare a file "X" with only one dot
call :setdts
echo !dts! Creating temporary file for color call. >>%logfile% 2>&1
<nul > X set /p ".=." 

cls
call :Questions
goto End
exit /b

:setdts
for /f "tokens=1,2,3,4,5 usebackq delims=:/ " %%a in ('%date% %time%') do set dts=%%a.%%bh%%cm%%ds%%e
exit /b

:Questions     
echo  ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo  º   Release.ini-Builder by Tim Chaubet                              º
echo  ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹ 
echo  º     1.  morswa703.agfahealthcare.com                              º
echo  º     2.  bessu-hcisdemo                                            º
echo  º     3.  smlsw05.be.local                                          º
echo  º     4.  orbis-repos.agfa.be (DMO omgevingen)                      º
echo  º     5.  gneswv003.agfahealthcare.com\data362                      º
echo  º     6.  1 to 5                                                    º
echo  º     7.  trrswv013.agfahealthcare.com\data84                       º
echo  º     8.  vieswhv30.agfahealthcare.com\data410                      º
echo  º     9.  rotswv102.agfahealthcare.com\data131                      º
echo  º     0.  bodswv067.agfahealthcare.com\data161                      º
echo  º     A.  agfahealthcare.com\dfs\data\emea\DECH\TRR\TestAutomation  º
echo  º     B.  bnjswv023.agfahealthcare.com                              º
echo  º     C.  morsuv007.agfa.be                                         º
rem echo  º     C.  qstorage.be.local                                         º
echo  º                                                                   º
echo  º     W.  Scattered repositories, without an Orbis folder (slow)    º
echo  º     X.  All fixed repositories above                              º
echo  º     Y.  All of the Above, including scattered repositories        º
echo  º     Z.  Exit                                                      º
echo  ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
echo.
chcp 850 >nul
CHOICE /C 1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ /N /T 60 /D C /M "Choose server(s):"
if errorlevel 36 goto menuZ
if errorlevel 35 goto menuY 
if errorlevel 34 goto menuX
if errorlevel 33 goto menuW
if errorlevel 14 goto menuD
if errorlevel 13 goto menuC
if errorlevel 12 goto menuB
if errorlevel 11 goto menuA
if errorlevel 10 goto menu0
if errorlevel 9 goto menu9
if errorlevel 8 goto menu8
if errorlevel 7 goto menu7
if errorlevel 6 goto menu6
if errorlevel 5 goto menu5
if errorlevel 4 goto menu4
if errorlevel 3 goto menu3 
if errorlevel 2 goto menu2
if errorlevel 1 goto menu1
exit /b

:createfile
 SET batchdir=%~dp0
 call :setdts
 echo !dts! Setting directory to %batchdir%. >>%logfile% 2>NUL
 cd "%batchdir%" >>%logfile% 2>NUL
 set r="%batchdir%release.ini"
 for /f "tokens=1,2,3 usebackq delims=:/ " %%a in ('%date% %time%') do set dt=%%a.%%bh%%c
 set rback=%batchdir%backups\release.backup.%dt%.ini
 call :setdts
 echo !dts! moving %r% to %rback%. >>%logfile% 2>NUL
 move "%r%" "%rback%" >>%logfile% 2>NUL
 echo ; Generated by Release.ini-Builder %thisversion% by AXLBO > %r%
 echo ;  >> %r%
exit /b

:restartRmgr
 echo.
 echo.
 call :setdts
 echo !dts! Unmapping O: and Z: drive. >>%logfile% 2>NUL
 net use o: /delete /y >>%logfile% 2>NUL
 net use z: /delete /y >>%logfile% 2>NUL
 call :color 07 "Restarting ReleaseManager"
 echo.
 call :setdts
 echo !dts! Killing Releasemanager.exe task. >>%logfile% 2>NUL
 taskkill /im rmanager.exe >>%logfile%
 start taskkill /im rmanager.exe
 taskkill /im RManager.exe
 call :setdts
 echo !dts! Starting Releasemanager.exe task. >>%logfile% 2>NUL
 ReleaseManager.exe >>%logfile% 2>NUL
exit /b

:menu1
 call :createfile
 call :header
 call :NormalRepos \\morswa703.agfahealthcare.com\Repositorys\ 2>NUL
 
 call :restartRmgr
exit /b

:menu2
 call :createfile
 call :header
 call :NormalRepos \\bessu-hcisdemo\ 2>NUL
 call :restartRmgr
exit /b

:menu3
 call :createfile
 call :header
rem call :NormalRepos \\smlsw05.be.local\orbis_sync\ 2>NUL 
rem call :NormalRepos \\smlsw05.be.local\orbis_sync\CPOEREPO\ 2>NUL
 call :restartRmgr
exit /b

:menu4
 call :createfile
 call :header
 call :NormalRepos \\orbis-repos.agfa.be\public\ 2>NUL 
 call :restartRmgr
exit /b

:menu5
 call :createfile
 call :header
 call :NormalRepos \\GNESWV003.agfahealthcare.com\data362\Repositorys\ 2>NUL
 call :restartRmgr
exit /b

:menu6
 call :createfile
 call :header
 call :NormalRepos \\morswa703.agfahealthcare.com\Repositorys\ 2>NUL
  call :NormalRepos \\bessu-hcisdemo\ 2>NUL
 rem call :NormalRepos \\smlsw02.be.local\ 2>NUL
 rem call :NormalRepos \\smlsw05.be.local\orbis_sync\ 2>NUL 
 rem call :NormalRepos \\smlsw05.be.local\orbis_sync\CPOEREPO\ 2>NUL
 call :NormalRepos \\orbis-repos.agfa.be\public\ 2>NUL 
 call :NormalRepos \\GNESWV003.agfahealthcare.com\data362\Repositorys\ 2>NUL
 rem call :NormalRepos \\trrswb004.agfahealthcare.com\Repositorys\ 2>NUL
 call :restartRmgr
exit /b

:menu7
 call :createfile
 call :header
 call :NormalRepos \\trrswv013.agfahealthcare.com\data84\Repositorys\ 2>NUL
 call :restartRmgr
exit /b

:menu8
 call :createfile
 call :header
 call :NormalRepos \\vieswhv30.agfahealthcare.com\data410\Repositorys\ 2>NUL
 call :restartRmgr
exit /b

:menu9
 call :createfile
 call :header
 call :NormalRepos \\rotswv102.agfahealthcare.com\data131\Repositorys\ 2>NUL
 call :restartRmgr
exit /b

:menu0
 call :createfile
 call :header
 call :NormalRepos \\bodswv067.agfahealthcare.com\data161\Repositorys\ 2>NUL
 call :restartRmgr
exit /b

:menuA
 call :createfile
 call :header
 call :NormalRepos \\agfahealthcare.com\dfs\data\emea\DECH\TRR\TestAutomation\Repository\ 2>NUL
 call :restartRmgr
exit /b

:menuB
 call :createfile
 call :header
 call :NormalRepos \\bnjswv023.agfahealthcare.com\Datenbanken\Repository\ 2>NUL
 call :restartRmgr
exit /b

:menuC
 call :createfile
 call :header
 call :NormalRepos \\morsuv007.agfa.be\ 2>NUL
 call :restartRmgr
exit /b

:menuD
 call :createfile
 call :header
 call :NormalRepos \\10.234.40.26 2>NUL
 call :restartRmgr
exit /b

:menuW
 call :createfile
 call :NoOrbisFolder \\trrswe013.agfahealthcare.com\data315 2>NUL
 call :restartRmgr
exit /b

:menuX
 call :createfile
 call :header
 call :NormalRepos \\morswa703.agfahealthcare.com\Repositorys\ 2>NUL
 call :NormalRepos \\smlsw02.be.local\ 2>NUL
 call :NormalRepos \\smlsw05.be.local\orbis_sync\ 2>NUL 
 call :NormalRepos \\smlsw05.be.local\orbis_sync\CPOEREPO\ 2>NUL 
 call :NormalRepos \\orbis-repos.agfa.be\public\ 2>NUL 
 call :NormalRepos \\GNESWV003.agfahealthcare.com\data362\Repositorys\ 2>NUL
 call :NormalRepos \\trrswb004.agfahealthcare.com\Repositorys\ 2>NUL
 call :NormalRepos \\trrswv013.agfahealthcare.com\data84\Repositorys\ 2>NUL
 call :NormalRepos \\vieswhv30.agfahealthcare.com\data410\Repositorys\ 2>NUL
 call :NormalRepos \\rotswv102.agfahealthcare.com\data131\Repositorys\ 2>NUL
 call :NormalRepos \\bodswv067.agfahealthcare.com\data161\Repositorys\ 2>NUL
 call :NormalRepos \\agfahealthcare.com\dfs\data\emea\DECH\TRR\TestAutomation\Repository\ 2>NUL
 call :NormalRepos \\bnjswv023.agfahealthcare.com\Datenbanken\Repository\ 2>NUL
 call :restartRmgr
exit /b

:menuY
set /a servers= "\\morswa703.agfahealthcare.com\Repositorys\ \\smlsw02.be.local\ \\smlsw05.be.local\orbis_sync\ \\smlsw05.be.local\orbis_sync\CPOEREPO\ \\orbis-repos.agfa.be\public\ \\bnjswv023.agfahealthcare.com\Datenbanken\Repository\ \\GNESWV003.agfahealthcare.com\data362\Repositorys\ \\trrswb004.agfahealthcare.com\Repositorys\ \\trrswv013.agfahealthcare.com\data84\Repositorys\ \\vieswhv30.agfahealthcare.com\data410\Repositorys\ \\rotswv102.agfahealthcare.com\data131\Repositorys\ \\bodswv067.agfahealthcare.com\data161\Repositorys\ \\agfahealthcare.com\dfs\data\emea\DECH\TRR\TestAutomation\Repository\"
 call :createfile
 call :header
 call :NormalRepos \\morswa703.agfahealthcare.com\Repositorys\ 2>NUL
 call :NormalRepos \\smlsw02.be.local\ 2>NUL
 call :NormalRepos \\smlsw05.be.local\orbis_sync\ 2>NUL 
 call :NormalRepos \\smlsw05.be.local\orbis_sync\CPOEREPO\ 2>NUL 
 call :NormalRepos \\orbis-repos.agfa.be\public\ 2>NUL 
 call :NormalRepos \\GNESWV003.agfahealthcare.com\data362\Repositorys\ 2>NUL
 call :NormalRepos \\trrswb004.agfahealthcare.com\Repositorys\ 2>NUL
 call :NormalRepos \\trrswv013.agfahealthcare.com\data84\Repositorys\ 2>NUL
 call :NormalRepos \\vieswhv30.agfahealthcare.com\data410\Repositorys\ 2>NUL
 call :NormalRepos \\rotswv102.agfahealthcare.com\data131\Repositorys\ 2>NUL
 call :NormalRepos \\bodswv067.agfahealthcare.com\data161\Repositorys\ 2>NUL
 call :NormalRepos \\agfahealthcare.com\dfs\data\emea\DECH\TRR\TestAutomation\Repository\ 2>NUL
 call :NormalRepos \\bnjswv023.agfahealthcare.com\Datenbanken\Repository\ 2>NUL
 call :NoOrbisFolder \\trrswe013.agfahealthcare.com\data315 2>NUL 
 call :restartRmgr
exit /b

:menuZ
goto :TrueEnd

:header
 call :setdts
 echo !dts! Output header to screen. >>%logfile% 2>NUL
 rem echo.
 rem call :color 08 "##################################################################"
 rem echo.
 call :color 08 "##### "
 call :color 07 "Checking Orbis repositories containing an Orbis folder "
 rem call :color 08 "##### "
 rem call :color 08 "##################################################################"
 rem echo.
exit /b


:NormalRepos 
	call :setdts
	echo !dts! NormalRepos called for %1. >>%logfile% 2>NUL
	set /a ii=0
	for %%j in (%1%) do (
		call :setdts
		echo !dts! j %%j >>%logfile% 2>NUL
		echo.
		echo.
		call :color 08 "##### "
		call :color 06 "Checking " 
		set Q=%%j
		call :color 07 !Q:\= !
		set /a ii = !ii! + 1
		echo ; Repository !ii! : %%j >> %r%
		call :setdts
		echo !dts! ; Repository !ii! : %%j >> %logfile% 2>NUL
		echo ; >> %r%
		set /a aa = 0
		for /d %%a in (%%j*) do (
			call :setdts
			echo !dts! calling d-- CheckOrbisSubfolder %%a !aa! >>%logfile% 2>NUL
			call :CheckOrbisSubfolder %%a !aa!
		)
		for /F %%c in ('net view %%j') do (
			call :setdts
			echo !dts! calling F-- CheckOrbisSubfolder %%a !aa! >>%logfile% 2>NUL
			call :CheckOrbisSubfolder %%j%%c
		)
		echo ;  >> %r%
	)
exit /b

:NoOrbisFolder
	rem for /r %1 %%C in (.) do (
	echo.
	call :setdts
	echo !dts! NoOrbisFolder called for %1. >>%logfile% 2>NUL
	call :color 08 "##################################################################"
	echo.
	call :color 08 "##### "
	call :color 07 "Checking Orbis repositories without an Orbis folder    "   
	call :color 08 "##### "
	echo.
	call :color 08 "##### "
	call :color 07 "This is an exhaustive process that will take ages      "   
	call :color 08 "##### "
	echo.
	call :color 08 "##### "
	call :color 07 "release.ini has already been created so this section   "   
	call :color 08 "##### "
	echo.
	call :color 08 "##### "
	call :color 07 "can be cancelled.                                      "   
	call :color 08 "##### "
	echo.
	call :color 08 "##### "
	call :color 07 "Interrupt anytime with Ctrl-C                          "                 
	call :color 08 "##### "
	echo.
	call :color 08 "##################################################################"
	echo.
	for /r %1 %%C in (.) do (
		set T=%%~nxC
		set S=%%C
		echo !T!|findstr /r "[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\_[0-9][0-9][0-9][0-9][0-9][0-9][0-9]" >nul 2>&1
		if not errorlevel 1 (
			call :Addrepo !S:~0,-2!
		)
		
	)
exit /b
	
:CheckOrbisSubfolder
	if exist "%1\orbis" (
		call :setdts
		echo !dts! Orbis folder found in %1. >>%logfile% 2>NUL
		call :Addrepo %1 %2
	)
exit /b

:last_folder
	set _test=%1
	set _last=%_test%
	for /F "tokens=1* delims=\" %%A IN (%_test%) DO (
		if not "%%B" == "" (
			call :last_folder "%%B"
		)
	)
exit /b

:Addrepo
	set lf=%1
	if %lf:~-1,1% == \ ( set lf=%lf:~0,-1% )
	call :setdts
	echo !dts! Addrepo started for %1 >>%logfile% 2>NUL
	call :last_folder "%lf%"
	set fol=!_last:"=!
	call :setdts 
	echo !dts! %fol% >>%logfile% 2>NUL
	set /a addedrepos = !addedrepos! + 1
	call :setdts
	echo !dts! Adding repo !addedrepos! %fol% mappings to release.ini. >>%logfile% 2>NUL
	call :hex !addedrepos!
	call :color 08 "Map "
	call :color !result! !addedrepos!
	call :color 08 ":"
	call :repl "%fol%"
	if not "%fol%" == "!v!" (
		call :color 08 " "
		call :color 07 "%fol%"
		call :color 08 " to"
	)
	call :color 07 " !v!"
	call :setdts
	echo !dts! adding [!v! on %1] to %r% >>%logfile% 2>NUL
	echo [!v! on %1] >> %r%
	echo Z=%1 >> %r% 
	echo O=%1 >> %r%
exit /b

:repl
	rem http://www.dostips.com/forum/viewtopic.php?f=3&t=6044
	rem http://www.dostips.com/DtTipsStringManipulation.php
	set v=%1
	set v=%v:"=%
	set v=%v:OrbisRepos=%
	set v=%v:Repository=%
	set v=%v:orbis=%
	set v=%v:Orbis=%
	set v=%v:Repo=%
	set v=%v:repo=%
	set v=%v:8331=08.03.03.01_%
	set v=%v:8332=08.03.03.02_%
	set v=%v:8332=08.03.03.02_%
	set v=%v:833_2=08.03.03.02_%
	set v=%v:8422=08.04.22_%
	set v=%v:8423=08.04.23_%
	set v=%v:8424=08.04.24_%
	set v=%v:8425=08.04.25_%
	set v=%v:8426=08.04.26_%
	set v=%v:8427=08.04.27_%
	set v=%v:84_=08.04_%
	set v=%v:_84=_08.04%
	set v=%v:0803=08.03.%
	set v=%v:0804=08.04.%
	set v=%v:0805=08.05.%
	set v=%v:su00=SU00_%
	set v=%v:su01=SU01_%
	set v=%v:su02=SU02_%
	set v=%v:su03=SU03_%
	set v=%v:su04=SU04_%
	set v=%v:su05=SU05_%
	set v=%v:855-=08.05.05_%
	set v=%v:855=08.05.05_%
	set v=%v:856-=08.05.06_%
	set v=%v:856=08.05.06_%
	set v=%v:857=08.05.07_%
	set v=%v:858=08.05.08_%
	set v=%v:DEV-=DEV%
	set v=%v:DEV=DEV_%
	set v=%v:_84_DEV=DEV_08.04_%
	set v=%v:08.04.230=08.04.23.0%
	set v=%v:08.04.240=08.04.24.0%
	set v=%v:08.04.250=08.04.25.0%
	set v=%v:08.04.260=08.04.26.0%
	set v=%v:08.04.270=08.04.27.0%
	set v=%v:08.05.050=08.05.05.0%
	set v=%v:08.05.060=08.05.06.0%
	set v=%v:08.05.070=08.05.07.0%
	set v=%v:08.05.080=08.05.08.0%
	if "%v:~0,2%" == "20" (
		call :testdec %v:~2,6%
		if "!testdecimal!"=="1" (
			set "v=%v:~8%_%v:~0,8%"
		)
	)
	set v=%v:__=_%
	if "%v:~0,1%" == "-" (set v=%v:~1%)
	if "%v:~0,1%" == "_" (set v=%v:~1%)
	if "%v:~-1,1%" == "_" (set v=%v:~0,-1%)
	set v=%v:-=_%
	set v=%v:83=08.03%
	set v=%v:85=08.05%
	set v=%v:08.04.2319=08.04.23.19%
exit /b

:testdec
	set testdecimal=1
	set "totest=%1"
	set pos=0
	set "haystack=!dec!"
	:testsingle
	if not "!totest:~%pos%,1!"=="" (
		set "needle=!totest:~%pos%,1!"
		call set "test=%%haystack:%needle%=%%"
		if x%test%==x%haystack% set testdecimal=0
		set /A pos+=1
		goto :testsingle
	)
exit /b

:color
	set "param=^%~2" !
	set "param=!param:"=\"!"
	findstr /p /A:%1 "." "!param!\..\X" nul
	<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
exit /b

:hex
	set HEXSTR=
	set PREFIX=
	if "%1"=="" (
		echo 0
		exit /b
	)
	set /a D=%* || exit /b 1
	if !D! LSS 0 (
		set /a D=0xfffffff + !D! + 1 
		set PREFIX=f
	)
	call :loophex !D!
	echo.
	set "H=!HEXSTR!"
	call :strlen %H% L
	if "!L!"=="1" (
		set HEXSTR=0!HEXSTR!
	)
	set result=!PREFIX!!HEXSTR!
exit /b

:loophex
	set /a E=%1 %% 16 
	set /a D=%1 / 16"
	set HEXSTR=!LOOKUP:~%E%,1!%HEXSTR%
	if %D% GTR 0 call :loophex %D%
exit /b

:strlen
	set len=0
	set "param=%1"
	:strLen_Loop
	if not "!param:~%len%,1!"=="" (
		set /A len+=1
		goto :strLen_Loop
	)
	set "%2=%len%"
exit /b

:End
 echo.
 call :setdts
 echo !dts! Script finished. >>%logfile% 2>NUL
 echo Finished Release.ini-Builder %thisversion% - Last updated on %versionupdated%
 call :setdts
 echo !dts! Removing temporary files. >>%logfile% 2>NUL
 del X 2>NUL 
 ping -n 4 -w 10000 127.0.0.1 > nul
 call :setdts
 echo !dts! Closing. >>%logfile% 2>NUL
 rem call :start
 endlocal
goto:EOF

:TrueEnd

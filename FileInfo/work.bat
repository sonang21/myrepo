@echo off
setlocal

set logfile=wrk_%date:~0,4%%date:~5,2%%date:~8,2%.log
set errfile=wrk_%date:~0,4%%date:~5,2%%date:~8,2%.err
set workbase=.
set fileList=%1

echo %date% %time% > %logfile%
echo %date% %time% > %errfile%

for /F "eol=# tokens=1,2 delims=>" %%i in (%fileList%) do (
 echo. %%i
 rem if not exist %%j (
 rem   echo.   mkdir %%j and xcopying
 rem   mkdir %%j
 rem )
 echo del "%%i" 1>>  %logfile%  2>>  %errfile%
 del "%%i" 1>>  %logfile%  2>>  %errfile%
)

endlocal
rem pause                                    
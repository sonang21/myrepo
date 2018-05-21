@rem cmd.exe /V:ON

@echo off

set class_path=.\bin
FOR %%i IN ( .\lib\hive\*.jar ) DO (
  set class_path=!class_path!;%%i
)
FOR %%i IN ( .\lib\mysql\*.jar ) DO (
  set class_path=!class_path!;%%i
)
echo %class_path%

rem #############################################################
FOR /F %%i in ('dir /s/b src\com\cslee\utils\*.java') do (
  C:\App\Java\jdk1.6.0_45\bin\javac -cp %class_path% -d bin %%i
)

FOR /F %%i in ('dir /s/b src\com\cslee\db\*.java') do (
  C:\App\Java\jdk1.6.0_45\bin\javac -cp %class_path% -d bin %%i
)

FOR /F %%i in ('dir /s/b src\com\cslee\dqm\*.java') do (
  C:\App\Java\jdk1.6.0_45\bin\javac -cp %class_path% -d bin %%i
)

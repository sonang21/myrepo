@rem cmd.exe /V:ON

@echo off

set class_path=.\bin\csleedq15.jar

FOR %%i IN ( .\lib\hive\*.jar ) DO (
  set class_path=!class_path!;%%i
)
FOR %%i IN ( .\lib\mysql\*.jar ) DO (
  set class_path=!class_path!;%%i
)
echo %class_path%
C:\App\Java\jdk1.6.0_45\bin\javac -cp %class_path% -d bin src\dqm\*.java

echo "runing ..." %1 %2 %3 %4 %5 %6 %7 %8 %9
rem echo C:\App\Java\jdk1.6.0_45\bin\java -cp %class_path% %1 %2 %3 %4

REM C:\App\Java\jdk1.7.0_67\bin\java -cp %class_path% dqm.DBConfig %1
rem C:\App\Java\jdk1.7.0_67\bin\java -cp %class_path% dqm.DQMain D
rem java -verbose:gc ....
C:\App\Java\jdk1.6.0_45\bin\java -Xmx512m -XX:PermSize=256m -XX:MaxPermSize=256m -XX:NewSize=128m -cp %class_path% %1 %2 %3 %4 %5 %6 %7 %8 %9
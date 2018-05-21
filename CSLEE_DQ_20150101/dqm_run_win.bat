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

rem C:\App\Java\jdk1.6.0_45\bin\javac -cp %class_path% -d bin src\dqm\*.java

echo "runing ..." %1 %2 %3 %4 %5 %6 %7 %8 %9
rem echo C:\App\Java\jdk1.6.0_45\bin\java -cp %class_path% %1 %2 %3 %4

REM C:\App\Java\jdk1.7.0_67\bin\java -cp %class_path% dqm.DBConfig %1
rem C:\App\Java\jdk1.7.0_67\bin\java -cp %class_path% dqm.DQMain D
rem java -verbose:gc ....

set class_path=.\bin;.\lib\hive\commons-logging-1.0.4.jar;.\lib\hive\commons-logging-api-1.0.4.jar;.\lib\hive\core-3.1.1.jar;.\lib\hive\guava-11.0.2.jar;.\lib\hive\hadoop-core-1.2.1.jar;.\lib\hive\hive-jdbc-0.11.0-nr1012.jar;.\lib\hive\hive-jdbc-handler-0.11.0-nr1012.jar;.\lib\hive\hive-metastore-0.11.0-nr1012.jar;.\lib\hive\hive-service-0.11.0-nr1012.jar;.\lib\hive\libfb303-0.9.0.jar;.\lib\hive\libthrift-0.9.0.jar;.\lib\hive\log4j-1.2.16.jar;.\lib\hive\slf4j-api-1.4.3.jar;.\lib\hive\slf4j-log4j12-1.4.3.jar;.\lib\mysql\mysql-connector-java.jar


C:\App\Java\jdk1.6.0_45\bin\java -Xmx512m -XX:PermSize=256m -XX:MaxPermSize=256m -XX:NewSize=128m -cp %class_path% %1 %2 %3 %4 %5 %6 %7 %8 %9
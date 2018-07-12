@ECHO OFF
call migenv.bat

%JAVA_HOME%\BIN\javac -cp %CLASSPATH%  src\*.java -d bin

REM pause
@echo off 
REM @SET JAVAC=D:\DISKs\Java\Files\jdk1.6.0_18\bin\javac
SET JAVAC=%JAVA_HOME%\bin\javac -Xlint

%JAVAC% -cp bin src\DerbyInf.java -d bin
%JAVAC% -cp bin src\FileInfo.java -d bin
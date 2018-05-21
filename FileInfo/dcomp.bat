@echo off
rem set CLASSPATH=Derby\lib\derby.jar
rem set PATH=Derby\bin;%PATH%
rem %1=tableName, %2=scan Directory

set CLASSPATH=bin

jre6\bin\java -cp Derby\lib\derby.jar;.\bin FileInfo scan %1 src force
jre6\bin\java -cp Derby\lib\derby.jar;.\bin FileInfo scan %2 bak force
jre6\bin\java -cp Derby\lib\derby.jar;.\bin FileInfo comp src bak

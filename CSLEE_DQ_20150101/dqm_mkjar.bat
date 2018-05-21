
SET JAVA_HOME=C:\App\Java\jdk1.6.0_45

CD bin

rem %JAVA_HOME%\bin\jar cvmf manifest.txt csleedq15.jar com

del csleedq15.jar

%JAVA_HOME%\bin\jar -cvf csleedq15.jar com

pause
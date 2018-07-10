@ECHO OFF
call javaenv.bat

echo param : %1 %2 %3 %4 %5 %6

@REM %JAVA_HOME%\BIN\java -Xms64m -Xmx128m -cp .;%JDBC% %1 %2 %3 %4 %5 %6

%JAVA_HOME%\BIN\java -cp %CLASSPATH% %1 %2 %3 %4 %5 %6

@ECHO OFF
call migenv.bat
echo -------------------------------------------------------------------------
echo param : %1 %2 %3 %4 %5 %6

@REM %JAVA_HOME%\BIN\java -Xms64m -Xmx128m -cp .;%JDBC% %1 %2 %3 %4 %5 %6

%JAVA_HOME%\BIN\java -Xms32m -Xmx1024m -cp %CLASSPATH% MigTable %1 %2

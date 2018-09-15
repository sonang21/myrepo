@ECHO OFF
SET JAVA_HOME="C:\App\Java\jdk-10.0.1"
SET CLASSPATH=../libs/jdbc/mssql/mssql-jdbc-6.4.0.jre9.jar
SET CLASSPATH=%CLASSPATH%;../libs/jdbc/oracle/ojdbc6.jar
SET CLASSPATH=%CLASSPATH%;../libs/excel-poi/poi-3.17/lib/commons-collections4-4.1.jar
SET CLASSPATH=%CLASSPATH%;../libs/excel-poi/poi-3.17/poi-3.17.jar
SET CLASSPATH=%CLASSPATH%;../libs/excel-poi/poi-3.17/poi-ooxml-3.17.jar
SET CLASSPATH=%CLASSPATH%;../libs/excel-poi/poi-3.17/poi-ooxml-schemas-3.17.jar
SET CLASSPATH=%CLASSPATH%;../libs/excel-poi/poi-3.17/ooxml-lib/xmlbeans-2.6.0.jar

SET CLASSPATH=.;bin;%CLASSPATH%;

%JAVA_HOME%\BIN\java -Xms32m -Xmx1024m -cp %CLASSPATH% bts.app.MainApp
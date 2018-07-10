@ECHO OFF

SET JAVA_HOME="C:\App\Java\jdk-10.0.1"
SET JDBC=../libs/jdbc/mssql/mssql-jdbc-6.4.0.jre9.jar;../libs/jdbc/oracle/ojdbc6.jar
SET CLASSPATH=.;bin;%JDBC%
@echo off
copy E:\03.Data\Eclipse\Files\*                 .
xcopy /cherkydi E:\03.Data\Eclipse\Files\src\*    src
xcopy /cherkydi E:\03.Data\Eclipse\Files\bin\*    bin

 xcopy /cherkydi E:\03.Data\Eclipse\Files\Derby\bin\*    Derby\bin
 xcopy /cherkydi E:\03.Data\Eclipse\Files\Derby\lib\*    Derby\lib
 xcopy /cherkydi E:\03.Data\Eclipse\Files\jdk1.6.0_18\bin\* jdk1.6.0_18\bin
  REM xcopy /cherkydi E:\03.Data\Eclipse\Files\jdk1.6.0_18\jre\* jdk1.6.0_18\jre
 xcopy /cherkydi E:\03.Data\Eclipse\Files\jdk1.6.0_18\lib\* jdk1.6.0_18\lib


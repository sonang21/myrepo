@echo off
rem usage do_all.bat [target_name]
rem call setEnv.bat

for /F %%f in (xml/list.txt) do (
  java -cp bin bmt_data.DataGen %%f insert %1
) 

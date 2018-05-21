#!/bin/sh

DQ_HOME=/home/dqms/app/dqms
CLASSPATH=./bin

for i in `find ${DQ_HOME}/lib -name "*.jar"`
do
    CLASSPATH=$CLASSPATH:$i
done

# echo $CLASSPATH
cd ${DQ_HOME}

rm -rf /home/dqm/app/dqms/bin/*

for i in `find ${DQ_HOME}/src -type d`
do
     javac -cp $CLASSPATH -d bin $i/*.java
done

cd $DQ_HOME/bin; jar -cvf csleedq15.jar com



#!/bin/bash

DQ_HOME=/home/dqm/app/dqms
# CLASSPATH=./bin
CLASSPATH=./bin/csleedq15.jar

for i in `find ${DQ_HOME}/lib -name "*.jar"`
do
    CLASSPATH=$CLASSPATH:$i
done

# echo $CLASSPATH
cd ${DQ_HOME}

## rm -rf /home/dqm/app/dqms/bin/*
## for i in `find ${DQ_HOME}/src -type d`
## do
##     javac -cp $CLASSPATH -d bin $i/*.java
## done
## cd $DQ_HOME/bin; jar -cvf csleedq15.jar net
## javac -cp $CLASSPATH -d bin src/dqm/*.java

java -Xmx256m -cp $CLASSPATH com.cslee.dqm.DQMain $1 $2 $3 $4 $5 $6 $7 $8 


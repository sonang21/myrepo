WORK_DIR=$(dirname $0)
WORK_DATE=$(date +%Y%m%d_%H%M)

cd $WORK_DIR

CLASSPATH=.:lib/mssql-jdbc-6.2.2.jre7.jar:lib/ojdbc6.jar
BACKROOT=backRoot
BACKARCH=backArch


#java -cp $CLASSPATH DBSourceSave $BACKROOT 1> log/$WORK_DATE.log 2>&1
java -cp $CLASSPATH DBObjectBackup $BACKROOT 1> log/$WORK_DATE.log 2>&1


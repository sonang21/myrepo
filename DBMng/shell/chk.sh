logfile=$(ls -tr log/*.log | tail -n -1)
if [ $1 != "" ]; then
  logfile=$1
fi

echo "## check last log : $logfile "
echo "---------------------------------------------------"

grep -i "ora-" $logfile | grep -v backRoot
grep -i "exception" $logfile  | grep -v backRoot
grep -i "error" $logfile | grep -v backRoot

echo "---------------------------------------------------"
echo "... check end."

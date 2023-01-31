#!/bin/bash
# Destription: test cpu usage 
# Example    : sh cpu_usage.sh consume 8 | sh cpu_usage.sh release
 
FILE_NAME=`basename $0`
cpunum=$2
pid_array=()
function usage()
{
echo "Usage:$FILE_NAME consume cpu_number|release -----the value of cpu_number is an integer,such as 1,2,3"
echo "Example: $FILE_NAME consume 12"
echo "         $FILE_NAME release"
}
 
function endless_loop()
{
echo -ne "i=0;
while true
do
    i=i+100;
    i=100
done" | /bin/bash &
}
 
 
function consume()
{
for i in `seq $1`
do
    endless_loop
    pid_array[$i]=$!
done
echo "consume cpu resources process ids are: ${pid_array[*]}"
}
 
function release()
{
for pid in $(ps -ef |grep /bin/bash |grep -v grep |awk '{print $2}' |xargs)
do
    kill -9 $pid
done
}
 
function main()
{
case "$1" in
    consume) consume $cpunum;;
    release) release;;
          *) usage;exit 1;;
esac
}
 
main $*

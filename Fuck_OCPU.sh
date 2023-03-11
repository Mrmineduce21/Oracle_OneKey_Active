#! /bin/bash



utilization=14


endless_loop()
{
echo -ne "i=0;
while true
do
i=i+100;
i=100
done" | /bin/bash &
}

if [ $# != 1 ] ; then
  echo "USAGE: $0 <CPUs>"
  exit 1;
fi
for i in `seq $1`
do
  endless_loop
  pid_array[$i]=$! ;
done

for i in "${pid_array[@]}"; do
    echo 'stopUsage: kill ' $i ';'
    nohup cpulimit -p "$i" -l "$utilization" &
done

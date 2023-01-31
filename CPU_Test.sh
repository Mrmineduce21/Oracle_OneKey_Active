#!/bin/bash



#=======================  日  志  ===================#


if [ -f /root/Oracle_OneKey_Active.log ]; then
 echo "log file found..."

  else
  echo "no such file!-"
  touch /root/Oracle_OneKey_Active.log
fi
time=$(date -d today +"%Y-%m-%d %T")
echo "===================" >> /root/Oracle_OneKey_Active.log
echo "$time Start" >> /root/Oracle_OneKey_Active.log


#=======================  保  留  文  件  ===================#

 echo "清空上次残留"
 rm -rf /root/anti-recycling

if [ ! -d "/anti-recycling" ]; then
  mkdir anti-recycling
  echo "文件夹不存在-已创建"
fi

for loop in 1 2
do
sleep 2
    echo "第$loop个1GB文件"
    wget -P /root/anti-recycling  http://wa-us-ping.vultr.com/vultr.com.1000MB.bin
   echo "下载完成"
   sleep 5
     echo "第$loop个文件下载完成"
     time=$(date -d today +"%Y-%m-%d %T")
     echo "$time Download file$loop Done" >> /root/Oracle_OneKey_Active.log
     
done
 echo "保留文件下载完成"


#=======================  综  合  测  试 ===================#
if [ -f /root/superbench.sh ]; then
 echo "file found...执行测试"
  ./superbench.sh
  else
  echo "no such file!-开始下载"
wget -qO- --no-check-certificate https://raw.githubusercontent.com/oooldking/script/master/superbench.sh | bash
 echo "测试完成"
   echo "superbench删除日志"
  rm /root/superbench.log
       time=$(date -d today +"%Y-%m-%d %T")
     echo "$time superbench Done" >> /root/Oracle_OneKey_Active.log
fi

#=======================  C  P  U  ===================#


for loop2 in 1 2 
do
sleep 5
cd /root && wget -qO cpu_usage.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/cpu_usage.sh && chmod +x cpu_usage.sh && bash cpu_usage.sh consume 1
  sleep 1800
  cd /root && wget -qO cpu_usage.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/cpu_usage.sh && chmod +x cpu_usage.sh && bash cpu_usage.sh release
  sleep 60 
  cd /root && wget -qO cpu_usage.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/cpu_usage.sh && chmod +x cpu_usage.sh && bash cpu_usage.sh consume 1
  sleep 1800
  cd /root && wget -qO cpu_usage.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/cpu_usage.sh && chmod +x cpu_usage.sh && bash cpu_usage.sh release
  sleep 60 
fi
     time=$(date -d today +"%Y-%m-%d %T")
     echo "$time cpu_usage $loop2 Done" >> /root/Oracle_OneKey_Active.log
     
done








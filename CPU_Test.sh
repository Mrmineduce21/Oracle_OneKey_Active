#!/bin/bash


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
     echo "第$loop个文件下载完成"    
done
 echo "保留文件下载完成"


#=======================  综  合  测  试 ===================#
if [ -f /root/superbench.sh ]; then
 echo "file found...执行测试"
  ./superbench.sh
  else
  echo "no such file!-开始下载"
wget -qO- --no-check-certificate https://raw.githubusercontent.com/oooldking/script/master/superbench.sh | bash
   echo "删除日志"
  rm /root/superbench.log
fi

#=======================  C  P  U  ===================#
if [ -f /root/unixbench.sh ]; then
 echo "file found...执行测试"
  ./unixbench.sh
  else
  echo "no such file!-开始下载"
 wget --no-check-certificate https://github.com/teddysun/across/raw/master/unixbench.sh && chmod +x unixbench.sh && ./unixbench.sh
 # rm /root/unixbench.sh
fi








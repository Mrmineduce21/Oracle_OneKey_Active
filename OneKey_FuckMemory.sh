#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'
G="G"
cur_dir=$(pwd)


check() {
# check root
[[ $EUID -ne 0 ]] && echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1
# check os
if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo -e "${red}未检测到系统版本，请联系脚本作者！${plain}\n" && exit 1
fi
}



install_base() {
    echo -e "${yellow}install_base${plain} "
    if [[ x"${release}" == x"centos" ]]; then
        yum install epel-release -y
        yum install wget socat -y
    else
    apt-get install wget socat -y
    fi
}


Fuck_Memory() {
freeMem=$(free -t | awk 'NR ==2 {print $4/1024/1024/10}') && full=$((${freeMem//.*/+1})) 
   fullG=${full}$G
   echo -e "${green}当前获取到的可用内存为_${freeMem}GB ${plain}"
  
   echo -e "${green}预计填充的内存为_ ${fullG} ${plain}"
  
   echo -e "${green}===============================${plain} "
   echo -e "${yellow}  脚本将自动获取系统可用内存的10%（不满1G按1G算） 并消耗掉这部分内存 ${plain} "
   echo -e "${red}  警告：Amd服务器（内存小于2G）请勿使用此脚本，对此照成的封号，机器失联，卡死等问题作者概不负责 ${plain} "
   echo -e "${red}  输入数字14运行即表示同意 ${plain} "
   read -p "请输入: " -t 30 rules

if (( $rules == 14 )); then
    echo -e "${green}  开始运行 ${plain} "
    else
  echo -e "${red}不同意别用！${plain}\n" && exit 1
fi

#运行部分
if [ -f /root/memory_usage.sh ]; then
 echo "file found...开始执行 吃掉内存"
  bash memory_usage.sh ${full}G
  else
  echo "no such file!-开始下载"
cd /root && wget -qO memory_usage.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/memory_usage.sh && chmod +x memory_usage.sh && bash memory_usage.sh consume ${fullG}
fi

}






echo -e "${green}开始运行${plain}"
check
install_base
Fuck_Memory

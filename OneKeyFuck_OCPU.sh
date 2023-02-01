#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

cur_dir=$(pwd)

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

#main

Fuck_OCPU() {
echo -e "${yellow}请输入CPU核心数量【可选1-4  Oracle amd机型为2核心】${plain} "
read -p "请输入: " -t 30 NO_Cores
if [[ ! -z "${NO_Cores}" ]]; then
Cores="${NO_Cores}"
fi
  echo -e "${green} ${Cores}Cores${plain} "
  echo -e "${green}==========================${plain} "
if [ -f /root/Fuck_OCPU.sh ]; then
 echo "file found...开始执行 吃掉CPU"
  bash Fuck_OCPU.sh ${Cores}
  else

  echo "no such file!-开始下载"
cd /root && wget -qO Fuck_OCPU.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/Fuck_OCPU.sh && chmod +X Fuck_OCPU.sh && bash Fuck_OCPU.sh ${Cores}
  
fi




}

install_base() {
    echo -e "${yellow}install_base${plain} "
    if [[ x"${release}" == x"centos" ]]; then
        yum install epel-release -y
        yum install cpulimit wget socat -y
    else
    apt-get install cpulimit wget socat -y
    fi
}


echo -e "${green}开始运行${plain}"
install_base
Fuck_OCPU




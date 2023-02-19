#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

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

#main

    name() {
echo -e "${yellow}请输入想要改的名字${plain} "
read -p "请输入: " -t 30 Nd_Names
if [[ ! -z "${Nd_Names}" ]]; then
name="${Nd_Names}"
 
echo "[global]" >> /etc/netdata/netdata.conf  
echo "hostname = ${name}" >> /etc/netdata/netdata.conf 
echo "[registry]" >> /etc/netdata/netdata.conf 
echo "registry hostname = ${name}" >> /etc/netdata/netdata.conf 




fi
}


install_base() {
    echo -e "${yellow}install_base_系统为${release}${plain} "
    
    if [[ x"${release}" == x"centos" ]]; then
        yum install epel-release -y
        yum install cpulimit wget socat vim -y
        wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && sh /tmp/netdata-kickstart.sh --claim-token QFqOaICdWhRDzFYrn0CVgkfC9j7VKSQlTes15pF6lzVxNKSTFWX46IGQ3OsnKglXlfzSDkv2YIKprMtavKKY4CCW0lyycTc14nti7Yf79LC7zI9_uA_Y1uBMuXqeHuV-Z-epPt4 --claim-url https://app.netdata.cloud 
    else
    apt-get install cpulimit wget socat vim  -y
    wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && sh /tmp/netdata-kickstart.sh --claim-token QFqOaICdWhRDzFYrn0CVgkfC9j7VKSQlTes15pF6lzVxNKSTFWX46IGQ3OsnKglXlfzSDkv2YIKprMtavKKY4CCW0lyycTc14nti7Yf79LC7zI9_uA_Y1uBMuXqeHuV-Z-epPt4 --claim-url https://app.netdata.cloud 
    fi
}


echo -e "${green}开始运行${plain}"

check

install_base

name
echo -e "${green}改完，重启${plain}"

service netdata restart
echo -e "${green}重启完成${plain}"
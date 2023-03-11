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



install_base() {
    echo -e "${yellow}install_base${plain} "
    if [[ x"${release}" == x"centos" ]]; then
        yum install epel-release -y
        yum install wget socat bc -y
    else
    apt-get install wget socat bc -y
    fi
}


Fuck_Memory() {



# 获取系统内存总量和当前已用内存
total_mem=$(free | awk '/Mem:/ {print $2}')
used_mem=$(free | awk '/Mem:/ {print $3}')

# 计算当前内存占用率，保留小数点后两位
used_percent=$(awk "BEGIN {printf \"%.2f\", $used_mem/$total_mem*100}")

# 判断内存占用率是否小于10%
if [ $(echo "$used_percent < 10" | bc) -eq 1 ]; then
    # 计算内存占用距离15%差多少MB，保留整数位
    mem_diff=$(awk "BEGIN {print int(($total_mem*0.15-$used_mem)/1024)}")
    echo "当前内存占用率为${used_percent}%，距离15%还差${mem_diff}MB"
    FullM="${mem_diff}M"
        if [ -f /root/memory_usage.sh ]; then
             echo "file found...开始执行 吃掉内存"
                cd /root && wget -qO memory_usage.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/memory_usage.sh && chmod +x memory_usage.sh && bash memory_usage.sh consume ${FullM}
        else
                echo "no such file!-开始下载"
                cd /root && wget -qO memory_usage.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/memory_usage.sh && chmod +x memory_usage.sh && bash memory_usage.sh consume ${FullM}
        fi
else
    echo -e "${green}内存占用达到15%${plain}"
    exit 1
fi






}






echo -e "${green}开始运行${plain}"
check
install_base
Fuck_Memory

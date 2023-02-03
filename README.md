# Oracle_OneKey_Active
为了应对甲骨文最新回收机制而作的垃圾脚本


说在前面：
由于甲骨文目前对不活跃机器实行回收，本脚本的作用就是  通过下载文件，上传，cpu跑分让甲骨文以为你是"活跃用户"
脚本仅做辅助，无法保证不被删机

转载请标明原出处

以下三个脚本都是执行后  在后台静默运行，脚本不会开机自启动，请重启后手动运行脚本


----========================   更   新   内   容   ============================----

将FuckNetWork.sh 下载源替换为

```
http://speedtest.fremont.linode.com/100MB-fremont.bin
```

下载间隔修改为2.8小时一次



删除旧版本残留文件

```
sudo rm -f /root/nohup.out && rm -f /root/Oracle_OneKey_Active.log && rm -f /root/anti-recycling/vultr.com.1000MB.bin && rm -f /root/anti-recycling/vultr.com.1000MB.bin.1
```



----============================   C   P   U   ===============================----

OneKeyFuck_OCPU.sh

一键吃掉CPU（可精准控制）【OracleLinux不可用】
```
cd /root && wget -qO OneKeyFuck_OCPU.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/OneKeyFuck_OCPU.sh && chmod +x OneKeyFuck_OCPU.sh && bash OneKeyFuck_OCPU.sh
```

释放CPU资源

```
pid=$(ps -ef | grep "bash" | grep '/bin/bash' | grep -v grep | awk '{print $2}') && kill -9 $pid
```

当ssh终端出现  nohup: appending output to 'nohup.out'  时按回车即可

============================================================

cpu_usage.sh(无法做到精确控制占用)

使用之前使用命令先查询下cpu的个数

cat /proc/cpuinfo | grep “processor”|wc -l

或 grep processor /proc/cpuinfo |wc -l


一键吃掉1核心
```
cd /root && wget -qO cpu_usage.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/cpu_usage.sh && chmod +x cpu_usage.sh && bash cpu_usage.sh consume 1
```

取消CPU消耗
```
cd /root && wget -qO cpu_usage.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/cpu_usage.sh && chmod +x cpu_usage.sh && bash cpu_usage.sh release
```

需要构造消耗2颗cpu的资源运行脚本sh cpu_usage.sh consume 2，此时运行top命令查看cpu的使用率。如果要释放cpu资源
运行sh cpu_usage.sh release即可释放cpu资源。

============================================================

Fuck_OCPU.sh（第一个脚本的手动版本）

运行方法  bash Fuck_OCPU.sh <cores> 

需要自行安装CPUlimit


----===================   M   e   m   o   r  y   =========================----

OneKey_FuckMemory.sh
  脚本将自动获取系统可用内存的10%（不满1G按1G算） 并消耗掉这部分内存
  警告：Amd服务器（内存小于2G）请勿使用此脚本，对此照成的封号，机器失联，卡死等问题作者概不负责
  
  真--一键吃内存
  
  ```
  cd /root && wget -qO OneKey_FuckMemory.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/OneKey_FuckMemory.sh && chmod +x OneKey_FuckMemory.sh && bash OneKey_FuckMemory.sh
  ```
  
  取消内存消耗(释放内存)
```
cd /root && wget -qO memory_usage.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/memory_usage.sh && chmod +x memory_usage.sh && bash memory_usage.sh release
```

============================================================

memory_usage.sh
使用方法： 需要root 权限 启动

bash memory_usage.sh consume 内存大小

eg : bash memory_usage.sh consume 1G 即消耗1G 的内存


一键吃内存（100MB）
```
cd /root && wget -qO memory_usage.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/memory_usage.sh && chmod +x memory_usage.sh && bash memory_usage.sh consume 100M
```


一键吃内存（2G）
```
cd /root && wget -qO memory_usage.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/memory_usage.sh && chmod +x memory_usage.sh && bash memory_usage.sh consume 2G
```

一键吃内存（20G）[适用于24G内存]
```
cd /root && wget -qO memory_usage.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/memory_usage.sh && chmod +x memory_usage.sh && bash memory_usage.sh consume 20G
```

取消内存消耗
```
cd /root && wget -qO memory_usage.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/memory_usage.sh && chmod +x memory_usage.sh && bash memory_usage.sh release
```

----==================   N   E   T   W   O   R   K   =======================----

FuckNetWork.sh

原理：每间隔2.8分钟下载一次大小为100MB的 测速文件（限速8MB/S） 下次下载开始前将会删除上次下载的文件

一键浪费网络
```
cd /root && wget -qO FuckNetWork.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/FuckNetWork.sh && chmod +x FuckNetWork.sh && nohup ./FuckNetWork.sh &
```
停止运行
```
FNpid=$(ps -ef | grep "FuckNetWork.sh" | grep '/bin/bash' | grep -v grep | awk '{print $2}') && kill -9 $FNpid && rm -f /root/nohup.out && rm -f /root/Oracle_OneKey_Active.log
```

建议手动添加定时任务
```
FNpid=$(ps -ef | grep "FuckNetWork.sh" | grep '/bin/bash' | grep -v grep | awk '{print $2}') && kill -9 $FNpid && rm -f /root/nohup.out && rm -f /root/Oracle_OneKey_Active.log && cd /root && wget -qO FuckNetWork.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/FuckNetWork.sh && chmod +x FuckNetWork.sh && nohup ./FuckNetWork.sh &
```


  

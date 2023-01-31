# Oracle_OneKey_Active
为了应对甲骨文最新回收机制而作的垃圾脚本


说在前面：
由于甲骨文目前对不活跃机器实行回收，本脚本的作用就是  通过下载文件，上传，cpu跑分让甲骨文以为你是"活跃用户"
脚本仅做辅助，无法保证不被删机

脚本流程
下载10G文件（保留）----  下载2G文件（下载后删除）----  执行 superbench   ----  执行 unixbench

注意事项：
脚本将会占用13G空间，请确保VPS空间足够
请将脚本置于root目录执行
root目录中/anti-recycling  /OneKey_Active 均为保留文件，请勿删除

可配合宝塔面板，哪吒探针，crontab 等  实现自动运行


使用方法
```
cd /root && wget -qO OneKey_Active.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/OneKey_Active.sh && chmod +x OneKey_Active.sh && bash OneKey_Active.sh
```

有bug自己修，提lssues不回

===============================================================================

memory_usage.sh
使用方法： 需要root 权限 启动
bash memory_usage.sh consume 内存大小
eg : bash memory_usage.sh consume 1G 即消耗1G 的内存
取消内存消耗
bash memory_usage.sh release

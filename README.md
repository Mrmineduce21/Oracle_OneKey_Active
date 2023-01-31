# Oracle_OneKey_Active
为了应对甲骨文最新回收机制而作的垃圾脚本




脚本流程
下载10G文件（保留）----  下载2G文件（下载后删除）----  执行 superbench   ----  执行 unixbench

请将脚本置于root目录执行
root目录中/anti-recycling  /OneKey_Active 均为保留文件，请勿删除

可配合宝塔面板，哪吒探针，crontab 等  实现自动运行


使用方法
```
wget -qO OneKey_Active.sh https://raw.githubusercontent.com/Mrmineduce21/Oracle_OneKey_Active/main/OneKey_Active.sh && chmod +x OneKey_Active.sh && bash OneKey_Active.sh
```

有bug自己修，提lssues不回



#!/bin/bash

# 多关键词检索, 依赖`ack`和`grep`命令.
# 使用方式 ./search.sh rss mac os

# 拼接grep语句
g=""
for i in "${@:2}"; do
    g=$g"| grep -i '$i' "
done

# 拼接ack语句
search="ack --type markdown -i '$1' $g"
echo $search
# 执行
eval $search

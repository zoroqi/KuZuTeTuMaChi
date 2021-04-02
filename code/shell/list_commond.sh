#!/bin/bash

# 列出所有当前用户可能可以使用的使用的命令
# 打印环境变量PATH下的所有东西,可以创建一个别名, 可以结合grep搜索看看本地有没有安装,
path=$PATH
IFS=":"
for i in $path
do
    ls -l $i
done

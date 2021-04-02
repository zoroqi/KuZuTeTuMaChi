#!/bin/bash

# 将指定配置文件中的tree 输出到对应文件. 并提交私有git上
# 针对树莓派上的备份数据进行记录方便检索
# 第一个参数配置文件 第二个参数git目录
# 配置文件格式
#      扫描目录:输出文件
# 可能的问题, 需要使用bash, dash解析会报错
# git push需要密码, 可以调整git为ssh方式或执行`git config --global credential.helper store`
# 不要轻易手工编辑文件
cat $1 |while read line
do
    array=(${line//:/ })
    tree -N -f -h ${array[0]} > ${array[1]}
done

cd $2
git add .
git commit -m 'add'
git pull
git push

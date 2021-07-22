#!/bin/bash
# 搜索最近 $3 次commit, 中指定 $1 文件中的 $2 记录
gitlog=`git rev-list --all | head -$3`
for i in $gitlog
do
    echo `git grep -F $2 $i:$1`
done



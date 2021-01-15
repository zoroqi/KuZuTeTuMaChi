#!/bin/bash

# 老的git停用
mv .git .oldgit

# 初始化
git init

# clone 根据需要可以只clone 一层
for i in `cat config.txt`
do
    repo_name=`echo $i | awk -F '/|\\\\.' '{print $(NF-2)"_"$(NF-1)}'`
    git clone $i $repo_name
done

# 关联项目
for i in `ls -F |grep '/$'`; do cd $i; s=`git r | grep 'fetch' | awk '{print $2}'` ; cd ../ ; git submodule add  $s $i;done

# 提交

git add .

git commit -m 'init'

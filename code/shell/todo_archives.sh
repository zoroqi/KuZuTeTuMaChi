#!/bin/bash
# 20 9 * * 1 /bin/bash shell_path
root_path="todo list path"
yesterday=`date "+%Y-%m-%d"`

cp $root_path"today.todo" $root_path$yesterday.todo

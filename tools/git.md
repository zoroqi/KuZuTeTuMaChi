# git上的特殊命令

* 统计每个人的提交量
```
git log --format='%aN' | sort -u | while read name; do echo -en "$name\t"; git log --author="$name" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc }' -; done
```


* check单个文件

相当方便, 只要代码写的好一点, 功能独立就十分好迁移了.

```
git checkout branch-name path
```

* 查看合并分支的日志

可以在对合并后的分支进行单个分支提交记录查询.

```
# 显示branch1中排除branch2的日志记录
git log branch1 ^branch2
```

* 清理远程已经删除的分支

```
git remote prune origin
```

* 批量修改log日志中的提交人

[执行脚本sh](/code/shell/modify_git_commit_user.sh)

* 查看本地分支最后提交时间

`git branch | sort | while read name; do echo -en "$name\t\t"; git show -q --pretty=format:'%ai %an %s %n' $name ; done | sort -k2r`

有个小bug无法查看当前分支, 尽量在主分支上执行. 暂时没找到branch如何不打印`*`输出方式

* log的格式输出说明

| 参数 | 说明 |
| --- | --- |
| %H | commit hash |
| %h | commit short hash |
| %T | tree hash |
| %t | tree short hash |
| %P | parent hash |
| %p | parent short hash |
| %an | 作者名字 |
| %aN | .mailmap 中对应的作者名字 |
| %ae | 作者邮箱 |
| %aE | .mailmap 中对应的作者邮箱 |
| %ad | –date=制定的日期格式 |
| %aD | RFC2822 日期格式 |
| %ar | 日期格式，例如：1 day ago |
| %at | UNIX timestamp 日期格式 |
| %ai | ISO 8601 日期格式 |
| %cn | 提交者名字 |
| %cN | .mailmap 对应的提交的名字 |
| %ce | 提交者邮箱 |
| %cE | .mailmap 对应的提交者的邮箱 |
| %cd | –data=制定的提交日期的格式 |
| %cD | RFC2822 提交日期的格式 |
| %cr | 提交日期的格式，例如：1day ago |
| %ct | UNIX timestamp 提交日期的格式 |
| %ci | ISO 8601 提交日期的格式 |
| %d | ref 名称 |
| %e | encoding |
| %s | commit 信息标题 |
| %f | 过滤 commit 信息的标题使之可以作为文件名 |
| %b | commit 信息内容 |
| %N | commit notes |
| %gD | reflog selector, e.g., refs/stash@{1} |
| %gd | shortened reflog selector, e.g., stash@{1} |
| %gs | reflog subject |
| %Cred | 切换至红色 |
| %Cgreen | 切换至绿色 |
| %Cblue | 切换至蓝色 |
| %Creset | 重设颜色 |
| %C(color) | 制定颜色，as described in color.branch.\* config option |
| %m | left right or boundary mark |
| %n | 换行 |
| %% | a raw % |
| %x00 | print a byte from a hex code |
| %w(\[ \[, \[, \]\]\]) | switch line wrapping, like the \-w option of git\-shortlog(1). |

* `git bisect` 查找问题修改

git bisect是一个很有用的命令，用来查找哪一次代码提交引入了错误。以二分查找方式来查找那次引入的问题.

假设commitid, 1,2,3,4,5,6,7,8,9,10, HEAD

执行流程
1. `git bisect start HEAD 1`, `git bisect start 起点commit 终点commit`
2. `git bisect good` 5没有问题, 哪问题就出现在5\~HEAD
3. `git bisect bad` 7有问题, 哪问题出现在5\~7
4. 反复执行2\~3直到找到问题
5. `git bisect reset`结束

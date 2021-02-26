# git上的特殊命令

### 统计每个人的提交量
```
git log --format='%aN' | sort -u | while read name; do echo -en "$name\t"; git log --author="$name" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc }' -; done
```


### check单个文件

相当方便, 只要代码写的好一点, 功能独立就十分好迁移了.

```
git checkout branch-name path
```

### 查看合并分支的日志

可以在对合并后的分支进行单个分支提交记录查询.

```
# 显示branch1中排除branch2的日志记录
git log branch1 ^branch2
```

### 清理远程已经删除的分支

```
git remote prune origin
```

### 批量修改log日志中的提交人

[执行脚本sh](/code/shell/modify_git_commit_user.sh)

### 查看本地分支最后提交时间

`git branch | sort | while read name; do echo -en "$name\t\t"; git show -q --pretty=format:'%ai %an %s %n' $name ; done | sort -k2r`

有个小bug无法查看当前分支, 尽量在主分支上执行. 暂时没找到branch如何不打印`*`输出方式

### log的格式输出说明

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

### `git clone --depth=1` 浅克隆, 只克隆最新代码

无法执行push和commit, 但看最新代码和编译是够用了

### `git clone --branch tag` 克隆指定标签代码

### `git bisect` 查找问题修改

git bisect是一个很有用的命令，用来查找哪一次代码提交引入了错误。以二分查找方式来查找那次引入的问题.

假设commitid, 1,2,3,4,5,6,7,8,9,10, HEAD

执行流程
1. `git bisect start HEAD 1`, `git bisect start 起点commit 终点commit`
2. `git bisect good` 5没有问题, 哪问题就出现在5\~HEAD
3. `git bisect bad` 7有问题, 哪问题出现在5\~7
4. 反复执行2\~3直到找到问题
5. `git bisect reset`结束

### `git submodule add path` 子模块

可以将一个仓库加入到另一个仓库中.

### 强制回滚代码 `git reset --hard origin/master`

### 回滚单个文件 `git checkout -- path`

### 查看单文件行的变更记录 `git blame`

### 合并commit `git rebase -i`, 对已经push的代码慎用, 容易玩火自焚.

```
# 合并最近两次
git rebase -i HEAD~2

# 合并指定范围内的提交, 如果不指定[endpoint]默认HEAD. 前开后闭
git rebase -i [startpoint] [endpoint]
```

具体操作
```
git rebase -i HEAD~3

pick 791 cccc
pick 75c bbbb
pick 563 aaaa

# 将后几个pick -> squash

pick 791 cccc
squash 75c bbbb
squash 563 aaaa

保存, 修改commit信息

如果要push可能需要添加f强制推送
```

* pick：保留该commit（缩写:p）
* reword：保留该commit，但我需要修改该commit的注释（缩写:r）
* edit：保留该commit, 但我要停下来修改该提交(不仅仅修改注释)（缩写:e）
* squash：将该commit和前一个commit合并（缩写:s）
* fixup：将该commit和前一个commit合并，但我不要保留该提交的注释信息（缩写:f）
* exec：执行shell命令（缩写:x）
* drop：我要丢弃该commit（缩写:d）

### 全局ignore配置
```
git config --global core.excludesfile ~/my_sh/dotfiles/gitignore
```

### 生成SSH公钥

命令 `ssh-keygen -o`

命令流程
```
ssh-kengen -o

# 输入名称name, 没有默认id_rsa
# 输入密码
# 再次输入密码
```

最终文件会生成两个文件在`~/.ssh`目录中, 分别是 `name`和`name.pub`. `pub`文件就是公钥

* 配置

多个公钥针对不同域名或需要进行指定配置

```
Host domain.one
    HostName domain.one
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rse_one
Host domain.two
    HostName domain.two
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa_two
```

使用`ssh -T git@domain.one`进行测试

使用`user-agent`免密
```
# 启动
eval $(ssh-agent -s)
# 添加
ssh-add ~/.ssh/id_rsa
```

### 清理本地tag

而对于新版本的git，推荐使用`git fetch --prune <remote> "+refs/tags/*:refs/tags/*"`，在fetch的同时，更新远端的tag列表。

添加配置
`git config --local --add remote.origin.fetch "+refs/tags/*:refs/tags/*"`，之后每次`git fetch –prune`，都会更新tag列表


### clone或checkout部分文件

单个项目过大, clone或checkout太浪费时间, 尤其是针对中国用户, 很多文档类项目不需要全部检出, 1.7版本后提供稀疏检出\(sparse checkout\)功能来实现这种操作.

```shell
git init #创建一个git项目
git remote add origin gitpath #添加远程
git config core.sparsecheckout true #设置为稀疏检出模式
echo "path1/" >> .git/info/sparse-checkout #要检出的目录
echo "path2/" >> .git/info/sparse-checkout #要检出的目录
git pull origin master #检出, 一定要使用这种方式, 不能直接pull
```

sparse\-checkout简单规则, 类似ignore规则

子目录的匹配
在 sparse\-checkout 文件中, 如果目录名称前带斜杠，如`/docs/`,将只匹配项目根目录下的docs目录,如果目录名称前不带斜杠,如`docs/`,其他目录下如果也有这个名称的目录,如`test/docs/`也能被匹配。
而如果写了多级目录,如`docs/05/`,则不管前面是否带有斜杠,都只匹配项目根目录下的目录,如`test/docs/05/`不能被匹配.


### 打印本地所有分支最后提交时间

```shell
for k in `git branch | perl -pe s/^..//`; do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k -- | head -n 1`\\t$k; done | sort -r
```

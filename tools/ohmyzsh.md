# ohmyzsh

## 自动提示

[zsh: 20 Completion System](https://zsh.sourceforge.io/Doc/Release/Completion-System.html)

功能: 合并分支, tab 可以提示分支

```sh
# 你的脚本
git_merge_to() {
    git merge $1
}

# 绑定提示关系
compdef _git_merge_to git_merge_to

# 生成扩展命令
_git_merge_to_comp()
{
    local -a git_branches
    git_branches=("${(@f)$(git branch --format='%(refname:short)')}")
    _describe 'command' git_branches
}
```

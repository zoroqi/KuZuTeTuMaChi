# github

## action

`schedule.corn`: 时区默认是0时区, 中国用户需要注意时间`-8`. 在官方文档[schedule](https://help.github.com/en/actions/reference/events-that-trigger-workflows#scheduled-events-schedule)介绍中并没有看见可以修改时区的操作.

## [插件pull](https://wei.github.io/pull/)

很方便的一个插件, 可以快速同步fork的代码, 在学习代码的时候可以方便知道最新的代码. 默认硬同步master分支(现在可能是main分支).

自己修改的东西, 尽量建一个新分支去处理, 不然一个直接就覆盖掉了, 或添加`.github/pull.yml`进行控制.

```yml
version: "1"
rules:                      # Array of rules
  - base: master            # Required. Target branch
    upstream: wei:master    # Required. Must be in the same fork network.
    mergeMethod: hardreset  # Optional, one of [none, merge, squash, rebase, hardreset], Default: none.
    mergeUnstable: false    # Optional, merge pull request even when the mergeable_state is not clean. Default: false
  - base: dev
    upstream: master        # Required. Can be a branch in the same forked repo.
    assignees:              # Optional
      - wei
    reviewers:              # Optional
      - wei
    conflictReviewers:      # Optional, on merge conflict assign a reviewer
      - wei
label: ":arrow_heading_down: pull"  # Optional
```

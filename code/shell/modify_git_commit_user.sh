#!/bin/sh

# 批量修改git提交记录中的user和email.
# 不成功就执行一下内容
# git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch Rakefile' HEAD

git filter-branch --env-filter '

OLD_EMAIL=""
CORRECT_NAME=""
CORRECT_EMAIL=""

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags

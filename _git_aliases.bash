source /usr/local/etc/bash_completion.d/git-completion.bash

function g { if [[ $# > 0 ]]; then git $@; else git status; fi; }
alias gs="git status"
alias gst="git stash"
alias gd="git diff"
alias gdd="git diff --no-ext-diff"
alias gf="git fetch"
alias gr="git rebase"
alias gfr="git fetch && git rebase"
alias gl="git log"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gco="git checkout"
alias gt="git tag"

__git_complete g __git_main
__git_complete gst _git_stash
__git_complete gd _git_diff
__git_complete gf _git_fetch
__git_complete gr _git_rebase
__git_complete gl _git_log
__git_complete ga _git_add
__git_complete gb _git_branch
__git_complete gc _git_commit
__git_complete gco _git_checkout
__git_complete gc _git_tag

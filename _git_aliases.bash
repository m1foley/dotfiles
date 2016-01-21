source /usr/local/etc/bash_completion.d/git-completion.bash

function g { if [[ $# > 0 ]]; then git $@; else git status; fi; }
alias gs="git show"
alias gst="git stash"
alias gd="git diff"
alias gdd="git diff --no-ext-diff"
alias gf="git fetch"
alias gr="git rebase"
alias gri="git rebase -i"
alias gp="git pull --rebase"
alias gl="git log"
alias glp="git log -p"
alias ga="git add"
alias gb="git branch"
alias gc="git commit -v"
alias gco="git checkout"
alias gcom="git checkout master"
alias gt="git tag"
alias g1="git rebase -i HEAD~1"
alias g2="git rebase -i HEAD~2"
alias g3="git rebase -i HEAD~3"
alias g4="git rebase -i HEAD~4"
alias g5="git rebase -i HEAD~5"
alias gcp="git cherry-pick"
function go {
  bare=$(echo $1 | sed 's/origin\///')
  git branch --track $bare $1 && git checkout $bare
}

__git_complete g __git_main
__git_complete gst _git_stash
__git_complete gd _git_diff
__git_complete gf _git_fetch
__git_complete gr _git_rebase
__git_complete gri _git_rebase
__git_complete gl _git_log
__git_complete glp _git_log
__git_complete ga _git_add
__git_complete gb _git_branch
__git_complete gc _git_commit
__git_complete gco _git_checkout
__git_complete gc _git_tag
__git_complete go _git_branch
__git_complete gp _git_pull

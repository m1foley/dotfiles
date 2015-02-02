# Dotfiles

I find my dotfiles useful for my daily workflow. Maybe they'll be useful for you too!

## Instructions

- For underscore files, save to your home directory and change the leading underscore to a dot (`.`).
- To use `git_diff_wrapper`, save to `/usr/local/bin`.

## Files

### .bashrc

Customizes the console prompt and loads the alias files.

### .bash_aliases

Bash shortcuts to save time and to correct typos.

### .git_aliases.bash

git shortcuts and tab completion. Relies on a directory installed via `brew install git`.

### .git_template

Add default behaviors to all new git projects:

- Automatically run `ctags` on changes, per [Tim Pope](http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html).
- Use `pre-commit` to check for common errors while committing.

### .gitconfig

Global git settings. References some other git-related files in this repo.

### .gitignore_global

Global git ignore file.

### .tmux.conf

Tmux preferences.

### .vimrc

Vim preferences.

### git_diff_wrapper

Use `vimdiff` by default when calling `git diff`. Should be copied to `/usr/local/bin`.

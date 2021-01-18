# Dotfiles

I find my dotfiles useful for my daily workflow. Maybe they'll be useful for you too!

## Instructions

To softlink an underscore file:

```sh
ln -s `pwd`/_filename ~/.filename
```

Exception: `git_diff_wrapper` goes to a different directory as noted below.

## Notes

### .git_template

Add default behaviors to all new git projects:

- Automatically run `ctags` on changes, per [Tim Pope](http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html).
- Use `pre-commit` to check for common errors while committing.
- Use `fit-commit` to validate commit messages.

### git_diff_wrapper

Use `vimdiff` by default when calling `git diff`. Linked from `/usr/local/bin` instead of `~`.

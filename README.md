# Dotfiles

Maybe my dotfiles will be useful for you too!

## Instructions

To softlink an underscore file:

```sh
ln -s `pwd`/_filename ~/.filename
```

## Notes

### .git_template

Add default behaviors to all new git projects:

- Automatically run `ctags` on changes, per [Tim Pope](http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html).
- Use `pre-commit` to check for common errors while committing.
- Use `fit-commit` to validate commit messages.

# Git config

## Credentials

```sh
git config --global user.name "Name Surname"
git config --global user.email "name.surname@example.com"
```

## Behaviour

```sh
git config --global init.defaultbranch "main"
git config --global fetch.prune true
git config --global pull.rebase true
git config --global rerere.enabled true
git config --global push.autoSetupRemote true
```

## Tooling

```sh
git config --global core.editor "nvim"
git config --global merge.tool smerge
git config --global diff.tool smerge
git config --global difftool.prompt false
```

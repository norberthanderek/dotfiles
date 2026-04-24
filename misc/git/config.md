# Git config

## Credentials

```sh
git config --global user.name "Name Surname"
git config --global user.email "name.surname@example.com"
```

## Behaviour

```sh
git config --global init.defaultBranch "main"
git config --global fetch.prune true
git config --global pull.rebase true
git config --global rerere.enabled true
git config --global push.autoSetupRemote true
```

## Tooling

```sh
git config --global core.editor "nvim"
git config --global merge.tool smerge
git config --global mergetool.smerge.trustExitCode true
git config --global mergetool.prompt false
git config --global mergetool.keepBackup false
git config --global diff.tool smerge
git config --global difftool.prompt false
```

### Sublime Merge additional steps

#### On MacOS link app to `smerge`

```sh
sudo ln -s "/Applications/Sublime Merge.app/Contents/SharedSupport/bin/smerge" /usr/local/bin/smerge
```

#### On Windows add it's directory to `PATH`

```sh
C:\Program Files\Sublime Merge
```

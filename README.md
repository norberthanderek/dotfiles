# dotfiles

## Prerequisites
### zsh and ghostty 👻 
```sh
brew install zsh ghostty
```

### [oh-my-zsh](https://ohmyz.sh/#install)
``` sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### [p10k](https://github.com/romkatv/powerlevel10k#installation)
```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### zsh plugins
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### [nvim](https://github.com/neovim/neovim/wiki/Building-Neovim)

### [rust](https://www.rust-lang.org/tools/install)

### [node/npm](https://nodejs.org/en/download/package-manager)

### golang

### python3/pip

### NeoVim Dependencies
Unix only
```sh
./nvim/install_dependencies.sh
```

## Download dotfiles and link them
After succesfull setup of all prerequisites, run:
```sh
git clone git@github.com:norberthanderek/dotfiles.git $HOME/.dotfiles --depth 1
cd $HOME/.dotfiles
```

## Link configurations

### Unix
```ps1
# Unix shells
./link.sh
# Powershell (as Administrator)
.\link.ps1
```

## Install VSCode extentions
```ps1
# Unix shells
cat vscode/extensions.txt | xargs -n 1 code --install-extension
# Powershell
Get-Content vscode\extensions.txt | ForEach-Object { code --install-extension $_ }
```

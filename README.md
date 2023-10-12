# dotfiles

## Prerequisites
### zsh and tmux
```sh
sudo apt install zsh tmux
```
### [oh-my-zsh](https://ohmyz.sh/#install)
``` sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
### [p10k](https://github.com/romkatv/powerlevel10k#installation)
```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
### [nvim (BUILD FROM SOURCE!)](https://github.com/neovim/neovim/wiki/Building-Neovim)

## Download dotfiles and link
After succesfull setup of all prerequisites, run:
```sh
git clone https://github.com/norberthanderek/dotfiles.git  ~/.dotfiles --depth 1 --recurse-submodules -j8
cd ~/.dotfiles && ./link.sh
```
# dotfiles

## Prerequisites

### Common
- [neovim](https://neovim.io/doc/install/)
- [rust / rustup](https://rustup.rs/)
- [node / npm](https://nodejs.org/en/download)
- python3 + pip
- tree-sitter cli
  ```sh
  npm install -g tree-sitter-cli
  ```

## Unix

<details>
<summary>Show Unix-specific setup</summary>

#### Shell
```sh
brew install zsh ghostty
```

#### oh-my-zsh
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### powerlevel10k
```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

#### zsh plugins
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

</details>

## Windows

<details>
<summary>Show Windows-specific setup</summary>

#### PowerShell 7
```powershell
winget install --id Microsoft.PowerShell --source winget
```

#### zig
```powershell
winget install -e --id zig.zig
```

#### Windows Terminal font
```json
{
    ...
    "profiles": 
    {
        "defaults": 
        {
            "font": 
            {
                "face": "JetBrainsMono Nerd Font Mono"
            }
        },
        ...
    }
    ...
}
```

</details>

## Shell Local Extensions
Local git-ignored scripts can be placed in `shell/*/extensions/` and are automatically sourced by the respective shell configs.

## Neovim Mason Profiles
Profile configuration lives in [nvim/lua/config/mason_profiles.lua](nvim/lua/config/mason_profiles.lua).  
Local profile selection should be configured in git-ignored [nvim/lua/config/local/mason.lua](nvim/lua/config/local/mason.lua).  
Additional language extensions can also be defined there and installed through `:Mason`.

## Download dotfiles and link them
```sh
git clone git@github.com:norberthanderek/dotfiles.git $HOME/.dotfiles --depth 1
cd $HOME/.dotfiles
```
Then:
```ps1
# Unix shells
./link.sh
# Powershell (as Administrator)
.\link.ps1
```

## Install VSCode extensions
```ps1
# Unix shells
cat vscode/extensions.txt | xargs -n 1 code --install-extension
# Powershell
Get-Content vscode\extensions.txt | ForEach-Object { code --install-extension $_ }
```

#!/bin/zsh
set -e

# Get platform-specific paths
OS_NAME=$(uname)
if [[ "$OS_NAME" == "Darwin" ]]; then
    echo "Running on macOS"
    VS_CODE_CONFIG="$HOME/Library/Application Support/Code/User"
elif [[ "$OS_NAME" == "Linux" ]]; then
    echo "Running on Linux"
    VS_CODE_CONFIG="$HOME/.config/Code/User"
else
    echo "Unknown OS: $OS_NAME"
    exit 1
fi

SCRIPT=$(readlink -f $0)
SCRIPT_DIR=`dirname $SCRIPT`

remove_existing () {
  # If it's a symlink - remove
  if [ -L "$1" ]; then
    rm "$1"
  fi
  # If it's a file or a directory - rename
  if [ -f "$1" ] || [ -d "$1" ]; then
    mv "$1" "$1.old"
  fi
}

# shell
remove_existing ~/.tmux.conf
ln -s "$SCRIPT_DIR/shell/.tmux.conf" ~/.tmux.conf
remove_existing ~/.wezterm.lua
ln -s "$SCRIPT_DIR/shell/.wezterm.lua" ~/.wezterm.lua
remove_existing ~/.zshrc
ln -s "$SCRIPT_DIR/shell/.zshrc" ~/.zshrc

# editors
remove_existing ~/.config/nvim
ln -s "$SCRIPT_DIR/nvim" ~/.config/ # Automatically adds 'nvim'
remove_existing "$VS_CODE_CONFIG/settings.json"
ln -s "$SCRIPT_DIR/vscode/settings.json" "$VS_CODE_CONFIG/settings.json"
remove_existing "$VS_CODE_CONFIG/keybindings.json"
ln -s "$SCRIPT_DIR/vscode/keybindings.json" "$VS_CODE_CONFIG/keybindings.json"

echo "Done"

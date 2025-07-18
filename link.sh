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

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

remove_existing() {
  # If it's a symlink - remove
  if [ -L "$1" ]; then
    rm "$1"
  fi
  # If it's a file or a directory - rename
  if [ -f "$1" ] || [ -d "$1" ]; then
    mv "$1" "$1.old"
  fi
}

create_symlink() {
    local target="$1"
    local link="$2"
    mkdir -p "$(dirname "$link")" && ln -s "$target" "$link"
}

# Terminal
remove_existing ~/.config/ghostty
create_symlink "$SCRIPT_DIR/ghostty" ~/.config/ # Automatically adds 'ghostty' as it's a directory

# Shell
remove_existing ~/.zshrc
create_symlink "$SCRIPT_DIR/shell/zsh/.zshrc" ~/.zshrc

# editors
remove_existing ~/.config/nvim
create_symlink "$SCRIPT_DIR/nvim" ~/.config/ # Automatically adds 'nvim' as it's a directory
remove_existing "$VS_CODE_CONFIG/settings.json"
create_symlink "$SCRIPT_DIR/vscode/settings.json" "$VS_CODE_CONFIG/settings.json"
remove_existing "$VS_CODE_CONFIG/keybindings.json"
create_symlink "$SCRIPT_DIR/vscode/keybindings.json" "$VS_CODE_CONFIG/keybindings.json"

echo "Done"

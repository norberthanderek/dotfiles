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

SCRIPT_DIR="${0:A:h}"

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

relink() {
    remove_existing "$2"
    create_symlink "$1" "$2"
}

# Terminal
relink "$SCRIPT_DIR/ghostty" ~/.config/ghostty

# Shell
relink "$SCRIPT_DIR/shell/zsh/.zshrc" ~/.zshrc

# Linux systemd session environment
SESSION_ENV="$SCRIPT_DIR/shell/zsh/extensions/environment.conf"
if [[ "$OS_NAME" == "Linux" && -f "$SESSION_ENV" ]]; then
    relink "$SESSION_ENV" ~/.config/environment.d/999-dotfiles.conf
fi

# Editors
relink "$SCRIPT_DIR/nvim" ~/.config/nvim
relink "$SCRIPT_DIR/vscode/settings.json" "$VS_CODE_CONFIG/settings.json"
relink "$SCRIPT_DIR/vscode/keybindings.json" "$VS_CODE_CONFIG/keybindings.json"
relink "$SCRIPT_DIR/zed/settings.json" "$HOME/.config/zed/settings.json"
relink "$SCRIPT_DIR/zed/keymap.json" "$HOME/.config/zed/keymap.json"
relink "$SCRIPT_DIR/zed/tasks.json" "$HOME/.config/zed/tasks.json"

# Tiling window managers
if [[ "$OS_NAME" == "Linux" ]]; then
    relink "$SCRIPT_DIR/tiling/sway/config" ~/.config/sway/config
    relink "$SCRIPT_DIR/tiling/sway/tofi.config" ~/.config/tofi/config
    relink "$SCRIPT_DIR/tiling/sway/mako.config" ~/.config/mako/config
    relink "$SCRIPT_DIR/tiling/sway/swaylock.config" ~/.config/swaylock/config
    relink "$SCRIPT_DIR/tiling/waybar" ~/.config/waybar
    relink "$SCRIPT_DIR/tiling/wlogout" ~/.config/wlogout
fi

# LLMs
for target in ~/.claude/CLAUDE.md ~/.codex/AGENTS.md ~/.hermes/SOUL.md; do
    relink "$SCRIPT_DIR/llm/SOUL.md" "$target"
done

# Skills: ~/.agents/skills is read-only for its harnesses, so link the whole dir.
# Claude Code owns ~/.claude/skills and writes into it (synced/), so link per skill.
relink "$SCRIPT_DIR/llm/skills" ~/.agents/skills
for skill in "$SCRIPT_DIR"/llm/skills/*/; do
    relink "${skill%/}" ~/.claude/skills/"$(basename "$skill")"
done

echo "Done"

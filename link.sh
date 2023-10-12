#!/bin/sh

SCRIPT=$(readlink -f $0)
SCRIPT_DIR=`dirname $SCRIPT`

remove_existing () {
  # If it's a symlink - remove
  if [ -L $1 ]; then
    rm $1
  fi
  # If it's a file or a directory - rename
  if [ -f $1 ] || [ -d $1 ]; then
    mv $1 $1.old
  fi
}

remove_existing ~/.tmux.conf
ln -s $SCRIPT_DIR/shell/.tmux.conf ~/.tmux.conf
remove_existing ~/.zshrc
ln -s $SCRIPT_DIR/shell/.zshrc ~/.zshrc
remove_existing ~/.config/nvim
ln -s $SCRIPT_DIR/nvim ~/.config/nvim

# Link custom NvChad config
remove_existing $SCRIPT_DIR/nvim/lua/custom
ln -s $SCRIPT_DIR/nvchad_custom $SCRIPT_DIR/nvim/lua/custom

echo -n "\nDone\n"

#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

bash install.sh || exit 1

echo "source '$SCRIPT_DIR/aliases.sh'" >> $HOME/local_bashrc.sh
echo "source '$SCRIPT_DIR/ps1.sh'" >> $HOME/local_bashrc.sh

mkdir $HOME/.config
ln -s $SCRIPT_DIR/nvim $HOME/.config/nvim
ln -s $SCRIPT_DIR/tmux.conf $HOME/.tmux.conf


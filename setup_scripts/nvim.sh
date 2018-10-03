#!/bin/bash
function command_exists {
  command -v "$1" > /dev/null;
}

###
# install NeoVim
if ! command_exists nvim ; then
  echo " --- NeoVim --- "
  brew install neovim/neovim/neovim
  pip install neovim
  echo " --- End --- "
fi


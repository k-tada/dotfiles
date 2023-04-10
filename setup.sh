#!/bin/bash
function command_exists {
  command -v "$1" > /dev/null;
}

###
# Memorize user pass
#
read -sp "Your Password: " pass;

sh ./link-dotfiles.sh

###
# Install zsh
#
if ! command_exists zsh ; then
  echo " ------------ zsh ------------"
# Mac標準zshを使う
# brew install zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting
  brew install zsh-autosuggestions zsh-completions zsh-syntax-highlighting
  echo " ------------ END ------------"
fi

###
# Install wget
#
if ! command_exists wget ; then
  echo " ----------- wget ------------"
  brew install wget
  wget --version
  echo " ------------ END ------------"
fi

###
# Install *env
#
sh ./setup_scripts/anyenv.sh

###
# Install nvim
#
sh ./setup_scripts/nvim.sh

###
# Install brew softwares
sh ./setup_scripts/brew.sh



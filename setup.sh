#!/bin/bash
function command_exists {
  command -v "$1" > /dev/null;
}

###
# Memorize user pass
#
read -sp "Your Password: " pass;

./link-dotfiles.sh

###
# Install zsh
#
if ! command_exists zsh ; then
  echo " ------------ zsh ------------"
  brew install zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting
  which -a zsh
  echo $pass | sudo -S -- sh -c 'echo '/usr/local/bin/zsh' >> /etc/shells'
  chsh -s /usr/local/bin/zsh
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
./setup_scripts/anyenv.sh

###
# Install nvim
#
./setup_scripts/nvim.sh

###
# Install brew softwares
./setup_scripts/brew.sh



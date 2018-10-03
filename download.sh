#!/bin/bash
function command_exists {
  command -v "$1" > /dev/null;
}

###
# install homebrew
if ! command_exists brew ; then
  echo " --- Homebrew --- "
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  brew upgrade --all --cleanup
  brew -v
  echo " --- End --- "
fi

###
# install git
# if ! command_exists git ; then
  echo " --- Git --- "
  brew install git
  git --version
  echo " --- End --- "
# fi

###
# setup
echo " --- dotfiles.git --- "
git clone https://github.com/k-tada/dotfiles.git
echo "Run 'cd ~/dotfiles && . setup.sh'"
echo " --- End --- "


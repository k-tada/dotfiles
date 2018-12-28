#!/bin/bash
function command_exists {
  command -v "$1" > /dev/null;
}

###
# install homebrew
echo " --- Homebrew --- "
if ! command_exists brew ; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade --all --cleanup
brew -v
echo " --- End --- "

###
# install git
if [[ ! $(command -v "git") =~ ^\/usr\/local\/bin.* ]] ; then
  echo " --- Git --- "
  brew install git
  git --version
  echo " --- End --- "
fi

###
# setup
echo " --- dotfiles.git --- "
if [ -d ~/dotfiles ]; then
  cd ~/dotfiles
  git pull origin master
else
  cd
  git clone https://github.com/k-tada/dotfiles.git
fi
echo "Run 'cd ~/dotfiles && . setup.sh'"
echo " --- End --- "


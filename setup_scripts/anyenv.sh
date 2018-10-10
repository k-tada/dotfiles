#!/bin/bash
function command_exists {
  command -v "$1" > /dev/null;
}

###
# install anyenv
if ! command_exists anyenv ; then
  echo " --- anyenv --- "
  git clone https://github.com/riywo/anyenv $HOME/.anyenv
  export PATH=$HOME/.anyenv/bin:$PATH
  anyenv init -
  echo " --- End --- "
fi

anyenv_path=$HOME/.anyenv/envs

###
# install rbenv
if ! command_exists rbenv ; then
  echo " --- rbenv --- "
  anyenv install rbenv
  $anyenv_path/rbenv/bin/rbenv install 2.4.0
  echo " --- End --- "
fi

###
# install pyenv
if ! command_exists pyenv ; then
  echo " --- pyenv --- "
  anyenv install pyenv
  $anyenv_path/pyenv/bin/pyenv install 3.6.2
  echo " --- End --- "
fi

###
# install ndenv
if ! command_exists ndenv ; then
  echo " --- ndenv --- "
  anyenv install ndenv
  $anyenv_path/ndenv/bin/ndenv install v10.11.0
  echo " --- End --- "
fi

###
# install goenv
if ! command_exists goenv ; then
  echo " --- goenv --- "
  brew install goenv
  goenv install 1.11.0
  echo " --- End --- "
fi


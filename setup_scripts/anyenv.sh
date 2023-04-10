#!/bin/bash
function command_exists {
  command -v "$1" > /dev/null;
}

###
# install anyenv
if ! command_exists anyenv ; then
  echo " --- anyenv --- "
  brew install anyenv
  eval "$(anyenv install -)"
  exec $SHELL -l
  echo " --- End --- "
fi

anyenv_path=$HOME/.anyenv/envs

###
# install rbenv
if ! command_exists rbenv ; then
  echo " --- rbenv --- "
  anyenv install rbenv
  exec $SHELL -l
  rbenv install 3.1.2
  exec $SHELL -l
  echo " --- End --- "
fi

###
# install pyenv
if ! command_exists pyenv ; then
  echo " --- pyenv --- "
  anyenv install pyenv
  exec $SHELL -l
  pyenv install 3.10.4
  exec $SHELL -l
  echo " --- End --- "
fi

###
# install ndenv
if ! command_exists nodenv ; then
  echo " --- ndenv --- "
  anyenv install nodenv
  exec $SHELL -l
  nodenv install 18.1.0
  exec $SHELL -l
  echo " --- End --- "
fi

###
# install goenv
# if ! command_exists goenv ; then
#   echo " --- goenv --- "
#   brew install goenv
#   goenv install 1.11.0
#   echo " --- End --- "
# fi

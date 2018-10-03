#!/bin/bash
function command_exists {
  command -v "$1" > /dev/null;
}

###
# install anyenv
if ! command_exists anyenv ; then
  echo " --- anyenv --- "
  git clone https://github.com/riywo/anyenv ~/.anyenv
  exec $SHELL -l
  echo " --- End --- "
fi

###
# install rbenv
if ! command_exists rbenv ; then
  echo " --- rbenv --- "
  anyenv install rbenv
  exec $SHELL -l
  rbenv install 2.4.0
  exec $SHELL -l
  echo " --- End --- "
fi

###
# install pyenv
if ! command_exists pyenv ; then
  echo " --- pyenv --- "
  anyenv install pyenv
  exec $SHELL -l
  pyenv install 3.6.2
  exec $SHELL -l
  echo " --- End --- "
fi

###
# install ndenv
if ! command_exists ndenv ; then
  echo " --- ndenv --- "
  anyenv install ndenv
  exec $SHELL -l
  ndenv install v10.11.0
  exec $SHELL -l
  echo " --- End --- "
fi

###
# install goenv
if ! command_exists goenv ; then
  echo " --- goenv --- "
  brew install goenv
  exec $SHELL -l
  goenv install 1.11.0
  exec $SHELL -l
  echo " --- End --- "
fi


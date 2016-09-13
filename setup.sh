if [ -e .vim/bundle/nerdtree ]; then
  cp -a ./vim/plugins/diff_menu.vim .vim/bundle/nerdtree/nerdtree_plugin/
else
  echo 'run `git submodule init && git submodule update` before run this script'
fi

cd ~
ln -s ~/dotfiles/.vimrc .vimrc
ln -s ~/dotfiles/.gvimrc .gvimrc


let g:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config/nvim') : $XDG_CONFIG_HOME . '/nvim'

" Python 3 Support
let g:python3_host_prog = expand('$HOME') . '/.anyenv/envs/pyenv/shims/python'

" dein {{{
let s:dein_cache_dir = g:cache_home . '/dein'

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

if &runtimepath !~# '/dein.vim'
  let s:dein_repo_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

  " Auto Download
  if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
  endif

  " dein.vim をプラグインとして読み込む
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

" dein.vim settings
let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1

if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

  let s:toml_dir = g:config_home . '/dein'

  call dein#load_toml(s:toml_dir . '/plugins.toml', {'lazy': 0})
  if has('nvim')
    call dein#load_toml(s:toml_dir . '/neovim.toml', {'lazy': 1})
  endif
  call dein#load_toml(s:toml_dir . '/lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" vimprocは先にほしい
if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

filetype plugin indent on

""""""""""""""""""""""""""""""
" 各種オプションの設定
"""""""""""""""""""""""""""""""
highlight SpecialKey term=NONE cterm=NONE ctermfg=25 guifg=Blue
" カーソルが何行目の何列目に置かれているかを表示する
set ruler
" コマンドラインに使われる画面上の行数
set cmdheight=2
" エディタウィンドウの末尾から2行目にステータスラインを常時表示させる
set laststatus=2
" ウインドウのタイトルバーにファイルのパス情報等を表示する
set title
" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu
" 入力中のコマンドを表示する
set showcmd
" バッファで開いているファイルのディレクトリでエクスクローラを開始する
set browsedir=buffer
" 小文字のみで検索したときに大文字小文字を無視する
set smartcase
" 検索結果をハイライト表示する
set hlsearch
" 暗い背景色に合わせた配色にする
set background=dark
" タブ入力を複数の空白入力に置き換える
set expandtab
" 検索ワードの最初の文字を入力した時点で検索を開始する
set incsearch
" 保存されていないファイルがあるときでも別のファイルを開けるようにする
set hidden
" 不可視文字を表示する
set list
" タブと行の続きを可視化する
set listchars=tab:>\ ,extends:<
" 行番号を表示する
set number
" 対応する括弧やブレースを表示する
set showmatch
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" タブ文字の表示幅
set tabstop=2
" Vimが挿入するインデントの幅
set shiftwidth=2
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" クリップボード連携
set clipboard+=unnamed
" スワップファイルは使わない
set noswapfile
" Ctrl + a,xでの増減は10進、アルファベット、16進
set nrformats=hex
" Undoファイルの保存先変更
if has('unix')
  silent !mkdir -p ~/temp/vim/undo > /dev/null 2>&1
  set undodir=~/temp/vim/undo
else
  set undodir=c:/vim/undo
end
" バックアップファイルの保存先変更
if has('unix')
  silent !mkdir -p ~/temp/vim/backup > /dev/null 2>&1
  set backupdir=~/temp/vim/backup
else
  set backupdir=c:/vim/backup
end
" 挿入モードでのバックスペースを有効化
set backspace=start,eol,indent
" 大文字小文字を区別せずに検索する
set ignorecase
" 構文毎に文字色を変化させる
syntax on
" ESC2回でハイライト切り替え
nnoremap <silent><ESC><ESC> :<C-u>set hlsearch!<CR>

set ambiwidth=double

set noautochdir

set shell=sh

let &termencoding = &encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformats=unix,dos,mac

" tag jump
nnoremap [tagjump] <Nop>
nmap     <Space>t  [tagjump]

nnoremap [tagjump]t <C-]>
nnoremap [tagjump]b <C-t>

" F1でヘルプ開くのを無効化
nmap <F1> <nop>
imap <F1> <nop>

nnoremap <silent> <C-p> p
vnoremap <silent> <C-p> p
nnoremap <silent> p "0p
vnoremap <silent> p "0p

" 新規タブ
nnoremap <silent> gn :<C-u>tabnew<CR>

" タブ閉じる
nnoremap <silent> gC :tabc<CR>

" jjでesc
inoremap <silent> jj <ESC>

" 挿入モードから抜けた時に自動でNoPaste
autocmd InsertLeave * set nopaste

" MacVim用折り返し位置設定
autocmd FileType text setlocal textwidth=0

" FileTypes
autocmd BufRead,BufNewFile .zaliases set filetype=zsh
autocmd BufRead,BufNewFile .zprompt  set filetype=zsh
autocmd BufRead,BufNewFile .zenv     set filetype=zsh
autocmd BufRead,BufNewFile .zplug    set filetype=zsh
autocmd BufRead,BufNewFile .zcomp    set filetype=zsh
autocmd BufRead,BufNewFile .zoptions set filetype=zsh

" 全角スペースを表示
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif

let mapleader = "\<Space>"

" Delete unused plugins
" NOTE: if enable this settings, you must do `:call dein#recache_runtimepath()`
" call map(dein#check_clean(), "delete(v:val, 'rf')")

source $VIMRUNTIME/plugin/matchit.vim

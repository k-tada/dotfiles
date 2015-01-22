"---------------------------------------------------------------------------
" NeoBundle {{{2
if has('unix')
  let $DOTVIM=expand('~/.vim')
else
  let $DOTVIM=expand('~/vimfiles')
endif

let $VIMBUNDLE=$DOTVIM.'/bundle'
let $NEOBUNDLEPATH=$VIMBUNDLE.'/neobundle.vim'

function! s:bundled(bundle)
  if !isdirectory($VIMBUNDLE)
    return 0
  endif
  if stridx(&runtimepath, $NEOBUNDLEPATH) == -1
    return 0
  endif

  if a:bundle ==# 'neobundle.vim'
    return 1
  else
    return neobundle#is_installed(a:bundle)
  endif
endfunction

set nocompatible
filetype off

if has('vim_starting') && isdirectory($NEOBUNDLEPATH)
  set runtimepath+=$NEOBUNDLEPATH
endif

if s:bundled('neobundle.vim')
  call neobundle#begin(expand($VIMBUNDLE))

  " originalrepos on github
  NeoBundleFetch "Shougo/neobundle.vim"

  " ファイルオープンを便利に
  " <Space>u*で起動。多分uuしか使わない
  NeoBundle 'Shougo/unite.vim'
  call neobundle#config('unite.vim',{
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'commands' : [
      \     {
      \       'name' : 'Unite',
      \       'complete' : 'customlist,unite#complete_source'
      \     },
      \     'UniteWithCursorWord',
      \     'UniteWithInput'
      \   ]
      \ }})
  " Unite.vimで最近使ったファイルを表示できるようにする
  NeoBundle 'Shougo/neomru.vim'

  NeoBundle 'Shougo/vimproc'

  " ファイルをtree表示してくれる
  " :NerdTree
  NeoBundle 'scrooloose/nerdtree'
  " Gitを便利に使う
  " :Gstatus, Gdiff等
  NeoBundle 'tpope/vim-fugitive'
  " Git差分表示
  NeoBundle 'airblade/vim-gitgutter'

  " テキストオブジェクトで置換
  NeoBundle 'kana/vim-operator-replace.git'
  NeoBundle 'kana/vim-operator-user.git'

  " 開いているファイルに関係するファイルを開いてくれる
  " :Afでフォワード、:Abでバック
  NeoBundleLazy 'kana/vim-altr', {
      \ 'autoload' : {
      \   'functions' : [
      \     'altr#forward',
      \     'altr#back',
      \   ]},
      \ }

  " コメントON/OFFを手軽に実行
  " 通常モードでgcc, もしくはヴィジュアルモードでgc
  NeoBundle 'tomtom/tcomment_vim'
  " シングルクオートとダブルクオートの入れ替え等
  " cs(変換前)(変換後)  ex. cs"' "→'に変換
  NeoBundle 'tpope/vim-surround'

  " HTML入力支援
  " <Ctrl+y>,でタグ展開
  NeoBundle 'mattn/emmet-vim'

  " 括弧を閉じてくれる
  NeoBundle 'Townk/vim-autoclose'

  " 爆速移動
  " sかg/で移動スタート
  NeoBundle 'Lokaltog/vim-easymotion'

  " true/false トグル
  NeoBundle 'AndrewRadev/switch.vim'

  NeoBundle 'itchyny/lightline.vim'

  " NeoBundle 'Shougo/vimshell'

  " Complete
  " Tabで選択、Enterで展開
  NeoBundle 'Shougo/neocomplete.vim'
  " Snippet
  " Tabで選択、Ctrl+Spaceで展開
  NeoBundle 'Shougo/neosnippet.vim'
  NeoBundle 'Shougo/neosnippet-snippets'
  " File Syntax Checker
  " NeoBundle 'scrooloose/syntastic'

  " Gistクライアント
  " :Gistaで起動
  NeoBundle 'lambdalisue/vim-gista'

  """ For Ruby {{{
  " Ruby endを自動挿入
  NeoBundle 'tpope/vim-endwise'
  " }}}

  " *検索拡張
  " z*で従来通り（カーソル動かさない）
  " g*でVisualモード選択箇所検索
  NeoBundle 'haya14busa/vim-asterisk'

  " /検索拡張
  " インクリメンタルサーチ
  NeoBundle 'haya14busa/incsearch.vim'

  " w, b, eなどの移動をスマートに
  NeoBundle 'kana/vim-smartword'
  
  " サブモード設定可能に
  NeoBundle 'kana/vim-submode'

  " SCPアップロード
  " scp で実施
  NeoBundle 'ryoppy/vim-scp-upload'

  " メソッドリスト表示
  " <Space>tlでトグル
  NeoBundle 'vim-scripts/taglist.vim'
  NeoBundle 'szw/vim-tags'

  " If there are uninstalled bundles found on startup,
  " this will conveniently prompt you to install them.
  NeoBundleCheck

  call neobundle#end()
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
set clipboard+=unnamed
" スワップファイルは使わない
set noswapfile
" Undoファイルの保存先変更
if has('unix')
  set undodir=/tmp/vim/undo
else
  set undodir=c:/vim/undo
end
" バックアップファイルの保存先変更
if has('unix')
  set backupdir=/tmp/vim/backup
else
  set backupdir=c:/vim/backup
end
" 構文毎に文字色を変化させる
syntax on
""""""""""""""""""""""""""""""

let &termencoding = &encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformats=unix,dos,mac

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

autocmd QuickFixCmdPost *grep* cwindow

""""""""""""""""""""""""""""""
" NeoComplete.vimの設定
""""""""""""""""""""""""""""""
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Ignore Case
let g:neocomplete#enable_ignore_case = 1
" Use Smartcase
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" Plugin key-mappings.
imap <Nul> <Plug>(neosnippet_expand_or_jump)
smap <Nul> <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"---------------------------------------------------------------------------
"" for Shougo/unite.vim {{{2
if s:bundled('unite.vim')
  " insert modeで開始
  let g:unite_enable_start_insert = 1

  " 大文字小文字を区別しない
  let g:unite_enable_ignore_case = 1 
  let g:unite_enable_smart_case = 1 
  nnoremap [unite]    <Nop>
  nmap     <Space>u [unite]

  nnoremap <silent> [unite]c   :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
  nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
  nnoremap <silent> [unite]r   :<C-u>Unite register<CR>
  nnoremap <silent> [unite]o   :<C-u>Unite outline<CR>
  nnoremap <silent> [unite]u   :<C-u>Unite file_mru<CR>
  nnoremap <silent> [unite]d   :<C-u>Unite directory_mru<CR>
  nnoremap <silent> [unite]k   :<C-u>Unite bookmark<CR>
  nnoremap <silent> [unite]s   :<C-u>Unite source<CR>
  nnoremap <silent> [unite]f   :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <silent> [unite]g   :<C-u>Unite grep<CR>
  nnoremap <silent> ,g         :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
  nnoremap <silent> ,cg        :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
  nnoremap <silent> ,r         :<C-u>UniteResume search-buffer<CR>
  nnoremap <silent> [unite]h   :<C-u>Unite help<CR>
  nnoremap <silent> [unite];   :<C-u>Unite history/command<CR>
  nnoremap <silent> [unite]/   :<C-u>Unite history/search<CR>
  nnoremap <silent> [unite]y   :<C-u>Unite history/yank<CR>
  nnoremap <silent> [unite]a   :<C-u>UniteBookmarkAdd<CR>
  nnoremap <silent> [unite]n   :<C-u>Unite neobundle/install:!<CR>
  nnoremap <silent> [unite]e   :<C-u>Unite snippet<CR>
  nnoremap <silent> [unite]q   :<C-u>Unite quickfix<CR>
  nnoremap <silent> [unite]p   :<C-u>Unite ref/perldoc<CR>

  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_drecursive_opt = ''
  endif

endif
" }}}

""""""""""""""""""""""""""""""
" Vim-EasyMotion.vimの設定
""""""""""""""""""""""""""""""
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0
let g:EasyMotion_keys = 'QZASDFGHJKL;'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
hi EasyMotionTarget guifg=#80a0ff ctermfg=81

""""""""""""""""""""""""""""""
" switch.vimの設定
""""""""""""""""""""""""""""""
nmap + :Switch<CR>
nmap - :Switch<CR>

""""""""""""""""""""""""""""""
" lightline.vimの設定
""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

if !has('gui_running')
  set t_Co=256
endif
set laststatus=2

" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
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
"""""""""""""""""""""""""""""

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample

""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
" let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'
"
" if has('syntax')
"   augroup InsertHook
"     autocmd!
"     autocmd InsertEnter * call s:StatusLine('Enter')
"     autocmd InsertLeave * call s:StatusLine('Leave')
"   augroup END
" endif
"
" let s:slhlcmd = ''
" function! s:StatusLine(mode)
"   if a:mode == 'Enter'
"     silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
"     silent exec g:hi_insert
"   else
"     highlight clear StatusLine
"     silent exec s:slhlcmd
"   endif
" endfunction
"
" function! s:GetHighlight(hi)
"   redir => hl
"   exec 'highlight '.a:hi
"   redir END
"   let hl = substitute(hl, '[\r\n]', '', 'g')
"   let hl = substitute(hl, 'xxx', '', '')
"   return hl
" endfunction
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" 自動的に閉じ括弧を入力
"""""""""""""""""""""""""""""""
" imap { {}<LEFT>
" imap [ []<LEFT>
" imap ( ()<LEFT>
"""""""""""""""""""""""""""""""

"---------------------------------------------------------------------------
" for kana/vim-operator-replace {{{2
if s:bundled('vim-operator-user') && s:bundled('vim-operator-replace')
  map R  <Plug>(operator-replace)
endif
" }}}

"---------------------------------------------------------------------------
" for kana/vim-altr {{{2
if s:bundled('vim-altr')
  call altr#remove_all()
  call altr#define('plugin/%/*.vim', 'autoload/%/*.vim')
  call altr#define('plugin/%.vim',   'autoload/%.vim')

  " For ruby
  call altr#define('%.rb', 'spec/%_spec.rb')

  " For rails
  call altr#define('app/models/%.rb', 'spec/models/%_spec.rb', 'spec/factories/%s.rb')
  call altr#define('app/controllers/%.rb', 'spec/controllers/%_spec.rb')
  call altr#define('app/helpers/%.rb', 'spec/helpers/%_spec.rb')

  command! Af call altr#forward()
  command! Ab call altr#back()
endif
" }}}

"---------------------------------------------------------------------------
" for lambdalisue/vim-gista {{{2
if s:bundled('vim-gista')
  let g:gista#github_user="k-tada"
endif
" }}}

"---------------------------------------------------------------------------
" for haya14busa/incsearch.vim {{{2
if s:bundled('incsearch.vim')
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
endif
" }}}

"---------------------------------------------------------------------------
" for kana/vim-smartword {{{2
if s:bundled('vim-smartword')
  nmap w  <Plug>(smartword-w)
  vmap w  <Plug>(smartword-w)
  map  b  <Plug>(smartword-b)
  map  e  <Plug>(smartword-e)
  if s:bundled('vim-submode')
    call submode#enter_with('ge-mode', 'nv', 'r', 'ge', '<Plug>(smartword-ge)')
    call submode#map('ge-mode', 'nv', 'r', 'e', '<Plug>(smartword-ge)')
  else
    nmap ge <Plug>(smartword-ge)
    vmap ge <Plug>(smartword-ge)
  endif
  omap ge <Plug>(smartword-ge)
endif
" }}}

"---------------------------------------------------------------------------
" for ryoppy/vim-scp-upload {{{2
if s:bundled('vim-scp-upload')
  let g:vim_scp_configs = {
  \  'mps_myshop12_server' : {
  \    'local_base_path'  : '/Users/kentarou.tada/work/proj/mps/aumyshop/trunk/webui/Ver11/aumypremiershop.jp/',
  \    'remote_base_path' : '/srv/www/dev/myshop12/aumypremiershop.jp/',
  \    'user' : 'myshop12',
  \    'pass' : 'Ag45Aydc',
  \    'host' : '219.94.191.114',
  \    'port' : '22'
  \  }
  \}
  nnoremap <Space>s <ESC>:call ScpUpload()<CR>
endif
" }}}

"---------------------------------------------------------------------------
" for kana/vim-submode {{{2
if s:bundled('vim-submode')
  " undo/redo
  call submode#enter_with('undo/redo', 'n', '', 'g+', 'g+')
  call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')
  call submode#map('undo/redo', 'n', '', '+', 'g+')
  call submode#map('undo/redo', 'n', '', '-', 'g-')

  " move tab
  call submode#enter_with('tabmove', 'n', '', 'gt', 'gt')
  call submode#enter_with('tabmove', 'n', '', 'gT', 'gT')
  call submode#map('tabmove', 'n', '', 't', 'gt')
  call submode#map('tabmove', 'n', '', 't', 'gT')

  " move window
  call submode#enter_with('windowmove', 'n', '', '<Space>ww', '<C-w>w')
  call submode#enter_with('windowmove', 'n', '', '<Space>Ww', '<C-w>w')
  call submode#enter_with('windowmove', 'n', '', '<Space>wW', '<C-w>W')
  call submode#enter_with('windowmove', 'n', '', '<Space>WW', '<C-w>W')
  call submode#map('windowmove', 'n', '', 'w', '<C-w>w')
  call submode#map('windowmove', 'n', '', 'W', '<C-w>W')

endif
" }}}

"---------------------------------------------------------------------------
"" for vim-scripts/taglist.vim {{{2
if s:bundled('taglist.vim')
  set tags=tags
  let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
  " 現在編集中のファイルのタグのみを表示
  let Tlist_Show_One_File = 1 
  " タグリストを右側に表示
  let Tlist_Use_Right_Window = 1
  " taglistが最後のWindowならVimを閉じる
  let Tlist_Exit_OnlyWindow = 1
  let g:tlist_php_settings = 'php;c:class;d:constant;f:function'
  nnoremap <Space>tl :TlistToggle<CR>

  " if !argc()
    autocmd vimenter * TlistToggle
  " endif
endif
" }}}

if s:bundled('nerdtree')
  if !argc()
    autocmd vimenter * NERDTree|normal gg3j
  endif
endif

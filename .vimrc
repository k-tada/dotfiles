"---------------------------------------------------------------------------
" NeoBundle {{{2
if has('unix')
  let $DOTVIM=expand('~/.vim')
else
  let $DOTVIM=expand('~/vimfiles')
endif

let $VIMBUNDLE=$DOTVIM.'/bundle'
let $NEOBUNDLEPATH=$VIMBUNDLE.'/neobundle.vim'

function! Bundled(bundle)
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

if Bundled('neobundle.vim')
  call neobundle#begin(expand($VIMBUNDLE))

  " originalrepos on github
  NeoBundleFetch "Shougo/neobundle.vim"

  " アラインツール
  NeoBundle 'Align'

  " .editorconfig
  NeoBundle 'editorconfig/editorconfig-vim'

  " ファイルオープンを便利に
  " <Space>u*で起動。
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
  " uniteでアウトラインを利用可能にする
  " <Space>uoで起動。
  NeoBundle 'Shougo/unite-outline', '', 'default'
  call neobundle#config('unite-outline', {
      \ 'lazy' : 1,
      \ 'autoload' : {
      \   'unite_sources' : 'outline',
      \ }})
  NeoBundleLazy 'thinca/vim-unite-history', { 'autoload' : {
      \ 'unite_sources' : ['history/command', 'history/search'],
      \ }}
  " Unite.vimで最近使ったファイルを表示できるようにする
  NeoBundle 'Shougo/neomru.vim'

  " ファイルをtree表示してくれる
  " :NerdTree
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'Xuyuanp/nerdtree-git-plugin'
  " Gitを便利に使う
  " :Gstatus, Gdiff等
  NeoBundle 'tpope/vim-fugitive'
  NeoBundleLazy 'gregsexton/gitv', {'depends':['tpope/vim-fugitive'],
              \ 'autoload':{'commands':'Gitv'}}

  " Git差分表示
  NeoBundle 'airblade/vim-gitgutter'

  NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf' }

  " テキストオブジェクトで置換
  NeoBundle 'kana/vim-operator-replace.git'
  NeoBundle 'kana/vim-operator-user.git'

  " 検索補助、snake_case<->camelCase置き換え等
  " :S/{pattern} で検索
  " :S/{src}/{dst}/{flag} で置換
  " cr[scmu] でそれぞれsnake_case, camelCase, MixedCase, UPPER_CASEに置き換え
  NeoBundle 'tpope/vim-abolish'

  " 開いているファイルに関係するファイルを開いてくれる
  " :Afでフォワード、:Abでバック
  " NeoBundleLazy 'kana/vim-altr', {
  "     \ 'autoload' : {
  "     \   'functions' : [
  "     \     'altr#forward',
  "     \     'altr#back',
  "     \   ]},
  "     \ }

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

  NeoBundle 'Shougo/vimshell'
  NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \     'windows' : 'make -f make_mingw32.mak',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'unix' : 'make -f make_unix.mak',
            \    },
            \ }

  " Complete
  " Tabで選択、Enterで展開
  NeoBundle 'Shougo/neocomplete.vim'
  " Snippet
  " Tabで選択、Ctrl+Spaceで展開
  NeoBundle 'Shougo/neosnippet.vim'
  NeoBundle 'Shougo/neosnippet-snippets'
  NeoBundle "honza/vim-snippets"

  " File Syntax Checker
  " NeoBundle 'scrooloose/syntastic'

  " Gistクライアント
  " :Gistaで起動
  NeoBundleLazy 'lambdalisue/vim-gista', {
    \ 'autoload': {
    \    'commands': ['Gista'],
    \    'mappings': '<Plug>(gista-',
    \    'unite_sources': 'gista',
    \}}

  """ For Ruby {{{
  " Ruby endを自動挿入
  NeoBundle 'tpope/vim-endwise'

  " ruby用テキストオブジェクト
  NeoBundle 'rhysd/vim-textobj-ruby'

  " Railsプロジェクト
  NeoBundle 'tpope/vim-rails'

  " Rails + Unite
  NeoBundle 'basyura/unite-rails'
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

  " Ctags自動実行
  NeoBundle 'soramugi/auto-ctags.vim'

  " HTTPステータスコードを調べる
  " :HttpStatus 4 => 4xxのコードを列挙
  NeoBundleLazy 'mattn/httpstatus-vim', {
    \ 'autoload' : {
    \   'commands' : [
    \     'HttpStatus',
    \   ],
    \   'unite_sources' : 'httpstatus',
    \ }}

  " 末尾のスペースを表示
  NeoBundle 'bronson/vim-trailing-whitespace'

  " 現在の状況を保存、復元
  " :ReanimateSave, :ReanimateLoad
  NeoBundle 'osyo-manga/vim-reanimate'

  " 複数選択（SublimeTextのCmd+D）
  NeoBundle 'terryma/vim-multiple-cursors'

  " matchit.vim
  NeoBundle 'tmhedberg/matchit'

  "---------------------------------------------------------------------------
  " テキストオブジェクト関連
  ""{{{
  "   ベース
  NeoBundle 'kana/vim-textobj-user'

  "   バッファ全体 ae ie
  NeoBundle 'kana/vim-textobj-entire',
        \ { 'depends' : 'kana/vim-textobj-user' }
  "   関数内 aF iF
  " NeoBundle 'kana/vim-textobj-function',
  "       \ { 'depends' : 'kana/vim-textobj-user' }
  " NeoBundle 'thinca/vim-textobj-function-javascript',
  "       \ { 'depends' : 'kana/vim-textobj-user' }
  "   カーソル位置と同じインデント aI iI
  NeoBundle 'kana/vim-textobj-indent',
        \ { 'depends' : 'kana/vim-textobj-user' }
  "   カーソル行 al il
  NeoBundle 'kana/vim-textobj-line',
        \ { 'depends' : 'kana/vim-textobj-user' }
  "   URL au iu
  NeoBundle 'mattn/vim-textobj-url',
        \ { 'depends' : 'kana/vim-textobj-user' }
  "   引数 a, i,
  NeoBundle 'sgur/vim-textobj-parameter',
        \ { 'depends' : 'kana/vim-textobj-user' }
  "   特定の文字の間 af{char} if{char}
  " NeoBundle 'thinca/vim-textobj-between',
  "     \ { 'depends' : 'kana/vim-textobj-user' }
  "   括弧内 ab ib
  NeoBundle 'kana/vim-textobj-jabraces',
      \ { 'depends' : 'kana/vim-textobj-user' }
  NeoBundle 'osyo-manga/vim-textobj-multitextobj',
      \ { 'depends' : 'kana/vim-textobj-user' }
  "}}}

  "---------------------------------------------------------------------------
  " ハイライト
  ""{{{
  " Scala
  NeoBundle 'derekwyatt/vim-scala'

  " CoffeeScript
  NeoBundle 'kchmck/vim-coffee-script'

  " CoffeeScript + JSX
  NeoBundle 'mtscout6/vim-cjsx'

  " Elixir
  NeoBundle 'elixir-lang/vim-elixir'

  " TypeScript
  NeoBundle 'leafgarland/typescript-vim'

  " MarkDown
  NeoBundle 'rcmdnk/vim-markdown'

  "}}}

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

set ambiwidth=double

colorscheme hybrid

""""""""""""""""""""""""""""""

let &termencoding = &encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformats=unix,dos,mac

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

autocmd QuickFixCmdPost *grep* cwindow

" if has('mac')
"   noremap! ¥ \
"   noremap! \ ¥
" endif

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

" MacVim用折り返し位置設定
autocmd FileType text setlocal textwidth=0

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
if Bundled('unite.vim')
  " insert modeで開始
  let g:unite_enable_start_insert = 1

  " 大文字小文字を区別しない
  let g:unite_enable_ignore_case = 1
  let g:unite_enable_smart_case = 1

  let g:unite_source_menu_menus = {}
  nnoremap [unite]    <Nop>
  nmap     <Space>u [unite]

  nnoremap <silent> [unite]c       :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
  nnoremap <silent> [unite]b       :<C-u>Unite buffer<CR>
  " nnoremap <silent> [unite]r       :<C-u>Unite register<CR>
  nnoremap <silent> [unite]o       :<C-u>Unite outline<CR>
  nnoremap <silent> [unite]u       :<C-u>Unite file_rec/async<CR>
  nnoremap <silent> [unite]<Space> :<C-u>Unite file_rec/async<CR>
  " nnoremap <Space><Space>          :<C-u>Unite file_rec/async<CR>
  nnoremap <silent> [unite]d       :<C-u>Unite directory_mru<CR>
  nnoremap <silent> [unite]k       :<C-u>Unite bookmark<CR>
  nnoremap <silent> [unite]s       :<C-u>Unite source<CR>
  " nnoremap <silent> [unite]s       :<C-u>Unite -buffer-name=search line/fast -start-insert -no-quit<CR>
  nnoremap <silent> [unite]f       :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <silent> [unite]g       :<C-u>Unite grep<CR>
  nnoremap <silent> ,g             :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
  nnoremap <silent> ,cg            :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>
  nnoremap <silent> ,r             :<C-u>UniteResume search-buffer<CR>
  nnoremap <silent> [unite]h       :<C-u>Unite help<CR>
  nnoremap <silent> [unite];       :<C-u>Unite history/command<CR>
  nnoremap <silent> [unite]/       :<C-u>Unite history/search<CR>
  nnoremap <silent> [unite]y       :<C-u>Unite history/yank<CR>
  nnoremap <silent> [unite]a       :<C-u>UniteBookmarkAdd<CR>
  nnoremap <silent> [unite]n       :<C-u>Unite neobundle/install<CR>
  nnoremap <silent> [unite]e       :<C-u>Unite snippet<CR>
  nnoremap <silent> [unite]q       :<C-u>Unite quickfix<CR>
  " nnoremap <silent> [unite]p       :<C-u>Unite ref/perldoc<CR>

  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
      \ '--nogroup --nocolor --column'
      \ . ' --ignore ''.svn'''
      \ . ' --ignore ''.git'''
      \ . ' --ignore ''node_modules'''
    let g:unite_source_grep_recursive_opt = ''
  endif


  let g:unite_source_menu_menus.git = {
        \ 'description' : '            gestionar repositorios git
        \                            ⌘ [espacio]g',
        \}
  let g:unite_source_menu_menus.git.command_candidates = [
        \['> git viewer             (gitv)                              ⌘ ,gv',
        \'normal ,tv'],
        \['> git viewer - buffer    (gitv)                              ⌘ ,gV',
        \'normal ,tV'],
        \['> git status       (Fugitive)                                ⌘ ,gs',
        \'Gstatus'],
        \['> git diff         (Fugitive)                                ⌘ ,gd',
        \'Gdiff'],
        \['> git commit       (Fugitive)                                ⌘ ,gc',
        \'Gcommit'],
        \['> git log          (Fugitive)                                ⌘ ,gl',
        \'exe "silent Glog | Unite quickfix"'],
        \['> git blame        (Fugitive)                                ⌘ ,gb',
        \'Gblame'],
        \['> git stage        (Fugitive)                                ⌘ ,gw',
        \'Gwrite'],
        \['> git checkout     (Fugitive)                                ⌘ ,go',
        \'Gread'],
        \['> git rm           (Fugitive)                                ⌘ ,gr',
        \'Gremove'],
        \['> git mv           (Fugitive)                                ⌘ ,gm',
        \'exe "Gmove " input("destino: ")'],
        \['> git push         (Fugitive, salida por buffer)             ⌘ ,gp',
        \'Git! push'],
        \['> git pull         (Fugitive, salida por buffer)             ⌘ ,gP',
        \'Git! pull'],
        \['> git prompt       (Fugitive, salida por buffer)             ⌘ ,gi',
        \'exe "Git! " input("comando git: ")'],
        \['> git cd           (Fugitive)',
        \'Gcd'],
        \]
  nnoremap <silent> [unite]g       :<C-u>Unite -silent -start-insert menu:git<CR>

  " call unite#custom#default_action('file', 'tabswitch')
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
if has('unix')
    let g:lightline = {
          \ 'colorscheme': 'landscape',
          \ 'component': {
          \   'readonly': '%{&readonly?"\ue0a2":""}',
          \ },
          \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2"},
          \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3"}
          \ }
else
    let g:lightline = {
          \ 'colorscheme': 'landscape',
          \ }
endif

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
if Bundled('vim-operator-user') && Bundled('vim-operator-replace')
  map R  <Plug>(operator-replace)
endif
" }}}

"---------------------------------------------------------------------------
" for kana/vim-altr {{{2
if Bundled('vim-altr')
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
if Bundled('vim-gista')
  let g:gista#github_user="k-tada"
  let g:gista#post_private = 1
endif
" }}}

"---------------------------------------------------------------------------
" for haya14busa/incsearch.vim {{{2
if Bundled('incsearch.vim')
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
endif
" }}}

"---------------------------------------------------------------------------
" for kana/vim-smartword {{{2
if Bundled('vim-smartword')
  nmap w  <Plug>(smartword-w)
  vmap w  <Plug>(smartword-w)
  map  b  <Plug>(smartword-b)
  map  e  <Plug>(smartword-e)
  if Bundled('vim-submode')
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
" for kana/vim-submode {{{2
if Bundled('vim-submode')
  " undo/redo
  call submode#enter_with('undo/redo', 'n', '', 'g+', 'g+')
  call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')
  call submode#map('undo/redo', 'n', '', '+', 'g+')
  call submode#map('undo/redo', 'n', '', '-', 'g-')

  " move tab
  call submode#enter_with('tabmove', 'n', '', 'gt', 'gt')
  call submode#enter_with('tabmove', 'n', '', 'gT', 'gT')
  call submode#map('tabmove', 'n', '', 't', 'gt')
  call submode#map('tabmove', 'n', '', 'T', 'gT')

  " move window
  call submode#enter_with('windowmove', 'n', '', '<Space>ww', '<C-w>w')
  call submode#enter_with('windowmove', 'n', '', '<Space>Ww', '<C-w>w')
  call submode#enter_with('windowmove', 'n', '', '<Space>wW', '<C-w>W')
  call submode#enter_with('windowmove', 'n', '', '<Space>WW', '<C-w>W')
  call submode#map('windowmove', 'n', '', 'w', '<C-w>w')
  call submode#map('windowmove', 'n', '', 'W', '<C-w>W')

  " resize window
  call submode#enter_with('windowresize', 'n', '', '<Space>wh', '<C-w><C-<>')
  call submode#enter_with('windowresize', 'n', '', '<Space>wl', '<C-w><C->>')
  call submode#enter_with('windowresize', 'n', '', '<Space>wk', '<C-w><C-+>')
  call submode#enter_with('windowresize', 'n', '', '<Space>wj', '<C-w><C-->')
  call submode#map('windowresize', 'n', '', 'h', '<C-w><C-<>')
  call submode#map('windowresize', 'n', '', 'l', '<C-w><C->>')
  call submode#map('windowresize', 'n', '', 'k', '<C-w><C-+>')
  call submode#map('windowresize', 'n', '', 'j', '<C-w><C-->')

endif
" }}}

"---------------------------------------------------------------------------
"" for vim-scripts/taglist.vim {{{2
if Bundled('taglist.vim')
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
    " autocmd vimenter * TlistToggle
  " endif
endif
" }}}

"---------------------------------------------------------------------------
"" for scrooloose/nerdtree {{{2
if Bundled('nerdtree')
  nmap <silent> <Space>ne      :NERDTreeToggle<CR>
  " 隠しファイルを表示
  let NERDTreeShowHidden = 1
  " 表示幅
  let NERDTreeWinSize = 50
  " 表示フィルタ
  let NERDTreeIgnore = ['\.svn$', '\~$', '\.DS_Store']

  if !argc()
    autocmd vimenter * NERDTree|normal gg3j
  endif
  if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary")
    autocmd bufenter * q
  endif
endif
" }}}

"---------------------------------------------------------------------------
"" for soramugi/auto-ctags.vim {{{2
if Bundled('auto-ctags.vim')
  let g:auto_ctags = 1
  let g:auto_ctags_directory_list = ['.git', '.svn']
  set tags+=.git/tags
  set tags+=.svn/tags
endif
" }}}

"---------------------------------------------------------------------------
"" for mattn/emmet-vim {{{2
if Bundled('emmet-vim')
  let g:user_emmet_leader_key = '<c-e>'
endif
" }}}

"---------------------------------------------------------------------------
"" for textobj plugins {{{2
if Bundled('kana/vim-textobj-user')
  if (Bundled('kana/vim-textobj-jabraces') && Bundled('osyo-manga/vim-textobj-multitextobj'))
    let g:textobj_multitextobj_textobjects_i = [
        \ "\<Plug>(textobj-multiblock-i)",
        \ "\<Plug>(textobj-jabraces-parens-i)",
        \ "\<Plug>(textobj-jabraces-braces-i)",
        \ "\<Plug>(textobj-jabraces-brackets-i)",
        \ "\<Plug>(textobj-jabraces-angles-i)",
        \ "\<Plug>(textobj-jabraces-double-angles-i)",
        \ "\<Plug>(textobj-jabraces-kakko-i)",
        \ "\<Plug>(textobj-jabraces-double-kakko-i)",
        \ "\<Plug>(textobj-jabraces-yama-kakko-i)",
        \ "\<Plug>(textobj-jabraces-double-yama-kakko-i)",
        \ "\<Plug>(textobj-jabraces-kikkou-kakko-i)",
        \ "\<Plug>(textobj-jabraces-sumi-kakko-i)",
        \]
    let g:textobj_multitextobj_textobjects_a = [
        \ "\<Plug>(textobj-multiblock-a)",
        \ "\<Plug>(textobj-jabraces-parens-a)",
        \ "\<Plug>(textobj-jabraces-braces-a)",
        \ "\<Plug>(textobj-jabraces-brackets-a)",
        \ "\<Plug>(textobj-jabraces-angles-a)",
        \ "\<Plug>(textobj-jabraces-double-angles-a)",
        \ "\<Plug>(textobj-jabraces-kakko-a)",
        \ "\<Plug>(textobj-jabraces-double-kakko-a)",
        \ "\<Plug>(textobj-jabraces-yama-kakko-a)",
        \ "\<Plug>(textobj-jabraces-double-yama-kakko-a)",
        \ "\<Plug>(textobj-jabraces-kikkou-kakko-a)",
        \ "\<Plug>(textobj-jabraces-sumi-kakko-a)",
        \]
    omap ab <Plug>(textobj-multitextobj-a)
    omap ib <Plug>(textobj-multitextobj-i)
    vmap ab <Plug>(textobj-multitextobj-a)
    vmap ib <Plug>(textobj-multitextobj-i)
  endif
endif
" }}}

"---------------------------------------------------------------------------
"" for mattn/emmet-vim {{{2
if Bundled('vim-trailing-whitespace')
  let g:extra_whitespace_ignored_filetypes = ['unite', 'mkd']
endif
" }}}

"------------------------------------
" vim-rails
"------------------------------------
""{{{
if Bundled('vim-rails')
  "有効化
  let g:rails_default_file='config/database.yml'
  let g:rails_level = 4
  let g:rails_mappings=1
  let g:rails_modelines=0
  " let g:rails_some_option = 1
  let g:rails_statusline = 1
  " let g:rails_subversion=0
  " let g:rails_syntax = 1
  " let g:rails_url='http://localhost:3000'
  " let g:rails_ctags_arguments='--languages=-javascript'
  " let g:rails_ctags_arguments = ''
  nnoremap <buffer><Space>r :R<CR>
  nnoremap <buffer><Space>a :A<CR>
  nnoremap <buffer><Space>m :Rmodel<Space>
  nnoremap <buffer><Space>c :Rcontroller<Space>
  nnoremap <buffer><Space>v :Rview<Space>
  nnoremap <buffer><Space>p :Rpreview<CR>
endif
"}}}

"------------------------------------
"" Unite-rails.vim
"------------------------------------
""{{{
if Bundled('vim-rails')
  nnoremap <silent> [unite]rv   :<C-u>Unite rails/view<CR>
  nnoremap <silent> [unite]rm   :<C-u>Unite rails/model<CR>
  nnoremap <silent> [unite]rc   :<C-u>Unite rails/controller<CR>
  nnoremap <silent> [unite]rC   :<C-u>Unite rails/config<CR>
  nnoremap <silent> [unite]rs   :<C-u>Unite rails/spec<CR>
  nnoremap <silent> [unite]rl   :<C-u>Unite rails/lib<CR>
  nnoremap <silent> [unite]rh   :<C-u>Unite rails/heroku<CR>

  nnoremap <buffer><C-H>m           :<C-U>Unite rails/db -input=migrate<CR>
  nnoremap <buffer><expr><C-H>g     ':e '.b:rails_root.'/Gemfile<CR>'
  nnoremap <buffer><expr><C-H>r     ':e '.b:rails_root.'/config/routes.rb<CR>'
  nnoremap <buffer><expr><C-H>se    ':e '.b:rails_root.'/db/seeds.rb<CR>'
  nnoremap <buffer><C-H>ra          :<C-U>Unite rails/rake<CR>
  nnoremap <buffer><C-H>h           :<C-U>Unite rails/heroku<CR>
endif
"}}}

"------------------------------------
"" airblade/vim-gitgutter
"------------------------------------
""{{{
if Bundled('vim-gitgutter')
  let g:gitgutter_max_signs=1000
endif
"}}}

"------------------------------------
"" rcmdnk/vim-markdown
"------------------------------------
""{{{
if Bundled('vim-markdown')
  let g:vim_markdown_folding_disabled=1
endif
"}}}

"------------------------------------
"" gregsexton/gitv
"------------------------------------
""{{{
if Bundled('gitv')
  let g:Gitv_OpenHorizontal = 'auto'
  let g:Gitv_WipeAllOnClose = 1
  let g:Gitv_DoNotMapCtrlKey = 1
  nnoremap <silent> <leader>tv :Gitv --all<CR>
  nnoremap <silent> <leader>tV :Gitv! --all<CR>
  vnoremap <silent> <leader>tV :Gitv! --all<CR>
endif
"}}}

"---------------------------------------------------------------------------
" local設定読み込み
"   ディレクトリ単位で固有の設定を持つ場合、
"   そのディレクトリに.vimprojectsファイルを設定し、
"   そこに固有の設定を記載する
"---------------------------------------------------------------------------
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
  autocmd BufReadPre .vimprojects set ft=vim
augroup END
function! s:vimrc_local(loc)
  let files = findfile('.vimprojects', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction


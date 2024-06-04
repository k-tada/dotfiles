local options = {
  -- カーソルが何行目何列目にあるかを表示
  ruler = true,
  -- コマンドラインに使われる画面上の行数
  cmdheight = 2,
  -- エディタウィンドウの末尾から2行目にステータスラインを常時表示
  laststatus = 2,
  -- ウィンドウのタイトルバーにファイルのパスを表示
  title = true,
  -- コマンドラインモードで<Tab>キーによるファイル名補完を有効
  wildmenu = true,
  -- 入力中のコマンドを表示
  showcmd = true,
  -- 小文字のみで検索した際に大文字・小文字を無視
  smartcase = true,
  -- 検索結果をハイライト表示
  hlsearch = true,
  -- 暗い背景色に合わせた配色にする
  background = "dark",
  -- タブ入力を複数の空白文字にする
  expandtab = true,
  -- 検索ワードの最初の文字を入力した時点で検索を開始
  incsearch = true,
  -- 不可視文字を表示
  hidden = true,
  -- タブと業の続きを可視化
  list = true,
  listchars = { tab = '>>', extends = '<' },
  -- 行番号
  number = true,
  -- 対応するカッコを表示
  showmatch = true,
  -- 改行時に前のインデントを保持
  autoindent = true,
  -- 改行時に直前の行に応じてインデントを調整
  smartindent = true,
  -- タブ文字幅
  tabstop = 2,
  -- Vimが挿入するインデント幅
  shiftwidth = 2,
  -- 行頭の余白で<Tab>キーを入力した際のインデント幅をshiftwidthに
  smarttab = true,
  -- クリップボード連携
  clipboard = "unnamed,unnamedplus",
  -- スワップファイルは使わない
  swapfile = false,
  -- Ctrl + a, xでの増減を10進、アルファベット、16進
  nrformats = "hex",
  -- Undoファイル保管先
  undofile = true,
  undodir = vim.fn.stdpath('cache') .. "/undo",
  -- backupファイル保管先
  backupdir = vim.fn.stdpath('cache') .. "/backup",
  -- 挿入モードでのバックスペース有効化
  backspace = "start,eol,indent",
  -- 大文字小文字を区別せず検索
  ignorecase = true,
  -- 新しいウィンドウを下に開く
  splitbelow = true,
  -- 新しいウィンドウを右に開く
  splitright = true,
  -- 記号を全角幅で表示
  ambiwidth = "double",
  -- 自動でカレントディレクトリを変更しない
  autochdir = false,
  -- エンコード
  encoding = "utf-8",
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- カーソルを行頭、行末で止まらないようにする
vim.cmd("set whichwrap+=b,s,h,l,<,>,[,]")

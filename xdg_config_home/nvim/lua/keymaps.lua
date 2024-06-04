local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

-- remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ESC2回でハイライト切り替え
keymap("n", "<Esc><Esc>", ":<C-u>set hlsearch!<Return>", opts)

-- F1でヘルプを無効化
keymap("n", "<F1>", "<Nop>", opts)
keymap("i", "<F1>", "<Nop>", opts)

-- ペースト
keymap("n", "<C-p>", "p", opts)
keymap("v", "<C-p>", "p", opts)
keymap("n", "p", '"0p', opts)
keymap("v", "p", '"0p', opts)

-- new tab
keymap("n", "gn", ":<C-u>tabnew", opts)

-- close tab
keymap("n", "gC", ":<C-u>tabc", opts)

-- <space>^で前のファイルを開く
keymap("n", "<Space>^", "<C-^>", opts)

keymap("n", "cp", ':let @* = expand("%:p")<cr>', opts)

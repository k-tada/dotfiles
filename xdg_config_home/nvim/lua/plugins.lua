local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
-- if not status_ok then
--   return
-- end

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here

  use({ "wbthomason/packer.nvim" })
  use({ "nvim-lua/plenary.nvim" }) -- Common utilities
  use({ "vim-denops/denops.vim" })
  use({ "petertriho/nvim-scrollbar" })

  -- Colorschemes
  use({ "jonathanfilip/vim-lucius" }) -- Color scheme
  use({ "nvim-lualine/lualine.nvim" }) -- Statusline
  use({ "kyazdani42/nvim-web-devicons" }) -- File icons
  use({ "akinsho/bufferline.nvim" })

  -- cmp plugins
  use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
  use({ "hrsh7th/cmp-buffer" }) -- buffer completions
  use({ "hrsh7th/cmp-path" }) -- path completions
  use({ "hrsh7th/cmp-cmdline" }) -- cmdline completions
  use({ "f3fora/cmp-spell" }) -- cmp from vim spell
  use({ "onsails/lspkind-nvim" })
  use({ "pontusk/cmp-sass-variables" })
  use({ "roginfarrer/cmp-css-variables" })

  -- snippets
  use({ "hrsh7th/cmp-vsnip" }) --snippet engine
  use({ "L3MON4D3/LuaSnip" }) --snippet engine
  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions

  -- LSP
  use({ "neovim/nvim-lspconfig" }) -- enable LSP
  use({ "hrsh7th/cmp-nvim-lsp" })
  -- use({ "williamboman/mason.nvim" }) -- simple to use language server installer
  -- use({ "williamboman/mason-lspconfig.nvim" })
  -- use({ "glepnir/lspsaga.nvim" }) -- LSP UIs
  use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters

  -- Formatter
  use({ "MunifTanjim/prettier.nvim" })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })
  use({ "nvim-telescope/telescope-file-browser.nvim" })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" } })

  -- ts html auto close tag
  use({ "windwp/nvim-ts-autotag" })

  -- VSCode like にする
  -- use({ "lukas-reineke/indent-blankline.nvim" })

  use({ "tpope/vim-surround" })

  use({ "Shougo/context_filetype.vim" })
  use({ "osyo-manga/vim-precious" })
  use({ "mattn/emmet-vim" })
  use({ "kana/vim-submode" })
  use({ "easymotion/vim-easymotion" })
  use({ "Townk/vim-autoclose" })
  use({ "monaqa/dps-dial.vim" })
  use({ "editorconfig/editorconfig-vim" })
  use({ "brglng/vim-im-select" })
  use({ "tomtom/tcomment_vim" })
  use({ "styled-components/vim-styled-components" })
  use({ "lilydjwg/colorizer" })

  -- Vue
  -- use({ "posva/vim-vue" })
  use({ "leafOfTree/vim-vue-plugin" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

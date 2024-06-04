local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	return
end

local on_attach = function(client, bufnr)

end

local protocol = require("vim.lsp.protocol")

local capabilities = require'cmp_nvim_lsp'.default_capabilities()

protocol.CompletionItemKind = {
	"t", -- Text
	"m", -- Method
	"f", -- Function
	"", -- Constructor
	"", -- Field
	"", -- Variable
	"", -- Class
	"ﰮ", -- Interface
	"", -- Module
	"", -- Property
	"", -- Unit
	"", -- Value
	"", -- Enum
	"", -- Keyword
	"﬌", -- Snippet
	"", -- Color
	"", -- File
	"", -- Reference
	"", -- Folder
	"", -- EnumMember
	"", -- Constant
	"", -- Struct
	"", -- Event
	"ﬦ", -- Operator
	"", -- TypeParameter
}


require'mason'.setup()
require'mason-lspconfig'.setup()
require'mason-lspconfig'.setup_handlers {
  function(server_name)
    require'lspconfig'[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
}

nvim_lsp.tsserver.setup({
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities,
})

-- LSP Saga
local saga = require'lspsaga'

saga.setup({
  ui = {
    winblend = 10,
    border = 'rounded',
    colors = {
      normal_bg = '#002b36'
    }
  }
})

local keymap = vim.keymap.set

keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>")
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
keymap("n", "ga", "<cmd>Lspsaga code_action<CR>")
keymap("n", "gr", "<cmd>Lspsaga rename<CR>")
keymap("n", "ge", "<cmd>Lspsaga show_line_diagnostics<CR>")
keymap("n", "[e", "<cmd>Lspsaga diagnostics_jump_next<CR>")
keymap("n", "]e", "<cmd>Lspsaga diagnostics_jump_next<CR>")
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>")
keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]])

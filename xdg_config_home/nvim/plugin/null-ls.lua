local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lsp_formatting = function(bufnr)
  -- vim.lsp.buf.format({ async = false })
  -- vim.lsp.buf.formatting_sync()
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

null_ls.setup({
  sources = {
    -- formatting.prettierd,
    -- formatting.eslint_d.with({
    -- 	diagnostics_format = "[eslint] #{m}\n(#{c})",
    -- }),
    formatting.shfmt,
    diagnostics.eslint.with({
      prefer_local = "node_modules/.bin",
    }),
    formatting.prettier.with({
      prefer_local = "node_modules/.bin",
    }),
    formatting.stylua,
  },
  -- debug = false,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end
  end,
})

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- nopaste
autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste"
})

-- file types
autocmd({"BufRead", "BufNewFile"}, {
  pattern = {".zalias", ".zprompt", ".zenv", ".zplug", ".zcomp", ".zoptions", ".zlocal"},
  command = "set filetype=zsh"
})
autocmd({"BufRead", "BufNewFile"}, {
  pattern = {".vue"},
  command = "set filetype=vue"
})
autocmd({"BufRead", "BufNewFile", "BufWritePost"}, {
  pattern = {".js"},
  command = "set filetype=javascript"
})
autocmd({"BufRead", "BufNewFile", "BufWritePost"}, {
  pattern = {".jsx"},
  command = "set filetype=javascriptreact"
})
autocmd({"BufRead", "BufNewFile", "BufWritePost"}, {
  pattern = {".ts"},
  command = "set filetype=typescript"
})
autocmd({"BufRead", "BufNewFile", "BufWritePost"}, {
  pattern = {".tsx"},
  command = "set filetype=typescriptreact"
})

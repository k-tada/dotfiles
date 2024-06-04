vim.cmd [[
try
  colorscheme lucius
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

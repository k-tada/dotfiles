-- config dir
local config_home = vim.env.XDG_CONFIG_HOME or "~/.config/nvim"
vim.g.config_home = config_home

-- cache dir
local cache_home = vim.env.XDG_CACHE_HOME or "~/.cache"
vim.g.cache_home = cache_home

-- Python support
vim.g.python3_host_prog = "~/.anyenv/envs/pyenv/shims/python"

-- reset augroup
vim.cmd('autocmd!')

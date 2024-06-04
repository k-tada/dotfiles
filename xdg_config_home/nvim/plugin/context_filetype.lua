vim.cmd([[
  if !exists('g:context_filetype#filetypes')
    let g:context_filetype#filetypes = {}
  endif

  " dein.toml編集用
  let g:context_filetype#filetypes['toml'] = [
  \ {'filetype':'vim', 'start':'^\s*hook_\(add\|source\|post_source\)\s*=\s*'.'""'.'"', 'end':'""'.'"'},
  \ {'filetype':'vim', 'start':'^\s*hook_\(add\|source\|post_source\)\s*=\s*'."''"."'", 'end':"''"."'"},
  \ ]

  let g:context_filetype#filetypes['javascript'] = [
        \ {
        \   'start': 'styled.*`',
        \   'end':   '`',
        \   'filetype': 'css',
        \ },
        \ {
        \   'start': '<style jsx>.*`',
        \   'end':   '`}.*style',
        \   'filetype': 'css',
        \ },
        \ ]
  let g:context_filetype#filetypes['typescript'] = [
        \ {
        \   'start': 'styled.*`',
        \   'end':   '`',
        \   'filetype': 'css',
        \ },
        \ {
        \   'start': '<style jsx>.*`',
        \   'end':   '`}.*style',
        \   'filetype': 'css',
        \ },
        \ ]
  let g:context_filetype#filetypes['typescriptreact'] = [
        \ {
        \   'start': 'styled.*`',
        \   'end':   '`',
        \   'filetype': 'css',
        \ },
        \ {
        \   'start': '<style jsx>.*`',
        \   'end':   '`}.*style',
        \   'filetype': 'css',
        \ },
        \ ]
]])

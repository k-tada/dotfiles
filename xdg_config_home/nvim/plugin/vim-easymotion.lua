-- let g:EasyMotion_do_mapping = 0
-- nmap s <Plug>(easymotion-s2)
-- xmap s <Plug>(easymotion-s2)
-- omap z <Plug>(easymotion-s2)
-- nmap g/ <Plug>(easymotion-sn)
-- xmap g/ <Plug>(easymotion-sn)
-- omap g/ <Plug>(easymotion-tn)
-- let g:EasyMotion_smartcase = 1
-- map <Leader>j <Plug>(easymotion-j)
-- map <Leader>k <Plug>(easymotion-k)
-- let g:EasyMotion_startofline = 0
-- let g:EasyMotion_keys = 'QZASDFGHJKL;'
-- let g:EasyMotion_use_upper = 1
-- let g:EasyMotion_enter_jump_first = 1
-- let g:EasyMotion_space_jump_first = 1
-- hi EasyMotionTarget guifg=#80a0ff ctermfg=81

vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_smartcase = 1
vim.g.EasyMotion_startofline = 0
vim.g.EasyMotion_keys = 'QZASDFGHJKL;'
vim.g.EasyMotion_use_upper = 1
vim.g.EasyMotion_enter_jump_first = 1
vim.g.EasyMotion_space_jump_first = 1

vim.keymap.set('n', 's', '<Plug>(easymotion-s2)', { silent = true, noremap = true})

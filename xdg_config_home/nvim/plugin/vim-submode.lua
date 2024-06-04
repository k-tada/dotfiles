function create_mode(namespace, prefix, beforehook, afterhook)
    local plug_pending = ("<Plug>(submode-p-%s)"):format(namespace)
    local plug_before_hook = ("<Plug>(submode-b-%s)"):format(namespace)
    local plug_after_hook = ("<Plug>(submode-a-%s)"):format(namespace)

    local timeoutlen

    if beforehook == nil then
        beforehook = function()
            timeoutlen = vim.opt.timeoutlen
            vim.opt.timeoutlen = 10000
            print("SUBMODE (" .. namespace .. ") IS ACTIVE!")
        end
    end

    if afterhook == nil then
        afterhook = function()
            vim.opt.timeoutlen = timeoutlen
            print("Submode (" .. namespace .. ") finished.")
        end
    end

    vim.keymap.set("n", plug_before_hook, beforehook)
    vim.keymap.set("n", plug_after_hook, afterhook)
    vim.keymap.set("n", plug_pending, plug_after_hook)

    local mode = {
        ---@param repeater string
        ---@param action string
        register_mapping = function(repeater, action)
            vim.keymap.set("n", prefix .. repeater, plug_before_hook .. action .. plug_pending)
            vim.keymap.set("n", plug_pending .. repeater, action .. plug_pending)
        end,
    }

    return mode
end

local tabmove = create_mode('tabmove', 'g')
tabmove.register_mapping('t', 'gt')
tabmove.register_mapping('T', 'gT')

local windowmove = create_mode('windowmove', '<Space>w')
windowmove.register_mapping('w', '<C-w>w')
windowmove.register_mapping('W', '<C-w>W')

local windowmove2 = create_mode('windowmove', '<Space>W')
windowmove2.register_mapping('w', '<C-w>w')
windowmove2.register_mapping('W', '<C-w>W')

local windowresize = create_mode('windowresize', '<Space>w')
windowresize.register_mapping('h', '<C-w><C-<>')
windowresize.register_mapping('l', '<C-w><C->>')
windowresize.register_mapping('k', '<C-w><C-+>')
windowresize.register_mapping('j', '<C-w><C-->')

local windowex = create_mode('windowex', '<Space>w')
windowex.register_mapping('e', '<C-w>x')

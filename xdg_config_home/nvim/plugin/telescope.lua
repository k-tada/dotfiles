local status, telescope = pcall(require, "telescope")
if not status then
  return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local action_state = require("telescope.actions.state")
local transform_mod = require("telescope.actions.mt").transform_mod

local function telescope_buffer_dir()
  return vim.fn.expand("%:p:h")
end

local fb_actions = require("telescope").extensions.file_browser.actions

local telescope_custom_actions = {}

local function multiopen(prompt_bufnr, method)
  local cmd_map = {
    vertical = "vsplit",
    horizontal = "split",
    tab = "tabe",
    default = "edit",
  }
  local picker = action_state.get_current_picker(prompt_bufnr)
  local multi_selection = picker:get_multi_selection()

  if #multi_selection > 1 then
    require("telescope.pickers").on_close_prompt(prompt_bufnr)
    pcall(vim.api.nvim_set_current_win, picker.original_win_id)

    for i, entry in ipairs(multi_selection) do
      -- opinionated use-case
      local cmd = i == 1 and "edit" or cmd_map[method]
      vim.cmd(string.format("%s %s", cmd, entry.value))
    end
  else
    actions["select_" .. method](prompt_bufnr)
  end
end

local custom_actions = transform_mod({
  multi_selection_open_vertical = function(prompt_bufnr)
    multiopen(prompt_bufnr, "vertical")
  end,
  multi_selection_open_horizontal = function(prompt_bufnr)
    multiopen(prompt_bufnr, "horizontal")
  end,
  multi_selection_open_tab = function(prompt_bufnr)
    multiopen(prompt_bufnr, "tab")
  end,
  multi_selection_open = function(prompt_bufnr)
    multiopen(prompt_bufnr, "default")
  end,
})
local function stopinsert(callback)
  return function(prompt_bufnr)
    vim.cmd.stopinsert()
    vim.schedule(function()
      callback(prompt_bufnr)
    end)
  end
end
telescope.setup({
  defaults = {
    prompt_prefix = "> ",
    selection_caret = ">> ",

    mappings = {
      n = {
        ["q"] = actions.close,
        ["s"] = actions.select_horizontal,
        ["v"] = actions.select_vertical,
        ["t"] = actions.select_tab,
      },
    },

    file_ignore_patterns = { "node_modules", ".git", ".idea" },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ["n"] = {
          -- your custom normal mode mappings
          ["o"] = custom_actions.multi_selection_open,
          ["<CR>"] = custom_actions.multi_selection_open,
          ["s"] = custom_actions.multi_selection_open_horizontal,
          ["v"] = custom_actions.multi_selection_open_vertical,
          ["t"] = custom_actions.multi_selection_open_tab,
          ["/"] = function()
            vim.cmd("startinsert")
          end,
        },
      },
    },
  },
})

telescope.load_extension("file_browser")

vim.keymap.set("n", ",f", function()
  builtin.find_files({
    hidden = true,
  })
end)
vim.keymap.set("n", ",g", function()
  builtin.live_grep()
end)
vim.keymap.set("n", ",cg", function()
  builtin.grep_string({ search = vim.fn.expand("<cword>") })
end)
vim.keymap.set("n", ",r", function()
  builtin.resume()
end)
vim.keymap.set("n", ",b", function()
  builtin.buffers()
end)
vim.keymap.set("n", ",t", function()
  builtin.help_tags()
end)
-- vim.keymap.set("n", ";;", function()
-- 	builtin.resume()
-- end)
vim.keymap.set("n", ";e", function()
  builtin.diagnostics()
end)
vim.keymap.set("n", "<space>ne", function()
  telescope.extensions.file_browser.file_browser({
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = true,
    initial_mode = "normal",
  })
end)
vim.keymap.set("n", "<space>nc", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = true,
    initial_mode = "normal",
  })
end)

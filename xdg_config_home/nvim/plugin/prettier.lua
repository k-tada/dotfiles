local status, prettier = pcall(require, "prettier")
if (not status) then return end

prettier.setup {
  bin = 'prettier',
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },

  arrow_parens = "always",
  bracket_spacing = true,
  embedded_language_formatting = "auto",
  html_whitespace_sensitivity = "css",
  jsx_bracket_same_line = false,
  jsx_single_quote = false,
  print_width = 120,
  prose_wrap = "preserve",
  quote_props = "as-needed",
  semi = false,
  single_quote = true,
  tab_width = 2,
  trailing_comma = "es5",
  use_tabs = false,
  vue_indent_script_and_style = false,
}

vim.keymap.set('n', ';a',
  function()
    vim.lsp.buf.format({ async = true })
  end
)

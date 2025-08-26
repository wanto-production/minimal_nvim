return {
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      integrations = {
        indent_blankline = {
          enabled = true,
          scope_color = 'blue', -- pilih warna (blue, red, green, peach, dll sesuai palette catppuccin)
          colored_indent_levels = false,
        },
      },
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}

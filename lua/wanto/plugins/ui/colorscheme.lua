return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha', -- mocha paling gelap
      transparent_background = false,
      dim_inactive = {
        enabled = true,
        shade = 'dark',
        percentage = 0.15,
      },
      styles = {
        comments = { 'italic' },
        keywords = { 'italic' },
      },
      color_overrides = {
        mocha = {
          base = '#11111b', -- lebih gelap dari default
          mantle = '#0e0e16', -- super dark
          crust = '#0a0a10', -- darkest
        },
      },
      integrations = {
        snacks = {
          enabled = true,
          indent_scope_color = 'lavender', -- catppuccin color (eg. `lavender`) Default: text
        },
      },
    }
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}

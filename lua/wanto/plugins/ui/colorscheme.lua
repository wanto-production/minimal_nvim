return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      transparent_background = false,
      dim_inactive = {
        enabled = true,
        shade = 'dark',
        percentage = 0.10,
      },
      styles = {
        comments = { 'italic' },
        keywords = { 'italic' },
      },
      color_overrides = {
        mocha = {
          base = '#11151c', -- sedikit lebih terang, tetap blue-black
          mantle = '#0e1117', -- dark blue-black
          crust = '#0a0d12', -- darkest
          -- Text colors
          text = '#c9d1d9',
          subtext1 = '#b1bac4',
          subtext0 = '#8b949e',
          -- Surface colors
          surface0 = '#1a1f26',
          surface1 = '#252a32',
          surface2 = '#30353d',
        },
      },
      integrations = {
        snacks = {
          enabled = true,
          indent_scope_color = 'sapphire',
        },
      },
    }
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}

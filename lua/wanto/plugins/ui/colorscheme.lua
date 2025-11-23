return {
  -- {
  --   'catppuccin/nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('catppuccin').setup {
  --       transparent_background = false,
  --       flavour = 'mocha',
  --       integrations = {
  --         snacks = {
  --           enabled = true,
  --           indent_scope_color = 'lavender', -- pilih warna (blue, red, green, peach, dll sesuai palette catppuccin)
  --         },
  --       },
  --     }
  --     vim.cmd.colorscheme 'catppuccin'
  --   end,
  -- },

  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
}

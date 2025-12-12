return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('mini.icons').mock_nvim_web_devicons() -- I got it because I checked :h MiniIcons.config command

      require('nvim-tree').setup {
        view = {
          side = 'right',
          width = 30,
        },
        renderer = {
          indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
              corner = '└',
              edge = '│',
              item = '│',
              bottom = '─',
              none = ' ',
            },
          },
        },
      }
    end,
  },
}

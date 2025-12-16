return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    dependencies = {
      {
        'windwp/nvim-ts-autotag',
        event = 'VeryLazy',
        opts = { enable_close_on_slash = false },
      },
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = require('users.lang').treesitter,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }

      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
        pattern = { '*.component.html', '*.container.html' },
        callback = function()
          vim.treesitter.start(nil, 'angular')
        end,
      })
    end,
  },
}

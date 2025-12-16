return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      {
        'windwp/nvim-ts-autotag',
        event = 'VeryLazy',
        opts = { enable_close_on_slash = false },
      },
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install(require('users.lang').treesitter)
      require('nvim-treesitter').setup {
        install_dir = vim.fn.stdpath 'data' .. '/site',
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

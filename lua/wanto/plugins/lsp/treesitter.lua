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
    opts = function(_, opts)
      opts.ensure_installed = require('users.lang').treesitter
      opts.auto_install = true
      opts.highlight = { enable = true }

      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
        pattern = { '*.component.html', '*.container.html' },
        callback = function()
          vim.treesitter.start(nil, 'angular')
        end,
      })

      return opts
    end,
  },
}

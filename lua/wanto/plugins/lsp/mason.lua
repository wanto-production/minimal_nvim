return {
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      -- list of servers for mason to install
      ensure_installed = require('users.lang').mason.lsp,
    },
    dependencies = {
      {
        'williamboman/mason.nvim',
        opts = {
          ui = {
            icons = {
              package_installed = '✓',
              package_pending = '➜',
              package_uninstalled = '✗',
            },
          },
          registries = require('users.lang').mason.registries,
        },
      },
      'neovim/nvim-lspconfig',
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = require('users.lang').mason.formatter_and_linter,
    },
    dependencies = {
      'williamboman/mason.nvim',
    },
  },
}

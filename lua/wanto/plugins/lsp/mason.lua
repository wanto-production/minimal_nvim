return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' }, -- ⚡ KUNCI: Event yang tepat
  },

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

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'VimEnter',
    opts = {
      ensure_installed = require('users.lang').mason.ensure_installed,
      auto_install = true,
      run_on_start = true,
      integrations = {
        ['mason-lspconfig'] = false,
        ['mason-null-ls'] = false,
        ['mason-nvim-dap'] = false,
      },
    },
  },
}

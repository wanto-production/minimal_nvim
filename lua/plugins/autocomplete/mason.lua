return {
  -- Mason core
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup {
        ui = {
          border = 'rounded',
          height = 0.8,
          width = 0.8,
          keymaps = {
            apply_language_filter = 'f',
          },
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }
    end,
  },

  -- Mason LSP Config untuk auto install LSP servers
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = require('users.lang').mason.lsp,
        automatic_installation = true,
      }
    end,
  },

  -- Mason Tool Installer untuk tools lainnya (formatters, linters, DAP)
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('mason-tool-installer').setup {
        ensure_installed = require('users.lang').mason.formatter_and_linter,
        auto_update = true,
        run_on_start = true,
        start_delay = 3000, -- delay 3 detik setelah nvim start
        debounce_hours = 5, -- check update setiap 5 jam
      }
    end,
  },
}

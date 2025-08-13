return {
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' }, -- load sebelum buffer dibuka
    build = ':MasonUpdate',
    config = function()
      require('mason').setup {
        ui = {
          border = 'rounded',
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }

      require('mason-lspconfig').setup {
        ensure_installed = {
          'lua_ls',
          'vtsls',
          'html',
          'cssls',
          'jsonls',
          'svelte',
          'astro',
          'tailwindcss',
        },
        automatic_installation = true,
      }

      require('mason-tool-installer').setup {
        ensure_installed = {
          'codelldb',
          'stylua',
          'prettierd',
          'eslint_d',
        },
        auto_update = true,
        run_on_start = true,
      }
    end,
  },
}

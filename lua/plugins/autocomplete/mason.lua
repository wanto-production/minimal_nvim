return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'williamboman/mason.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' }, -- load sebelum buffer dibuka
    build = ':MasonUpdate',
    config = function()
      require('mason').setup {
        ui = {
          border = 'rounded',
          height = 0.8,
          width = 0.8,
          keymaps = {
            apply_language_filter = 'f', -- ini defaultnya
          },
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }

      require('mason-tool-installer').setup {
        ensure_installed = {
          --server
          'lua_ls',
          'vtsls',
          'html',
          'cssls',
          'jsonls',
          'svelte',
          'astro',
          'tailwindcss',
          'yamlls',

          --other
          'codelldb',
          'stylua',
          'prettierd',
          'eslint_d',
        },
        auto_update = true,
        run_on_start = true,
        integrations = {
          ['mason-lspconfig'] = true,
          ['mason-null-ls'] = true,
          ['mason-nvim-dap'] = true,
        },
      }
    end,
  },
}

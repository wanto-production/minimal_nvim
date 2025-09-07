return {
  {
    'williamboman/mason.nvim',
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'williamboman/mason-lspconfig.nvim',
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
        registries = {
          'github:mason-org/mason-registry',
          'github:Crashdummyy/mason-registry',
        },
        ensure_installed = {
          --server
          'lua_ls',
          'taplo',
          'vtsls',
          'html',
          'cssls',
          'jsonls',
          'svelte',
          'astro',
          'tailwindcss',
          'yamlls',
          'intelephense',
          'emmet_ls',
          --other
          'codelldb',
          'stylua',
          'prettierd',
          'eslint_d',
        },
        auto_update = true,
        auto_install = true,
        run_on_start = true,
      }
    end,
  },
}

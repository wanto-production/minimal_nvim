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
    build = ':TSUpdate', -- update parser saat plugin dibangun
    main = 'nvim-treesitter.configs', -- agar 'opts' diarahkan ke modul config utama
    opts = function(_, opts)
      opts.ensure_installed = {
        'vue',
        'angular',
        'scss',
        'typescript',
        'javascript',
        'astro',
        'svelte',
        'css',
        'html',
        'bash',
        'c',
        'diff',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'rust',
        'ron',
        'regex',
      }
      opts.auto_install = true -- otomatis install parser saat file dibuka
      opts.highlight = {
        enable = true, -- aktifkan syntax highlighting
      }

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

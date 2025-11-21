return {
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Gunakan versi terbaru
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        -- Konfigurasi server
        server = {
          on_attach = function(_, bufnr)
            -- Aktifkan inlay hints
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

            -- Setup formatting otomatis saat save (opsional)
            -- vim.api.nvim_clear_autocmds { buffer = bufnr }
            -- vim.api.nvim_create_autocmd('BufWritePre', {
            --   buffer = bufnr,
            --   callback = function()
            --     vim.lsp.buf.format { bufnr = bufnr }
            --   end,
            -- })

            -- Contoh lain: setup keymap
            -- require("utils").lsp_keymaps(bufnr)
          end,
          -- Opsi lain untuk rust-analyzer
          settings = {
            ['rust-analyzer'] = {
              -- Contoh: aktifkan proc macro expansion
              procMacro = {
                enable = true,
              },
              -- Aktifkan caching
              cachePriming = {
                enable = true,
              },
              -- Aktifkan indexing di background
              indexing = {
                enable = true,
              },
            },
          },
        },
        -- Opsi lainnya
        tools = {
          -- Aktifkan rust tools lainnya
          inlay_hints = {
            auto = true,
            show_parameter_hints = true,
            parameter_hints_prefix = '<- ',
            other_hints_prefix = '=> ',
          },
        },

        dap = {
          adapter = {
            type = 'executable',
            name = 'codelldb',
            command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb', -- Path ke codelldb dari Mason
            args = { '--port', '45326' },
          },
          configuration = {
            {
              name = 'Launch',
              type = 'codelldb',
              request = 'launch',
              program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
              end,
              cwd = '${workspaceFolder}',
              stopOnEntry = false,
              args = {},
            },
          },
        },
      }
    end,
  },
  -- Tambahkan juga crates.nvim untuk manajemen dependensi
  {
    'saecki/crates.nvim',
    version = 'v0.3.0',
    ft = { 'rust', 'toml' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup {
        popup = {
          border = 'rounded',
          show_version_date = false,
          show_dependency_version = true,
        },
      }
    end,
  },
}

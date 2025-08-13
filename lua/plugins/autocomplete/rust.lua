return {
  {
    'Saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },

  {
    'mrcjkb/rustaceanvim',
    version = vim.fn.has 'nvim-0.10.0' == 0 and '^4' or false,
    ft = { 'rust' },
    opts = function()
      local rust_opts = {
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set('n', '<leader>cR', function()
              vim.cmd.RustLsp 'codeAction'
            end, { desc = 'Code Action', buffer = bufnr })

            vim.keymap.set('n', '<leader>dr', function()
              vim.cmd.RustLsp 'debuggables'
            end, { desc = 'Rust Debuggables', buffer = bufnr })
          end,
          default_settings = {
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              checkOnSave = true, -- default aktif
              diagnostics = {
                enable = true,
              },
              procMacro = {
                enable = true,
                ignored = {
                  ['async-trait'] = { 'async_trait' },
                  ['napi-derive'] = { 'napi' },
                  ['async-recursion'] = { 'async_recursion' },
                },
              },
              files = {
                excludeDirs = {
                  '.direnv',
                  '.git',
                  '.github',
                  '.gitlab',
                  'bin',
                  'node_modules',
                  'target',
                  'venv',
                  '.venv',
                },
              },
            },
          },
        },
      }

      -- cek kalau mason dan codelldb tersedia
      local ok, mason_registry = pcall(require, 'mason-registry')
      if ok and mason_registry.is_installed 'codelldb' then
        ---@diagnostic disable-next-line: undefined-field
        local package_path = mason_registry.get_package('codelldb'):get_install_path()
        local codelldb = package_path .. '/extension/adapter/codelldb'
        local library_path = package_path .. '/extension/lldb/lib/liblldb.dylib'
        if vim.fn.has 'linux' == 1 then
          library_path = package_path .. '/extension/lldb/lib/liblldb.so'
        end
        rust_opts.dap = {
          adapter = require('rustaceanvim.config').get_codelldb_adapter(codelldb, library_path),
        }
      end

      -- peringatan kalau rust-analyzer belum ada
      if vim.fn.executable 'rust-analyzer' == 0 then
        vim.notify(
          '**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/',
          vim.log.levels.ERROR,
          { title = 'rustaceanvim' }
        )
      end

      return rust_opts
    end,
    config = function(_, opts)
      vim.g.rustaceanvim = opts
    end,
  },
}

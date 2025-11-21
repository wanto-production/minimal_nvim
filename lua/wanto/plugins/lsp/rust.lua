return {
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

            vim.api.nvim_clear_autocmds { buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format { bufnr = bufnr }
              end,
            })
          end,
          settings = {
            ['rust-analyzer'] = {
              inlayHints = {
                -- Nonaktifkan parameter hints (misal: `param:` di fungsi)
                parameterHints = { enable = false },

                -- Nonaktifkan type hints (tipe variabel)
                typeHints = { enable = true },

                -- Nonaktifkan chaining hints (pada method chain)
                chainingHints = { enable = true },

                -- Nonaktifkan closure capture hints
                closureCaptureHints = { enable = false },

                -- Nonaktifkan closure return type hints
                closureReturnTypeHints = { enable = 'always' }, -- atau "always", "with_block"

                -- Nonaktifkan lifetime hints
                lifetimeElisionHints = { enable = 'never' }, -- atau "always", "skip_trivial"

                -- Nonaktifkan binding mode hints (misal: ref, ref mut)
                bindingModeHints = { enable = true },

                -- Nonaktifkan const generic parameter hints
                genericParameterHints = {
                  type = { enable = false },
                  lifetime = { enable = false },
                  const = { enable = false },
                },

                -- Nonaktifkan closing brace hints (untuk block panjang)
                closingBraceHints = { enable = true },

                -- Nonaktifkan adjustment hints (misal: deref, reborrow)
                expressionAdjustmentHints = { enable = 'never' }, -- atau "always", "reborrow_like"

                -- Nonaktifkan discriminant hints (pada enum)
                discriminantHints = { enable = 'never' }, -- atau "always"

                -- Nonaktifkan impl dyn trait hints
                impliedDynTraitHints = { enable = true },

                -- Nonaktifkan implicit drop hints
                implicitDrops = { enable = false },

                -- Nonaktifkan sized bound hints
                implicitSizedBoundHints = { enable = false },

                -- Nonaktifkan range exclusive hints (misal: ..)
                rangeExclusiveHints = { enable = false },

                -- Jangan tampilkan hint lebih dari N karakter
                maxLength = 8, -- ubah atau set ke `nil` untuk unlimited
              },
            },
          },
        },
        tools = {
          inlay_hints = {
            auto = true,
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

return {
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    ft = 'rust',
    lazy = true,
    init = function()
      -- Aktifkan inlay hints global (sekali saja)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('RustInlayHints', { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == 'rust-analyzer' then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end
        end,
      })
    end,
    opts = {
      server = {
        on_attach = function(_, bufnr)
          -- Format on save (tanpa clear berulang)
          local group = vim.api.nvim_create_augroup('RustFormat', { clear = false })
          vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            group = group,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, async = true })
            end,
          })
        end,
      },
    },
  },
  {
    'saecki/crates.nvim',
    version = 'v0.3.0',
    event = 'BufRead Cargo.toml', -- hanya aktif di Cargo.toml
    ft = { 'toml' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      popup = {},
    },
  },
}

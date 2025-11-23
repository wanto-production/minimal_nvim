return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufEnter' },
    cmd = { 'ConformInfo' },
    config = function()
      require('conform').setup {
        format_on_save = {
          timeout_ms = 500,
          lsp_format = 'fallback',
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          vue = { 'prettier' },
          -- javascript = { "prettierd", "prettier", stop_after_first = true },
        },
      }
    end,
  },
}

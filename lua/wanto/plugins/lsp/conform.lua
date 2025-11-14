return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    config = function()
      require('conform').setup {
        notify_on_error = false,
        format_on_save = function(bufnr)
          local disable_filetypes = { c = true, cpp = true }
          if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
          else
            return {
              timeout_ms = 500,
              lsp_format = 'fallback',
            }
          end
        end,
        formatters_by_ft = {
          lua = { 'stylua' },
          -- javascript = { "prettierd", "prettier", stop_after_first = true },
        },
      }
      vim.keymap.set('n', '<leader>r', function()
        require('conform').format { async = true, lsp_fallback = true }
      end, { desc = '[F]ormat buffer' })
    end,
  },
}

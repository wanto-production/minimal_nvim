return {
  {
    'b0o/schemastore.nvim',
  },

  {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function()
      local utils = require('utils.function')
      ---@param opt vim.keymap.set.Opts
      local keymap = function(mode, lhs, rhs, opt)
        return vim.keymap.set(mode, lhs, rhs, { desc = '[Lsp]: ' .. opt.desc, silent = opt.silent })
      end


      keymap('n', '<leader>lr', utils.reload_lsp, { desc = 'reload' })
      keymap('n', '<leader>la', utils.code_action, { desc = 'code action' })
    end,
  },
}

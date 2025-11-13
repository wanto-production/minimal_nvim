return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      direction = 'float',
      size = 20,
      hide_numbers = true,
      start_in_insert = true,
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved',
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
      },
    }

    vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })
  end,
}

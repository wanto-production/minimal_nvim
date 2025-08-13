vim.api.nvim_create_autocmd('TextYankPost', {
  -- Optional. You can alse set your own keybindings
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- insert
vim.keymap.set('i', '<A-Up>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up', noremap = true, silent = true })
vim.keymap.set('i', '<A-Down>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line down', noremap = true, silent = true })

-- visual
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down', noremap = true, silent = true })
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up', noremap = true, silent = true })

-- normal
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==', { desc = 'Move line up', noremap = true, silent = true })
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==', { desc = 'Move line down', noremap = true, silent = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true })
-- campuran
vim.keymap.set({ 'n', 'v' }, 'd', '"_d', { noremap = true })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', function()
  if vim.bo.modified then
    vim.cmd 'write'
    vim.notify('file saved', vim.log.levels.INFO, { title = 'files' })
  else
    vim.notify('nothing to save', vim.log.levels.WARN, { title = 'files' })
  end
end, { desc = 'Save file', silent = true })

local utils = require 'utils.function'
local keymap = vim.keymap

vim.api.nvim_create_autocmd('TextYankPost', {
  -- Optional. You can alse set your own keybindings
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    opts.desc = '[Lsp] reload'
    keymap.set('n', '<leader>lr', utils.reload_lsp, opts)

    opts.desc = '[Lsp] code action'
    keymap.set('n', '<leader>la', utils.code_action, opts)
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local is_node_project = vim.fn.filereadable 'package.json' == 1
    local is_deno_project = vim.fn.filereadable 'deno.json' == 1

    -- Stop `denols` in Node.js projects
    if client.name == 'denols' and is_node_project then
      client.stop()
    end

    -- Stop `tsserver` in Deno projects
    if client.name == 'ts_ls' and is_deno_project then
      client.stop()
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'svelte' }, -- Ganti dengan bahasa yang kamu gunakan
  callback = function()
    vim.treesitter.start()
  end,
})

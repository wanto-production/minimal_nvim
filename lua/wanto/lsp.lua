local utils = require('utils.function')
local keymap = vim.keymap -- for conciseness

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    opts.desc = "Reload LSP"
    keymap.set('n', '<leader>lr', utils.reload_lsp, opts)

    opts.desc = "Code Action LSP"
    keymap.set('n', '<leader>la', utils.code_action, opts)
  end,
})

-- vim.lsp.inlay_hint.enable(true)
local severity = vim.diagnostic.severity

vim.diagnostic.config({
  signs = {
    text = {
      [severity.ERROR] = " ",
      [severity.WARN] = " ",
      [severity.HINT] = "󰠠 ",
      [severity.INFO] = " ",
    },
  },
})

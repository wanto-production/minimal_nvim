return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  ---@module 'noice.config'
  ---@type NoiceConfig
  opts = {
    lsp = {
      progress = {
        enabled = true,
      },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    cmdline = {
      enabled = true,
      view = 'cmdline_popup', -- or "cmdline"
    },
    views = {
      cmdline_popup = {
        border = { style = 'rounded' },
        position = {
          row = '10%',
          col = '50%',
        },
        size = {
          width = 60,
          height = 'auto',
        },
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
    },
  },
}

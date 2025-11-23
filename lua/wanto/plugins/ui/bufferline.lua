return {
  'akinsho/bufferline.nvim',
  event = { 'BufEnter', 'VeryLazy' }, -- atau "UIEnter"
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('bufferline').setup {
      -- highlights = require('tokyonight.groups.integrations.bufferline').get(),
      options = {
        mode = 'buffers',
        numbers = 'ordinal',
        diagnostics = 'nvim_lsp',
        show_buffer_icons = true,
        show_close_icon = false,
        show_buffer_close_icons = false,
        always_show_bufferline = true,
        diagnostics_indicator = function(count, level, _, _)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,
        offsets = {
          {
            filetype = 'neo-tree', -- penting! sesuai filetype Neo-tree
            highlight = 'Directory',
            text_align = 'left',
            separator = true,
          },
          {
            filetype = 'snacks_layout_box',
            text = '󰙅  File Explorer',
            separator = true,
          },
        },
      },
    }

    -- Keymaps
    vim.keymap.set('n', '[b', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Prev Buffer' })
    vim.keymap.set('n', ']b', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next Buffer' })
  end,
}

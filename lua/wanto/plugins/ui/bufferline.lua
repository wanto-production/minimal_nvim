return {
  'akinsho/bufferline.nvim',
  event = { 'BufEnter', 'VeryLazy' }, -- atau "UIEnter"
  config = function()
    require('bufferline').setup {
      highlights = require('catppuccin.special.bufferline').get_theme(),
      options = {
        get_element_icon = function(element)
          if element.filetype and element.filetype ~= '' then
            local icon, hl = require('mini.icons').get('filetype', element.filetype)
            return icon, hl
          elseif element.path and element.path ~= '' then
            local icon, hl = require('mini.icons').get('file', element.path)
            return icon, hl
          end
          return '', ''
        end,
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
            text = '󰙅  File Explorer',
          },
          {
            filetype = 'snacks_layout_box',
            text = '󰙅  File Explorer',
            separator = true,
          },
        },
      },
    }
  end,
}

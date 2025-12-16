return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter', -- start only on insert to speed up startup
    version = '1.*',
    build = 'cargo build --release',
    dependencies = {
      {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
          require('nvim-autopairs').setup {}
        end,
      },
      { 'folke/lazydev.nvim', ft = 'lua' },
      { 'b0o/schemastore.nvim' },
      'echasnovski/mini.icons', -- ✅ Hanya mini.icons
    },
    opts = function()
      local mini_icons = require 'mini.icons'
      local capabilities = require('blink-cmp').get_lsp_capabilities()

      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      return {
        keymap = {
          ['<CR>'] = { 'accept', 'fallback' },
        },
        appearance = { nerd_font_variant = 'mono' },
        completion = {
          documentation = {
            auto_show = true,
            window = {
              border = 'single',
            },
          },
          menu = {
            border = 'single',
            draw = {
              components = {
                kind_icon = {
                  text = function(ctx)
                    local icon = ''

                    if ctx.source_name == 'Path' then
                      icon = mini_icons.get('file', ctx.label)
                    else
                      icon = mini_icons.get('lsp', ctx.kind)
                    end

                    return (icon or '') .. ctx.icon_gap
                  end,
                  highlight = function(ctx)
                    if ctx.source_name == 'Path' then
                      local _, hl = mini_icons.get('file', ctx.label)
                      return hl
                    end

                    return ctx.kind_hl
                  end,
                },
              },
            },
          },
        },
        sources = {
          default = { 'lsp', 'path', 'lazydev' },
          providers = {
            lazydev = {
              module = 'lazydev.integrations.blink',
              score_offset = 100,
            },
          },
        },
        fuzzy = {
          implementation = 'lua',
        },
        signature = { enabled = true },
      }
    end,
  },
}

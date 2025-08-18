return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter', -- start only on insert to speed up startup
    version = '1.*',
    build = 'cargo build --release',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        event = 'InsertEnter',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
          require('nvim-autopairs').setup {}
        end,
      },
      {
        'rafamadriz/friendly-snippets',
        event = 'InsertEnter',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
      { 'folke/lazydev.nvim', ft = 'lua' },
      'onsails/lspkind.nvim',
    },
    opts = function()
      local devicons = require 'nvim-web-devicons'
      local lspkind = require 'lspkind'

      return {
        keymap = {
          ['<CR>'] = { 'accept', 'fallback' },
        },
        appearance = { nerd_font_variant = 'mono' },
        completion = {
          documentation = { auto_show = false, auto_show_delay_ms = 500 },
          menu = {
            border = 'rounded',
            draw = {
              components = {
                kind_icon = {
                  text = function(ctx)
                    local icon
                    if ctx.source_name == 'Path' then
                      local dev_icon = devicons.get_icon(ctx.label)
                      icon = dev_icon or ''
                    else
                      icon = lspkind.symbolic(ctx.kind, { mode = 'symbol' }) or ''
                    end
                    return icon .. ctx.icon_gap
                  end,
                  highlight = function(ctx)
                    if ctx.source_name == 'Path' then
                      local _, hl = devicons.get_icon(ctx.label)
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
          default = { 'lsp', 'path', 'snippets', 'lazydev' },
          providers = {
            lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
          },
        },
        snippets = { preset = 'luasnip' },
        fuzzy = {
          implementation = 'prefer_rust_with_warning', -- Atur mode fuzzy
        },
        signature = { enabled = true },
      }
    end,
  },
}

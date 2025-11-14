return {
  'folke/snacks.nvim',
  priority = 1000,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('snacks').setup {
      picker = {
        sources = {
          explorer = {
            layout = {
              layout = {
                width = 27,
                position = 'right',
              },
            },
          },
          files = {
            hidden = true,
            ignored = true,
            exclude = {
              'node_modules',
              'vendor',
            },
          },
        },
        hidden = true,
        ignored = true,
      },
      notifier = {
        enabled = true,
        timeout = 3000,
        width = { min = 40, max = 0.4 }, -- lebar min/max
        height = { min = 1, max = 0.6 }, -- tinggi min/max
        margin = { top = 0, right = 1, bottom = 0 }, -- margin dari edge
        padding = true, -- padding dalam notifikasi
        sort = { 'level', 'added' }, -- urutan sorting
        animate = { enabled = true },
        -- Styling untuk setiap level
        level = {
          error = {
            hl = 'DiagnosticError',
            icon = ' ',
          },
          warn = {
            hl = 'DiagnosticWarn',
            icon = ' ',
          },
          info = {
            hl = 'DiagnosticInfo',
            icon = ' ',
          },
          debug = {
            hl = 'DiagnosticHint',
            icon = ' ',
          },
        },
        style = 'fancy', -- "compact" | "minimal" | "fancy"
        top_down = false, -- notif muncul dari bawah ke atas
      },
      image = {
        enabled = true,
        formats = {
          'png',
          'jpg',
          'jpeg',
          'gif',
          'bmp',
          'webp',
          'tiff',
          'heic',
          'avif',
          'mp4',
          'mov',
          'avi',
          'mkv',
          'webm',
          'pdf',
          'ico',
        },
        convert = { notify = true },
        doc = { enabled = false },
        cache = vim.fn.stdpath 'cache' .. '/snacks/image',
      },
      indent = {
        indent = {
          priority = 1,
          enabled = true, -- enable indent guides
          char = '│',
          only_scope = false, -- only show indent guides of the scope
          only_current = false, -- only show indent guides in the current window
          hl = 'SnacksIndent', ---@type string|string[] hl groups for indent guides
          -- can be a list of hl groups to cycle through
          -- hl = {
          --     "SnacksIndent1",
          --     "SnacksIndent2",
          --     "SnacksIndent3",
          --     "SnacksIndent4",
          --     "SnacksIndent5",
          --     "SnacksIndent6",
          --     "SnacksIndent7",
          --     "SnacksIndent8",
          -- },
        },
        ---@class snacks.indent.animate: snacks.animate.Config
        animate = {
          enabled = vim.fn.has 'nvim-0.10' == 1,
          style = 'out',
          easing = 'linear',
          duration = {
            step = 20, -- ms per step
            total = 500, -- maximum duration
          },
        },
        ---@class snacks.indent.Scope.Config: snacks.scope.Config
        scope = {
          enabled = true, -- enable highlighting the current scope
          priority = 200,
          char = '│',
          underline = false, -- underline the start of the scope
          only_current = false, -- only show scope in the current window
          hl = 'SnacksIndentScope', ---@type string|string[] hl group for scopes
        },
        chunk = {
          -- when enabled, scopes will be rendered as chunks, except for the
          -- top-level scope which will be rendered as a scope.
          enabled = false,
          -- only show chunk scopes in the current window
          only_current = false,
          priority = 200,
          hl = 'SnacksIndentChunk', ---@type string|string[] hl group for chunk scopes
          char = {
            corner_top = '┌',
            corner_bottom = '└',
            -- corner_top = "╭",
            -- corner_bottom = "╰",
            horizontal = '─',
            vertical = '│',
            arrow = '>',
          },
        },
        -- filter for buffers to enable indent guides
        filter = function(buf)
          return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ''
        end,
      },
      explorer = { enabled = true },
      dashboard = { enabled = true },
      layout = {
        sidebar = {
          position = 'right',
        },
      },
    }

    local function keymap(mode, key, fn, opts)
      vim.keymap.set(mode, key, fn, { desc = '[Snacks] ' .. opts.desc })
    end

    keymap('n', '<leader>bd', function()
      Snacks.bufdelete.delete()
    end, { desc = 'Safe Delete Buffer' })
    keymap('n', '<leader>e', function()
      Snacks.explorer.open()
    end, { desc = 'Toggle Explorer' })
    keymap('n', '<leader>sf', function()
      Snacks.picker.files()
    end, { desc = 'pickers files' })
    keymap('n', '<leader>sn', function()
      Snacks.picker.notifications()
    end, { desc = 'pickers notifications' })
    keymap('n', '<leader>sb', function()
      Snacks.picker.buffers()
    end, { desc = 'pickers buffers' })
  end,
}

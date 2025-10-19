return {
  'folke/snacks.nvim',
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
      explorer = { enabled = true },
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
      layout = {
        sidebar = {
          position = 'right',
        },
      },
    }

    local function keymap(mode, key, fn, opts)
      vim.keymap.set(mode, key, fn, { desc = '[Snacks] ' .. opts.desc })
    end

    keymap('n', '<leader>e', function()
      Snacks.explorer.open()
    end, { desc = 'Toggle Explorer' })
    keymap('n', '<leader>tt', function()
      Snacks.terminal.toggle()
    end, { desc = 'Toggle Terminal' })
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

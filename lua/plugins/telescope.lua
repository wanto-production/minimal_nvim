return {
  'nvim-telescope/telescope.nvim',
  event = { 'BufEnter' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local telescope = require 'telescope'

    telescope.setup {
      defaults = {
        prompt_prefix = '   ',
        selection_caret = ' ',
        path_display = { 'smart' },
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            preview_width = 0.5,
            width = 0.5,
          },
          vertical = { mirror = false },
          prompt_position = 'top',
        },
        file_ignore_patterns = {
          'node_modules',
          '.git',
          'dist',
          'build',
        },
        mappings = {
          i = {
            ['<C-j>'] = 'move_selection_next',
            ['<C-k>'] = 'move_selection_previous',
            ['<C-q>'] = require('telescope.actions').send_to_qflist,
            ['<Esc>'] = require('telescope.actions').close,
          },
        },
      },
      pickers = {
        find_files = { hidden = true },
        live_grep = {
          additional_args = function()
            return { '--hidden' }
          end,
        },
      },
    }

    -- Load FZF extension (biar search lebih cepat & akurat)
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'notify')

    -- Keymaps
    local function keymap(mode, key, fn, opts)
      vim.keymap.set(mode, key, fn, { desc = '[Search]' .. opts.desc })
    end

    local builtin = require 'telescope.builtin'
    keymap('n', '<leader>sf', builtin.find_files, { desc = ' Files' })
    keymap('n', '<leader>sk', builtin.keymaps, { desc = ' Keymaps' })
    keymap('n', '<leader>sn', function()
      require('telescope').extensions.notify.notify()
    end, { desc = ' notify history' })
  end,
}

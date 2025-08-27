return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  lazy = false, -- penting: biar load di startup
  priority = 1000,
  config = function()
    require('neo-tree').setup {
      window = {
        position = 'right',
        width = 25,
      },
      default_component_configs = {
        indent = { indent_size = 1, padding = 0 },
        ---@diagnostic disable-next-line : missing-fields
        icon = { padding = ' ' },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
    }

    vim.keymap.set('n', '<leader>e', function()
      require('neo-tree.command').execute { toggle = true, dir = vim.fn.expand '%:p:h' }
    end, { desc = 'Toggle Neo-tree at file dir' })
  end,
}

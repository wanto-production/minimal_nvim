if vim.g.laravel == false then
  return {}
end
return {
  'adalessa/laravel.nvim',
  dependencies = {
    'tpope/vim-dotenv',
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-neotest/nvim-nio',
    'ravitemer/mcphub.nvim', -- optional
  },
  cmd = { 'Laravel' },
  keys = {
    {
      '<leader>ll',
      function()
        Laravel.pickers.laravel()
      end,
      desc = 'Laravel: Open Laravel Picker',
    },
    {
      '<leader>la',
      function()
        Laravel.pickers.artisan()
      end,
      desc = 'Laravel: Open Artisan Picker',
    },
    {
      '<leader>lt',
      function()
        Laravel.commands.run 'actions'
      end,
      desc = 'Laravel: Open Actions Picker',
    },
    {
      '<leader>lr',
      function()
        Laravel.pickers.routes()
      end,
      desc = 'Laravel: Open Routes Picker',
    },
    {
      '<leader>lh',
      function()
        Laravel.run 'artisan docs'
      end,
      desc = 'Laravel: Open Documentation',
    },
    {
      '<leader>lm',
      function()
        Laravel.pickers.make()
      end,
      desc = 'Laravel: Open Make Picker',
    },
    {
      '<leader>lc',
      function()
        Laravel.pickers.commands()
      end,
      desc = 'Laravel: Open Commands Picker',
    },
    {
      '<leader>lo',
      function()
        Laravel.pickers.resources()
      end,
      desc = 'Laravel: Open Resources Picker',
    },
    {
      '<leader>lp',
      function()
        Laravel.commands.run 'command_center'
      end,
      desc = 'Laravel: Open Command Center',
    },
  },
  event = { 'VeryLazy' },
  config = function()
    require('laravel').setup {
      lsp_server = 'intelephense', -- "phpactor | intelephense"
      features = {
        pickers = {
          provider = 'snacks', -- "snacks | telescope | fzf-lua | ui-select"
        },
      },
    }
  end,
}

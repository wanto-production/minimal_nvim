return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup {
        preset = 'modern',
        icons = {
          mappings = vim.g.have_nerd_font,
          keys = vim.g.have_nerd_font and {} or {
            Up = '<Up> ',
            Down = '<Down> ',
            Left = '<Left> ',
            Right = '<Right> ',
            C = '<C-…> ',
            M = '<M-…> ',
            D = '<D-…> ',
            S = '<S-…> ',
            CR = '<CR> ',
            Esc = '<Esc> ',
            ScrollWheelDown = '<ScrollWheelDown> ',
            ScrollWheelUp = '<ScrollWheelUp> ',
            NL = '<NL> ',
            BS = '<BS> ',
            Space = '<Space> ',
            Tab = '<Tab> ',
            F1 = '<F1>',
            F2 = '<F2>',
            F3 = '<F3>',
            F4 = '<F4>',
            F5 = '<F5>',
            F6 = '<F6>',
            F7 = '<F7>',
            F8 = '<F8>',
            F9 = '<F9>',
            F10 = '<F10>',
            F11 = '<F11>',
            F12 = '<F12>',
          },
        },

        win = {
          padding = { 1, 2 },
        },

        -- pakai spec, bukan panggil manual di keymap
        spec = {
          { '<leader>s', group = '[S]earch' },
          { '<leader>t', group = '[T]oggle' },
          { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        },
      }

      require('which-key').add {
        mode = { 'v' },
        { '<leader>s', group = 'Silicon' },
        {
          '<leader>sc',
          function()
            require('nvim-silicon').clip()
          end,
          desc = 'Copy code screenshot to clipboard',
        },
        {
          '<leader>sf',
          function()
            require('nvim-silicon').file()
          end,
          desc = 'Save code screenshot as file',
        },
        {
          '<leader>ss',
          function()
            require('nvim-silicon').shoot()
          end,
          desc = 'Create code screenshot',
        },
      }
    end,
  },
}

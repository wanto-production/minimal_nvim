return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      shell = 'fish',
      size = 20,
      open_mapping = [[<leader>tt]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      direction = 'float', -- biar float
      float_opts = {
        border = 'curved', -- bisa: single, double, shadow, curved
        winblend = 3,
      },
    }
  end,
}

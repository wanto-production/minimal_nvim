return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      shell = 'fish',
      size = 20,
      --open_mapping = [[<leader>tt]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      direction = 'float', -- biar float
      float_opts = {
        border = 'curved', -- bisa: single, double, shadow, curved
        winblend = 3,
      },
    }

    local Terminal = require('toggleterm.terminal').Terminal

    -- simpan list terminal
    local terminals = {}

    -- fungsi buat toggle terminal tertentu
    local function toggle_term(id)
      if not terminals[id] then
        terminals[id] = Terminal:new { count = id, direction = 'float' } -- bisa 'horizontal' / 'vertical' juga
      end
      terminals[id]:toggle()
    end

    -- bikin keymap kayak bufferline
    for i = 1, 5 do -- atur berapa maksimal terminal yang mau kamu pakai
      vim.keymap.set('n', ('<leader>t%s'):format(i), function()
        toggle_term(i)
      end, { desc = 'Toggle terminal ' .. i })
    end
  end,
}

-- lua/plugins/notify.lua
return {
  'rcarriga/nvim-notify',
  config = function()
    local notify = require 'notify'

    notify.setup {
      stages = 'slide', -- animasi halus
      timeout = 2000, -- waktu tampil (ms)
      background_colour = '#000000', -- warna background
      render = 'default',
    }

    vim.notify = notify
  end,
}

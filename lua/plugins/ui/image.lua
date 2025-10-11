return {
  {
    '3rd/image.nvim',
    config = function()
      require('image').setup {
        backend = 'kitty', -- atau "ueberzug", "iterm", tergantung terminalmu
        kitty_method = 'normal',
        integrations = {
          markdown = {
            enabled = true,
            only_render_image_at_cursor = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = 50,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false, -- biar nggak kedip pas ada window lain
        window_overlap_clear_ft_ignore = {
          'cmp_menu',
          'cmp_docs',
          'snacks_notif',
          'scrollview',
          'scrollview_sign',
        },
        editor_only_render_when_focused = false,
        tmux_show_only_in_active_window = false,
        hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' },
        scale_factor = 1.0,
      }
    end,
  },
}

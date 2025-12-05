return {
  'gisketch/triforce.nvim',
  event = { 'BufEnter' },
  dependencies = { 'nvzone/volt' },
  config = function()
    require('triforce').setup {
      enabled = true, -- Enable/disable the entire plugin
      gamification_enabled = true, -- Enable XP, levels, achievements
      notifications = {
        enabled = true, -- Master toggle for all notifications
        level_up = true, -- Show level up notifications
        achievements = true, -- Show achievement unlock notifications
      },
      keymap = {
        show_profile = '<leader>tp', -- Set to nil to disable default keymap
      },
      auto_save_interval = 300, -- Save stats every 5 minutes
      level_progression = {
        tier_1 = { min_level = 1, max_level = 10, xp_per_level = 300 }, -- Levels 1-10
        tier_2 = { min_level = 11, max_level = 20, xp_per_level = 500 }, -- Levels 11-20
        tier_3 = { min_level = 21, max_level = math.huge, xp_per_level = 1000 }, -- Levels 21+
      },
      xp_rewards = {
        char = 1, -- XP per character typed
        line = 1, -- XP per new line
        save = 50, -- XP per file save
      },
      heat_highlights = {
        TriforceHeat1 = '#f0f0a0',
        TriforceHeat2 = '#f0a0a0',
        TriforceHeat3 = '#a0a0a0',
        TriforceHeat4 = '#707070',
      },
    }
  end,
}

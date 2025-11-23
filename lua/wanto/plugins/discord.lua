return {
  {
    'vyfor/cord.nvim',
    lazy = true,
    build = ':Cord update',
    config = function()
      require('cord').setup {
        editor = {
          client = 'neovim',
          tooltip = 'ngoding dulu le',
        },
        display = {
          theme = 'catppuccin',
          flavor = 'dark',
        },
        buttons = {
          {
            label = 'View My Github',
            url = 'https://github.com/wanto-production',
          },
          {
            label = 'View My Portofolio',
            url = 'https://portofolio-wanto.vercel.app',
          },
        },
      }
    end,
  },
}

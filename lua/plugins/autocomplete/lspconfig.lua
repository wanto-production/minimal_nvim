local utils = require 'utils.function'

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'b0o/schemastore.nvim',
    },
    config = function()
      local servers = require 'users.lspconfigs'

      --- NOTE: typescript plugins
      servers.vtsls.settings.vtsls.tsserver = servers.vtsls.settings.vtsls.tsserver or {}
      servers.vtsls.settings.vtsls.tsserver.globalPlugins = servers.vtsls.settings.vtsls.tsserver.globalPlugins or {}
      vim.list_extend(servers.vtsls.settings.vtsls.tsserver.globalPlugins, {
        {
          name = 'typescript-svelte-plugin',
          location = utils:get_pkg_path('svelte-language-server', '/node_modules/typescript-svelte-plugin'),
          enableForWorkspaceTypeScriptVersions = true,
        },
        {
          name = '@astrojs/ts-plugin',
          location = utils:get_pkg_path('astro-language-server', '/node_modules/@astrojs/ts-plugin'),
          enableForWorkspaceTypeScriptVersions = true,
        },
        {
          name = '@vue/typescript-plugin',
          location = utils:get_pkg_path('vue-language-server', '/node_modules/@vue/language-server'),
          languages = { 'vue' },
          configNamespace = 'typescript',
          enableForWorkspaceTypeScriptVersions = true,
        },
      })

      vim.keymap.set('n', '<leader>rl', utils.reload_lsp, { desc = 'reload lsp' })

      for server, config in pairs(servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        vim.lsp.config[server] = config
        vim.lsp.enable(server)
      end
    end,
  },
}

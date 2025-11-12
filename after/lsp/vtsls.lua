-- ~/.config/nvim/after/lsp/vtsls.lua
local utils = require("utils.function")

local globalPlugins = {
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
  }
}

return {
  root_dir = vim.fs.root(0, { "package.json", "node_modules" }),
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = { enableServerSideFuzzyMatch = true },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = 'always' },
      suggest = { completeFunctionCalls = true },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
    tsserver = {
      globalPlugin = globalPlugins
    }
  },
}

local utils = require 'utils.function'

local additional_plugins = {
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
}

local lsp = { 'lua_ls', 'vtsls', 'svelte', 'taplo', 'jsonls', 'yamlls', 'astro', 'tailwindcss', 'vue_ls' }

vim.lsp.enable(lsp)

vim.lsp.config['lua_ls'] = {
  cmd = { 'lua-language-server' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false, -- Disable annoying prompt
      },
      telemetry = { enable = false },
      hint = {
        arrayIndex = 'Disable',
      },
    },
  },
}

vim.lsp.config['tailwindcss'] = {
  on_attach = function(client, bufnr)
    local ft = vim.bo[bufnr].filetype
    local fname = vim.api.nvim_buf_get_name(bufnr)

    -- Stop LSP untuk TS/JS yang bukan Angular component/page
    if ft == 'typescript' or ft == 'javascript' or ft == 'typescriptreact' or ft == 'javascriptreact' then
      if not (fname:match '%.page%.ts$' or fname:match '%.component%.ts$' or fname:match 'app%.ts$') then
        vim.schedule(function()
          vim.lsp.buf_detach_client(bufnr, client.id)
        end)
        return
      end
    end

    -- Optional: keybindings
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  end,
}

vim.lsp.config['vtsls'] = {
  root_markers = { 'package.json' },
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
      tsserver = {
        globalPlugins = additional_plugins,
      },
    },
    typescript = {
      tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib',
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
  },
}

vim.lsp.config['jsonls'] = {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

vim.lsp.config['yamlls'] = {
  settings = {
    json = {
      schemas = require('schemastore').yaml.schemas(),
      validate = { enable = true },
    },
  },
}

vim.lsp.config['svelte'] = {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = { dynamicRegistration = false },
    },
  },
}

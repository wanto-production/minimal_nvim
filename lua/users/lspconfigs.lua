---@type vim.lsp.Config
return {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = {
          library = {
            vim.fn.expand '~/.love-api',
            vim.fn.expand '$VIMRUNTIME/lua',
            vim.fn.stdpath 'config' .. '/lua',
          },
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  },

  vtsls = {
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
    },
  },

  svelte = {
    capabilities = {
      workspace = {
        didChangeWatchedFiles = { dynamicRegistration = false },
      },
    },
  },

  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },

  yamlls = {
    settings = {
      yaml = {
        schemas = require('schemastore').yaml.schemas(),
        validate = { enable = true },
      },
    },
  },

  vue_ls = {
    settings = {
      vue = {
        hybrideMode = true,
      },
    },
  },

  taplo = {
    settings = {
      evenBetterToml = {
        schema = {
          enable = true,
          associations = {
            ['starship.toml'] = 'https://starship.rs/config-schema.json',
          },
        },
      },
    },
  },

  tailwindcss = {
    on_attach = function(client, bufnr)
      local ft = vim.bo[bufnr].filetype
      local fname = vim.api.nvim_buf_get_name(bufnr)

      if ft == 'typescript' or ft == 'javascript' then
        if not (fname:match '%.page.ts$' or fname:match '%.component.ts$' or fname:match 'app.ts$') then
          client.stop() -- stop semua TS/JS yang bukan Angular component/page
        end
      end
    end,
  },

  gleam = {
    cmd = { vim.fn.expand '~/.asdf/shims/gleam', 'lsp' },
    filetypes = { 'gleam' },
    on_attach = function(_, bufnr)
      -- Keybindings
      local opts = { buffer = bufnr, noremap = true, silent = true }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

      -- Enable completion triggered by <c-x><c-o>
      vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

      print('✓ Gleam LSP attached to buffer ' .. bufnr)
    end,
  },

  dartls = {},
  astro = {},
  prismals = {},
}

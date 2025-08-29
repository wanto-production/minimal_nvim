local function get_pkg_path(pkg, subpath)
  local base = vim.fn.stdpath 'data' .. '/mason/packages/' .. pkg
  if subpath then
    base = base .. subpath
  end
  return base
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'b0o/schemastore.nvim',
    },
    config = function()
      local lspconfig = require 'lspconfig'

      ---@alias LspServerConfig { cmd?: string[] } | lspconfig.Config
      ---@type table<string, LspServerConfig>
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              diagnostics = { globals = { 'vim' } },
              workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
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
                globalPlugins = {
                  {
                    name = 'typescript-svelte-plugin',
                    location = get_pkg_path('svelte-language-server', '/node_modules/typescript-svelte-plugin'),
                    enableForWorkspaceTypeScriptVersions = true,
                  },
                  {
                    name = '@astrojs/ts-plugin',
                    location = get_pkg_path('astro-language-server', '/node_modules/@astrojs/ts-plugin'),
                    enableForWorkspaceTypeScriptVersions = true,
                  },
                },
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

        astro = {},
        tailwindcss = {},
      }

      for server, config in pairs(servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
}

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
      ---@type vim.lsp.Config
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
                  {
                    name = '@vue/typescript-plugin',
                    location = get_pkg_path('vue-language-server', '/node_modules/@vue/language-server'),
                    languages = { 'vue' },
                    configNamespace = 'typescript',
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

        roslyn = {
          settings = {
            ['csharp|inlay_hints'] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_implicit_variable_types = true,
            },
            ['csharp|code_lens'] = {
              dotnet_enable_references_code_lens = true,
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

        astro = {},
        tailwindcss = {},
      }

      for server, config in pairs(servers) do
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        vim.lsp.config[server] = config
        vim.lsp.enable(server)
      end
    end,
  },
}

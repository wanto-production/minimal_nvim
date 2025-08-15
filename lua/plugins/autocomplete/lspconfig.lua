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
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      opts.servers.lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT', -- versi Lua untuk Neovim
            },
            diagnostics = {
              globals = { 'vim' }, -- menghindari peringatan "undefined global 'vim'"
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }

      opts.servers.vtsls = {
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
              completion = {
                enableServerSideFuzzyMatch = true,
              },
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
            suggest = {
              completeFunctionCalls = true,
            },
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

      -- svelte
      opts.servers.svelte = {
        capabilities = {
          workspace = {
            didChangeWatchedFiles = vim.fn.has 'nvim-0.10' == 0 and { dynamicRegistration = true },
          },
        },
      }

      opts.servers.jsonls = {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      }

      opts.servers.astro = {}
      opts.servers.tailwindcss = {}

      if opts.servers.tailwindcss.filetypes ~= nil and #opts.servers.tailwindcss.filetypes > 0 then
        for i = #opts.servers.tailwindcss.filetypes, 1, -1 do
          if opts.servers.tailwindcss.filetypes[i] == 'javascript' or opts.servers.tailwindcss.filetypes[i] == 'typescript' then
            table.remove(opts.servers.tailwindcss.filetypes, i)
          end
        end
      end
      return opts
    end,
    config = function(_, opts)
      local lspconfig = require 'lspconfig'

      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
}

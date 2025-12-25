local utils = require 'utils.function'

-- ============================================================================
-- TypeScript/JavaScript Plugins
-- ============================================================================
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
    name = '@angular/language-server',
    location = utils:get_pkg_path('angular-language-server', '/node_modules/@angular/language-server'),
    enableForWorkspaceTypeScriptVersions = false,
  },
  {
    name = '@vue/typescript-plugin',
    location = utils:get_pkg_path('vue-language-server', '/node_modules/@vue/language-server'),
    languages = { 'vue' },
    configNamespace = 'typescript',
    enableForWorkspaceTypeScriptVersions = true,
  },
}

-- ============================================================================
-- Enable LSP Servers
-- ============================================================================
local lsp_servers = {
  'lua_ls',
  'kotlin_language_server',
  'nil_ls',
  'gopls',
  'vtsls',
  'svelte',
  'taplo',
  'jsonls',
  'yamlls',
  'astro',
  'tailwindcss',
  'vue_ls',
  'clangd',
  'jdtls',
}

vim.lsp.enable(lsp_servers)

-- ============================================================================
-- Lua Language Server
-- ============================================================================
vim.lsp.config['lua_ls'] = {
  cmd = { 'lua-language-server' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      hint = {
        arrayIndex = 'Disable',
      },
    },
  },
}

-- ============================================================================
-- TypeScript/JavaScript (vtsls)
-- ============================================================================
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
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
      tsserver = {
        globalPlugins = additional_plugins,
      },
    },
    typescript = {
      tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib',
      updateImportsOnFileMove = {
        enabled = 'always',
      },
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

-- ============================================================================
-- Java (jdtls)
-- ============================================================================
local home = os.getenv 'HOME'
local jdtls_path = home .. '/.local/share/nvim/mason/packages/jdtls'
local lombok_path = jdtls_path .. '/lombok.jar'
local workspace_dir = home .. '/.local/share/nvim/jdtls-workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

vim.lsp.config['jdtls'] = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. lombok_path,
    '-jar',
    vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration',
    jdtls_path .. '/config_linux',
    '-data',
    workspace_dir,
  },
  root_dir = vim.fs.root(0, { 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }),
  settings = {
    java = {
      autobuild = {
        enabled = true,
      },
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = 'automatic',
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
      },
    },
    signatureHelp = {
      enabled = true,
    },
    completion = {
      favoriteStaticMembers = {
        'org.junit.jupiter.api.Assertions.*',
        'java.util.Objects.requireNonNull',
        'org.mockito.Mockito.*',
      },
    },
    contentProvider = {
      preferred = 'fernflower',
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
  },
  flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
    exit_timeout = 500,
  },
  init_options = {
    bundles = {},
  },
}

-- ============================================================================
-- JSON
-- ============================================================================
vim.lsp.config['jsonls'] = {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = {
        enable = true,
      },
    },
  },
}

-- ============================================================================
-- YAML
-- ============================================================================
vim.lsp.config['yamlls'] = {
  settings = {
    yaml = {
      schemas = require('schemastore').yaml.schemas(),
      validate = true,
    },
  },
}

-- ============================================================================
-- Svelte
-- ============================================================================
vim.lsp.config['svelte'] = {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = false,
      },
    },
  },
}

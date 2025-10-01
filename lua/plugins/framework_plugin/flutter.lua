return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional untuk ui select
  },
  config = function()
    require('flutter-tools').setup {
      ui = {
        border = 'rounded',
        notification_style = 'plugin',
      },
      decorations = {
        statusline = {
          app_version = true, -- tampilkan versi app
          device = true, -- tampilkan device
          project_config = true,
        },
      },
      debugger = {
        enabled = true, -- aktifkan kalau kamu juga pakai nvim-dap
        run_via_dap = false,
        exception_breakpoints = {},
        evaluate_to_string_in_debug_views = true,
      },
      flutter_path = vim.fn.exepath 'flutter', -- auto cari flutter di PATH
      flutter_lookup_cmd = nil,
      root_patterns = { '.git', 'pubspec.yaml' },
      fvm = true, -- biar otomatis pake flutter sdk dari fvm kalau ada
      default_run_args = { 'run', '--no-version-check' },
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        highlight = 'Comment',
        prefix = '//',
        priority = 10,
        enabled = true,
      },
      dev_log = {
        enabled = true,
        open_cmd = '10split',
        focus_on_open = false,
      },
      dev_tools = {
        autostart = true,
        auto_open_browser = false, -- matikan biar ga ganggu
      },
      outline = {
        open_cmd = '30vnew',
        auto_open = false,
      },
      lsp = {
        color = {
          enabled = true,
          background = true,
          foreground = true,
          virtual_text = true,
          virtual_text_str = '■',
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = 'prompt',
          enableSnippets = true,
          updateImportsOnRename = true,
        },
      },
    }
  end,
}

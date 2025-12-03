return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = function()
    -- Fungsi untuk menampilkan nama LSP yang aktif
    local function lsp_names()
      local clients = vim.lsp.get_clients { bufnr = 0 }
      if not clients or vim.tbl_isempty(clients) then
        return '󰌘 None'
      end
      local names = {}
      for _, client in pairs(clients) do
        table.insert(names, client.name)
      end
      return '󰌘  ' .. table.concat(names, ', ')
    end

    return {
      options = {
        theme = 'catppuccin',
        globalstatus = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' }, -- NvChad style
        disabled_filetypes = {
          statusline = { 'NvimTree', 'alpha' },
          winbar = {},
        },
        refresh = {
          statusline = 1000,
        },
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(str)
              return str:sub(1, 1) -- Hanya tampilkan huruf pertama
            end,
          },
        },
        lualine_b = {
          'branch',
          {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = ' ' },
          },
        },
        lualine_c = {
          {
            'filename',
            file_status = true,
            path = 0, -- 0 = nama file saja, 1 = relative path, 2 = absolute path
            symbols = {
              modified = ' [+]',
              readonly = ' [-]',
              unnamed = '[No Name]',
            },
          },
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            sections = { 'error', 'warn', 'info', 'hint' },
            diagnostics_color = {
              error = { fg = '#f7768e' },
              warn = { fg = '#e0af68' },
              info = { fg = '#7dcfff' },
              hint = { fg = '#1abc9c' },
            },
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = '󰌵 ',
            },
            colored = true,
            update_in_insert = false,
            always_visible = false,
          },
        },
        lualine_x = {
          {
            lsp_names,
            icon = '',
            color = { fg = '#7aa2f7', gui = 'bold' },
          },
          'encoding',
          {
            'fileformat',
            symbols = {
              unix = 'LF',
              dos = 'CRLF',
              mac = 'CR',
            },
          },
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'lazy', 'neo-tree', 'toggleterm', 'nvim-dap-ui', 'nvim-tree', 'quickfix' },
    }
  end,
}

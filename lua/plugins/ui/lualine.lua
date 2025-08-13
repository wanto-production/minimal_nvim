return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  opts = function()
    local function lsp_names()
      local clients = vim.lsp.get_clients { bufnr = 0 }
      if not clients or vim.tbl_isempty(clients) then
        return 'Lsp: [None]'
      end
      local names = {}
      for _, client in pairs(clients) do
        table.insert(names, client.name)
      end
      return 'Lsp: [' .. table.concat(names, ', ') .. ']'
    end

    return {
      options = {
        theme = 'auto',
        globalstatus = true,
        disabled_filetypes = {},
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          'filename',
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' }, -- pakai sumber dari LSP
            sections = { 'error', 'warn', 'info', 'hint' },
            diagnostics_color = {
              error = { fg = '#ff6c6b' },
              warn = { fg = '#ECBE7B' },
              info = { fg = '#51afef' },
              hint = { fg = '#98be65' },
            },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            colored = true,
            update_in_insert = false,
            always_visible = false,
          },
        },
        lualine_x = { lsp_names, 'encoding', 'fileformat', 'filetype' },
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
      extensions = { 'lazy', 'neo-tree', 'toggleterm', 'nvim-dap-ui' },
    }
  end,
}

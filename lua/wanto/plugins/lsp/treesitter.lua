return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      {
        'windwp/nvim-ts-autotag',
        event = 'VeryLazy',
        opts = { enable_close_on_slash = false },
      },
    },
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = function(_, opts)
      opts.ensure_installed = require('users.lang').treesitter
      opts.auto_install = true
      opts.highlight = { enable = true }

      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
        pattern = { '*.component.html', '*.container.html' },
        callback = function()
          vim.treesitter.start(nil, 'angular')
        end,
      })

      ----------------------------------------------------------------
      -- Function Bracket Hints
      ----------------------------------------------------------------
      local ns = vim.api.nvim_create_namespace 'fn-bracket-hint'

      local function add_fn_hints(bufnr)
        vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

        local lang = vim.bo[bufnr].ft
        local ok, parser = pcall(vim.treesitter.get_parser, bufnr, lang)
        if not ok or not parser then
          return
        end

        local tree = parser:parse()[1]
        if not tree then
          return
        end
        local root = tree:root()

        -- Query sederhana untuk function (Lua/JS/TS/Rust)

        local query_strings = {
          lua = [[
            (function_declaration
              name: (identifier) @fn_name
              body: (block) @fn_body)
          ]],
        }
        local query_string = query_strings[lang]
        if not query_string then
          return
        end

        local ok_q, query = pcall(vim.treesitter.query.parse, lang, query_string)
        if not ok_q then
          return
        end

        for id, node in query:iter_captures(root, bufnr, 0, -1) do
          if query.captures[id] == 'fn_body' then
            local parent = node:parent()
            local name_node = nil
            for cid, cnode in query:iter_captures(root, bufnr, 0, -1) do
              if query.captures[cid] == 'fn_name' and cnode:parent() == parent then
                name_node = cnode
                break
              end
            end

            if name_node then
              local fn_name = vim.treesitter.get_node_text(name_node, bufnr)

              ---@diagnostic disable
              local end_row, end_col = parent:end_()
              local line = vim.api.nvim_buf_get_lines(bufnr, end_row, end_row + 1, false)[1]
              if line then
                local safe_col = math.min(end_col, #line)
                vim.api.nvim_buf_set_extmark(bufnr, ns, end_row, safe_col, {
                  virt_text = { { ' ← ' .. fn_name .. '()', 'Comment' } },
                  virt_text_pos = 'eol',
                })
              end
            end
          end
        end
      end

      vim.api.nvim_create_autocmd({ 'BufEnter', 'TextChanged', 'InsertLeave' }, {
        callback = function(args)
          add_fn_hints(args.buf)
        end,
      })

      return opts
    end,
  },
}

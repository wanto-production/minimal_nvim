return {
  on_attach = function(client, bufnr)
    local ft = vim.bo[bufnr].filetype
    local fname = vim.api.nvim_buf_get_name(bufnr)

    if ft == 'typescript' or ft == 'javascript' then
      if not (fname:match '%.page.ts$' or fname:match '%.component.ts$' or fname:match 'app.ts$') then
        client.stop()   -- stop semua TS/JS yang bukan Angular component/page
      end
    end
  end,

}

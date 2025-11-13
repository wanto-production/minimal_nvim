return {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = { dynamicRegistration = false },
    },
  },
  on_attach = function(client, _)
    vim.api.nvim_create_autocmd('BufWritePost', {
      pattern = { '*.js', '*.ts' },
      callback = function(ctx)
        -- Here use ctx.match instead of ctx.file
        client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
      end,
    })
  end,
}

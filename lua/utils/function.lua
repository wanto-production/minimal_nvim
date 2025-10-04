local utils = {}

-- Function untuk reload LSP
function utils:reload_lsp()
  -- Get active clients untuk buffer saat ini
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }

  if #clients == 0 then
    vim.notify('No LSP clients attached to this buffer', vim.log.levels.WARN)
    return
  end

  -- Stop semua LSP clients
  for _, client in ipairs(clients) do
    vim.notify('Stopping ' .. client.name, vim.log.levels.INFO)
    vim.lsp.stop_client(client.id)
  end

  -- Tunggu sebentar lalu restart
  vim.defer_fn(function()
    vim.cmd 'edit' -- Reload buffer untuk trigger LSP attach ulang
    vim.notify('LSP reloaded', vim.log.levels.INFO)
  end, 500)
end

function utils:get_pkg_path(pkg, subpath)
  local base = vim.fn.stdpath 'data' .. '/mason/packages/' .. pkg
  if subpath then
    base = base .. subpath
  end
  return base
end

return utils

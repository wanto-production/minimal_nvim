if vim.g.dotnet == false then
  return {}
end
return {
  'seblyng/roslyn.nvim',
  ---@module 'roslyn.config'
  ---@type RoslynNvimConfig
  opts = {
    filewatching = 'auto',
  },
}

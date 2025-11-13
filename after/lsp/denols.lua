return {
  root_dir = vim.fs.root(0, { 'deno.json' }),
  filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  init_options = {
    lint = true,
    unstable = true,
    suggest = {
      imports = {
        hosts = {
          ['https://deno.land'] = true,
          ['https://esm.sh'] = true,
        },
      },
    },
  },
}

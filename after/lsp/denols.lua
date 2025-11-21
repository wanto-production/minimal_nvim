return {
  root_markers = { 'deno.json', 'deno.jsonc' },
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

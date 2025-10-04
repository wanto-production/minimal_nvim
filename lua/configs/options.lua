vim.diagnostic.config {
  virtual_text = true,      -- Tampilkan inline error/warning
  signs = true,             -- Tampilkan icon di gutter (kiri)
  underline = false,        -- Garis bawah di teks yang error
  update_in_insert = false, -- Update diagnostic saat mode insert
  severity_sort = true,     -- Urutkan berdasarkan tingkat error
}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.lazyvim_rust_diagnostics = 'rust-analyzer'
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = false

vim.opt.wrap = false
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 5
vim.opt.laststatus = 3   -- global statusline (opsional, supaya lualine konsisten)
vim.opt.tabstop = 2      -- Lebar tab secara visual (berapa spasi)
vim.opt.shiftwidth = 2   -- Lebar indentasi saat << atau >>
vim.opt.softtabstop = 2  -- Saat menekan <Tab>, berapa spasi yang digunakan
vim.opt.expandtab = true -- Gunakan spasi daripada karakter tab
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.o.cmdheight = 0
vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true


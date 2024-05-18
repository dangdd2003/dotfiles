require "nvchad.options"

local o = vim.o
o.cursorlineopt = "both"

local opt = vim.opt
opt.title = true
opt.autoindent = true
opt.hlsearch = true
opt.showcmd = true
opt.smarttab = true
opt.relativenumber = true
opt.breakindent = true
opt.backspace = { "start", "eol", "indent" }
opt.path:append { "**" }
opt.wildignore:append { "*/node_modules/*" }
opt.formatoptions = "jcroqlnt"
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.termguicolors = true
opt.smartindent = true
opt.wrap = false
opt.cmdheight = 1
opt.spelllang = { "en" }
opt.conceallevel = 2

-- Undercurl
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]

-- Neovide (if installed)
if vim.g.neovide then
  vim.o.guifont = "Hack Nerd Font:h11"
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_vfx_mode = "railgun"
  -- vim.g.neovide_transparency = 0.7
end

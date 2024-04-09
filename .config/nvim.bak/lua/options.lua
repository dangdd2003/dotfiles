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

-- Undercurl
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]

-- Restore cursor position
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

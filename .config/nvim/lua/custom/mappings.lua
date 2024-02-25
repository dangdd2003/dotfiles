local M = {}

M.general = {
}

M.disabled = {
  n = {
    ["<leader>fb"] = "",
  }
}

M.telescope = {
  n = {
    ["<leader>sk"] = { "<cmd> Telescope keymaps <CR>", "Fine keymaps" },
    ["<leader>ff"] = { "<cmd> Telescope find_files follow=true no_ignore=true <CR>", "Find files" },
  }
}

return M

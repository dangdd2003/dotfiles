require "nvchad.mappings"
require("d-dev.discipline").cowboy()

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Toggle options
map("n", "<leader>uT", function()
  require("base46").toggle_transparency()
end, { desc = "Toggle Transparency" })

map("n", "<leader>ut", function()
  require("base46").toggle_theme()
end, { desc = "Toggle Theme" })

-- Telescope mappings
map("n", "<leader>fb", function()
  local fb_actions = require("telescope").extensions.file_browser
  fb_actions.file_browser()
end, {
  desc = "Telescope File Browser",
})

map("n", "<leader>fp", function()
  require("telescope.builtin").find_files { cwd = require("lazy.core.config").options.root }
end, { desc = "Telescope Find Plugin File" })

map("n", "<leader>fB", "<cmd>Telescope buffers<CR>", { desc = "Telescope Find Buffers" })

map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Telescope Find Keymaps" })

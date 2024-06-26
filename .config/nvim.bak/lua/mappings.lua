require "nvchad.mappings"
require("d-dev.discipline").cowboy()

local map = vim.keymap.set

-- Quick enter command
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Save with normal basic ctrl-s
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Toggle options
map("n", "<leader>uT", function()
  require("base46").toggle_transparency()
end, { desc = "Toggle Transparency" })

map("n", "<leader>ut", function()
  require("base46").toggle_theme()
end, { desc = "Toggle Theme" })

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function()
  if vim.o.conceallevel == 0 then
    vim.o.conceallevel = conceallevel
  else
    vim.o.conceallevel = 0
  end
  vim.notify("Conceal level: " .. vim.o.conceallevel, vim.log.levels.INFO)
end, { desc = "Toggle Conceal level" })

map("n", "<leader>us", function()
  -- only spell option require get() to retrun boolean type
  if vim.opt_local.spell:get() == true then
    vim.opt.spell = false
    vim.notify "Disable Spell checking for current buffer"
  else
    vim.opt.spell = true
    vim.notify "Enable Spell checking for current buffer"
  end
end, { desc = "Toggle Spell checking" })

map("n", "<leader>uf", function()
  if vim.g.disable_autoformat or vim.b.disable_autoformat then
    vim.g.disable_autoformat = false
    vim.b.disable_autoformat = false
    vim.notify("Enable autoformat glbally", vim.log.levels.INFO)
  else
    vim.g.disable_autoformat = true
    vim.notify("Disable autoformat glbally", vim.log.levels.INFO)
  end
end, { desc = "Toggle Auto format (Global)" })

map("n", "<leader>uF", function()
  if vim.b.disable_autoformat then
    vim.b.disable_autoformat = false
    vim.notify("Enable autoformat for current buffer", vim.log.levels.INFO)
  else
    vim.b.disable_autoformat = true
    vim.notify("Disable autoformat for current buffer", vim.log.levels.INFO)
  end
end, { desc = "Toggle Auto format (Buffer)" })

map("n", "<leader>ud", function()
  if vim.diagnostic.is_disabled() then
    vim.diagnostic.enable()
    vim.notify("Enable diagnostic globally", vim.log.levels.INFO)
  else
    vim.diagnostic.disable()
    vim.notify("Disable diagnostic globally", vim.log.levels.INFO)
  end
end, { desc = "Toggle Diagnostic (Global)" })

map("n", "<leader>uD", function()
  if vim.diagnostic.is_disabled() then
    vim.diagnostic.enable(0)
    vim.notify("Enable diagnostic for current buffer", vim.log.levels.INFO)
  else
    vim.diagnostic.disable(0)
    vim.notify("Disable diagnostic for current buffer", vim.log.levels.INFO)
  end
end, { desc = "Toggle Diagnostic (Buffer)" })

-- Telescope mappings
map("n", "<leader>fb", function()
  local fb_actions = require("telescope").extensions.file_browser
  fb_actions.file_browser()
end, {
  desc = "Telescope File browser",
})
map("n", "<leader>fp", function()
  require("telescope.builtin").find_files { cwd = require("lazy.core.config").options.root }
end, { desc = "Telescope Find plugin file" })

map("n", "<leader>fB", "<cmd>Telescope buffers<CR>", { desc = "Telescope Find buffers" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Telescope Find keymaps" })
map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find files" })

-- Short telescope
map("n", "fb", function()
  local fb_actions = require("telescope").extensions.file_browser
  fb_actions.file_browser()
end, {
  desc = "Telescope File browser",
})
map("n", "fp", function()
  require("telescope.builtin").find_files { cwd = require("lazy.core.config").options.root }
end, { desc = "Telescope Find plugin file" })

map("n", "fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope Live grep" })
map("n", "fB", "<cmd>Telescope buffers<CR>", { desc = "Telescope Find buffers" })
map("n", "fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope Help page" })
map("n", "fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope Find oldfiles" })
map("n", "fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope Find in current buffer" })
map("n", "ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find files" })
map("n", "fk", "<cmd>Telescope keymaps<CR>", { desc = "Telescope Find keymaps" })
map(
  "n",
  "fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "Telescope Find all files" }
)
-- Packages manager
map("n", "<leader>ms", "<cmd>Mason<CR>", { desc = "Toggle Mason LSP manager" })
map("n", "<leader>lz", "<cmd>Lazy<CR>", { desc = "Toggle Lazy plugins manager" })

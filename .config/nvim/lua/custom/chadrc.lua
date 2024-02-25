---@type ChadrcConfig
local M = {}

M.ui = {
  transparency = true,
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "blossom_light" },
  nvdash = {
    load_on_startup = true,
  },
  hl_override = {
    Comment = {
      italic = true,
    }
  },
  telescope = {
    style = "bordered",
  },
  statusline = {
    theme = "vscode_colored",
  }
}

M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")

return M

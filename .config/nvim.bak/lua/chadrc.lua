---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "dark_horizon",
  theme_toggle = { "dark_horizon", "blossom_light" },
  transparency = false,

  nvdash = {
    header = {
      "                                        ",
      " ██████╗       ██████╗ ███████╗██╗   ██╗",
      " ██╔══██╗      ██╔══██╗██╔════╝██║   ██║",
      "████╗ ██║█████╗██║  ██║█████╗  ██║   ██║",
      "╚██╔╝ ██║╚════╝██║  ██║██╔══╝  ╚██╗ ██╔╝",
      " ██████╔╝      ██████╔╝███████╗ ╚████╔╝ ",
      " ╚═════╝       ╚═════╝ ╚══════╝  ╚═══╝  ",
    },
    load_on_startup = true,
    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰥨  File Browser", "Spc f b", "Telescope file_browser" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

return M

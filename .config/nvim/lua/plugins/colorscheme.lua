return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },


  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "macchiato",
      transparent_background = true,
      -- custom line number color
      custom_highlights = function(colors)
        return {
          CursorLineNr = { fg = colors.rosewater },
          LineNr = { fg = colors.mauve },
        }
      end,
    },
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
}

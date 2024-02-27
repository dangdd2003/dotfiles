return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      -- colorscheme = "kanagawa",
    },
  },


  {
    "catppuccin/nvim",
    -- enabled = false,
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
    "rebelot/kanagawa.nvim",
    enbaled = false,
    opts = {
      transparent = true,
      theme = "dragon",
      background = {
        dark = "dragon",
        light = "lotus",
      },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none"
            }
          }
        }
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          TelescopeBorder = { bg = "none" },
        }
      end,
    }
  }
}

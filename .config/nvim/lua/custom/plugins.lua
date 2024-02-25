local plugins = {

  -- notify
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all notification",
      },
    },
    opts = {
      timeout = 3000,
      background_colour = "#000000",
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
  },

  -- noice
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        }
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",                 desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end,                                desc = "Dismiss All" },
      { "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,              expr = true,              desc = "Scroll forward",  mode = { "i", "n", "s" } },
      { "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,              expr = true,              desc = "Scroll backward", mode = { "i", "n", "s" } },
    },
  },

  -- nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        enable = true,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
      filters = {
        git_ignored = false,
      }
    },
  },

  -- telescope
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope-file-browser.nvim",
  --   },
  --   keys = {
  --     {
  --       "<leader>fB",
  --       function()
  --         local builtin = require("telescope.builtin")
  --         builtin.buffers()
  --       end,
  --       desc = "Find buffers"
  --     },
  --     {
  --       "<leader>fb",
  --       function()
  --         local fb_actions = require("telescope").extensions.file_browser
  --         fb_actions.file_browser()
  --       end,
  --       desc = "File Browser",
  --     }
  --   },
  --   config = function(_, opts)
  --     local telescope = require("telescope")
  --     local actions = require("telescope.actions")
  --     local fb_actions = require("telescope").extensions.file_browser.actions
  --     local function telescope_buffer_dir()
  --       return vim.fn.expand("%:p:h")
  --     end
  --     opts.extensions = {
  --       file_browser = {
  --         path = "%:p:h",
  --         cwd = telescope_buffer_dir(),
  --         respect_gitignore = false,
  --         hidden = true,
  --         no_ignore = true,
  --         follow_symlinks = true,
  --         grouped = true,
  --         previewer = false,
  --         layout_config = {
  --           horizontal = {
  --             prompt_position = "top",
  --             preview_width = 0.55,
  --             results_width = 0.8,
  --           },
  --           vertical = {
  --             mirror = false,
  --           },
  --           width = 0.87,
  --           height = 0.80,
  --           preview_cutoff = 120,
  --         },
  --         initial_mode = "normal",
  --         theme = "dropdown",
  --         hijack_netrw = true,
  --         mappings = {
  --           ["n"] = {
  --             ["h"] = fb_actions.goto_parent_dir,
  --             ["<bs>"] = fb_actions.goto_parent_dir,
  --             ["<C-u>"] = function(prompt_bufnr)
  --               for i = 1, 10 do
  --                 actions.move_selection_previous(prompt_bufnr)
  --               end
  --             end,
  --             ["<C-d>"] = function(prompt_bufnr)
  --               for i = 1, 10 do
  --                 actions.move_selection_next(prompt_bufnr)
  --               end
  --             end,
  --           },
  --         },
  --       }
  --     }
  --     dofile(vim.g.base46_cache .. "telescope")
  --     telescope.setup(opts)
  --     -- load extensions
  --     for _, ext in ipairs(opts.extensions_list) do
  --       telescope.load_extension(ext)
  --     end
  --     require("telescope").load_extension("file_browser")
  --   end
  -- },
}
return plugins

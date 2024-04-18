return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
  },
  opts = function(_, opts)
    local telescope = require "telescope"
    local actions = require "telescope.actions"
    local fb_actions = require("telescope").extensions.file_browser.actions
    local action_layout = require "telescope.actions.layout"
    local function telescope_buffer_dir()
      return vim.fn.expand "%:p:h"
    end

    opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
      file_ignore_patterns = {
        "node_modules",
      },
      wrap_result = true,
      preview = {
        filesize_limit = 1, -- MB
      },
      mappings = {
        n = {
          ["<M-p>"] = action_layout.toggle_preview,
        },
        i = {
          ["<M-p>"] = action_layout.toggle_preview,
        },
      },
    })

    opts.pickers = {
      find_files = {
        follow = true,
      },
    }

    opts.extensions = {
      file_browser = {
        path = "%:p:h",
        cwd = telescope_buffer_dir(),
        respect_gitignore = false,
        hidden = true,
        follow_symlinks = true,
        grouped = true,
        previewer = false,
        initial_mode = "normal",
        layout_strategy = "horizontal",
        layout_config = {
          height = 0.80,
        },
        theme = "dropdown",
        hijack_netrw = true,
        mappings = {
          ["n"] = {
            -- override default function for open in built-in application
            ["h"] = fb_actions.goto_parent_dir,
            ["<bs>"] = fb_actions.goto_parent_dir,
            ["<C-u>"] = function(prompt_bufnr)
              for i = 1, 5 do
                actions.move_selection_previous(prompt_bufnr)
              end
            end,
            ["<C-d>"] = function(prompt_bufnr)
              for i = 1, 5 do
                actions.move_selection_next(prompt_bufnr)
              end
            end,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
          },
        },
      },
    }
    telescope.setup(opts)
    require("telescope").load_extension "file_browser"
  end,
}

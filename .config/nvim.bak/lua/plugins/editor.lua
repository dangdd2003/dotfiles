return {
  -- additional lsp highlight
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "c",
          "cpp",
          "python",
          "java",
          "markdown",
          "markdown_inline",
          "javascript",
          "typescript",
          "tsx",
        })
      end
    end,
  },

  -- automatically add closing tag for HTML, JSX, TSX
  {
    "windwp/nvim-ts-autotag",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "markdown", "xml" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- markdown preview
  {
    "iamcco/markdown-preview.nvim",
    keys = {
      { "<leader>cp", "<cmd>MarkdownPreviewToggle<CR>", ft = "markdown", desc = "Toggle Markdown Preview" },
    },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.cmd [[do FileType]]
    end,
  },

  -- auto completion
  {
    "nvim-cmp",
    opts = function(_, opts)
      opts.experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      }
      -- change text color of highlight group ghost_text
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      local cmp = require "cmp"
      opts.sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.recently_used,
          require "clangd_extensions.cmp_scores",
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      }
    end,
  },

  -- surround
  {
    "kylechui/nvim-surround",
    event = "User FilePost",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
        keymaps = {
          normal = "gs",
          normal_cur = "gsa",
          normal_line = "gS",
          normal_cur_line = "gSA",
          visual = "gsa",
          visual_line = "gSA",
          delete = "gsd",
          change = "gsr",
          change_line = "gSR",
        },
      }
    end,
    opts = {},
  },

  -- clangd extensions
  {
    "p00f/clangd_extensions.nvim",
    ft = { "cpp", "c" },
    config = function() end,
  },
}

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

  -- additional lsp
  {
    "nvimtools/none-ls.nvim",
    event = "User FilePost",
    opts = function(_, opts)
      local nls = require "null-ls"
      opts.root_dir = opts.root_dir or require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git")
      opts.sources = {
        nls.builtins.diagnostics.markdownlint,
        -- nls.builtins.formatting.prettier,
      }
      -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      -- opts.on_attach = function(client, bufnr)
      --   if client.supports_method "textDocument/formatting" then
      --     vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      --     vim.api.nvim_create_autocmd("BufWritePre", {
      --       group = augroup,
      --       buffer = bufnr,
      --       callback = function()
      --         vim.lsp.buf.format { async = false }
      --       end,
      --     })
      --   end
      -- end
    end,
  },

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    -- enabled = false,
    event = "User FilePost",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
    config = function()
      require("copilot").setup {}
    end,
  },

  -- completion
  {
    "nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        opts = {},
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "copilot",
        group_index = 1,
        priority = 100,
      })
      local cmp = require "cmp"
      cmp.setup {
        sorting = {
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

return {
  -- auto stop lsp
  {
    "zeioth/garbage-day.nvim",
    enabled = false,
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      grace_period = 60 * 5,
      wakeup_delay = 1000,
      notifications = true,
    },
  },

  -- additional config lsp
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim", opts = {
        automatic_installation = true,
      } },
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
      },
      severity_sort = true,
    },
  },

  -- additional packages for lsp
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = function(_, opts)
      require("mason").setup(opts)
      opts.ensure_installed = {
        "markdownlint",
      }
      local mr = require "mason-registry"
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger {
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          }
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
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
}

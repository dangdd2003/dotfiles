local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  -- web stuff
  -- tsserver = {
  --   root_dir = function(...)
  --     return require("lspconfig.util").root_pattern ".git" (...)
  --   end,
  --   single_file_support = true,
  --   settings = {
  --     typescript = {
  --       inlayHints = {
  --         includeInlayParameterNameHints = "literal",
  --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --         includeInlayFunctionParameterTypeHints = true,
  --         includeInlayVariableTypeHints = false,
  --         includeInlayPropertyDeclarationTypeHints = true,
  --         includeInlayFunctionLikeReturnTypeHints = true,
  --         includeInlayEnumMemberValueHints = true,
  --       },
  --     },
  --     javascript = {
  --       inlayHints = {
  --         includeInlayParameterNameHints = "all",
  --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --         includeInlayFunctionParameterTypeHints = true,
  --         includeInlayVariableTypeHints = true,
  --         includeInlayPropertyDeclarationTypeHints = true,
  --         includeInlayFunctionLikeReturnTypeHints = true,
  --         includeInlayEnumMemberValueHints = true,
  --       },
  --     },
  --   },
  -- },
  -- html = {},
  -- cssls = {},

  -- python
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          typeCheckingMode = "basic",
        },
      },
    },
  },
  ruff_lsp = {
    keys = {
      {
        "<leader>co",
        function()
          vim.lsp.buf.code_action {
            apply = true,
            context = {
              only = { "source.organizeImports" },
              diagnostics = {},
            },
          }
        end,
        desc = "Organize Imports",
      },
    },
  },

  -- c/c++
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    root_dir = function(fname)
      return require("lspconfig.util").root_pattern(
        "Makefile",
        "configure.ac",
        "configure.in",
        "config.h.in",
        "meson.build",
        "meson_options.txt",
        "build.ninja"
      )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname) or require(
        "lspconfig.util"
      ).find_git_ancestor(fname)
    end,
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
  },
}

for name, opts in pairs(servers) do
  opts.on_init = on_init
  opts.on_attach = on_attach
  opts.capabilities = capabilities
  lspconfig[name].setup(opts)
end

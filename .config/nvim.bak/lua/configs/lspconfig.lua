local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  -- web stuff
  tsserver = {
    root_dir = function(...)
      return require("lspconfig.util").root_pattern ".git"(...)
    end,
    single_file_support = true,
    settings = {
      completions = {
        completeFunctionCalls = true,
      },
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "literal",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  tailwindcss = {},
  eslint = {
    settings = {
      workingDirectories = { mode = "auto" },
    },
  },
  html = {},
  cssls = {},

  -- python
  pyright = {
    settings = {
      python = {
        analysis = {
          -- typeCheckingMode = "strict",
        },
      },
    },
  },
  ruff_lsp = {
    on_attach = function(client, _)
      if client.name == "ruff_lsp" then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
      end
    end,
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

  -- java
  jdtls = {},

  -- markdown
  marksman = {},
}

for name, opts in pairs(servers) do
  opts.on_init = on_init
  opts.on_attach = on_attach
  opts.capabilities = capabilities

  -- specialize for clangd
  if name == "clangd" then
    opts.capabilities = vim.tbl_deep_extend("force", capabilities, { offsetEncoding = { "utf-16" } })
    opts.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      require("clangd_extensions.inlay_hints").setup_autocmd()
      require("clangd_extensions.inlay_hints").set_inlay_hints()

      local group = vim.api.nvim_create_augroup("clangd_no_inlay_hints_in_insert", { clear = true })

      vim.keymap.set("n", "<leader>cl", function()
        if require("clangd_extensions.inlay_hints").toggle_inlay_hints() then
          vim.api.nvim_create_autocmd(
            "InsertEnter",
            { group = group, buffer = bufnr, callback = require("clangd_extensions.inlay_hints").disable_inlay_hints }
          )
          vim.api.nvim_create_autocmd(
            { "TextChanged", "InsertLeave" },
            { group = group, buffer = bufnr, callback = require("clangd_extensions.inlay_hints").set_inlay_hints }
          )
        else
          vim.api.nvim_clear_autocmds { group = group, buffer = bufnr }
        end
      end, { buffer = bufnr, desc = "Toggle Inlay Hints" })
    end
  end

  -- lombok linting jdtls
  if name == "jdtls" then
    local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
    local jvmArg = "-javaagent:" .. install_path .. "/lombok.jar"
    opts.cmd = {
      "jdtls",
      "-configuration",
      "/home/user/.cache/jdtls/config",
      "-data",
      "/home/user/.cache/jdtls/workspace",
      "--jvm-arg=" .. jvmArg,
    }
  end
  lspconfig[name].setup(opts)
end

return {
  -- notiry
  {
    "rcarriga/nvim-notify",
    enabled = false,
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss { silent = true, pending = true }
        end,
        desc = "Dismiss all notification",
      },
    },
    opts = {
      timeout = 3000,
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
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
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
        },
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
      { "<S-Enter>",function() require("noice").redirect(vim.fn.getcmdline()) end,mode = "c",desc = "Noice Redirect Cmdline" },
      { "<leader>snl",function() require("noice").cmd("last") end,desc = "Noice Last Message" },
      { "<leader>snh",function() require("noice").cmd("history") end,desc = "Noice History" },
      { "<leader>sna",function() require("noice").cmd("all") end,desc = "Noice All" },
      { "<leader>snd",function() require("noice").cmd("dismiss") end,desc = "Noice Dismiss All" },
      { "<c-f>",function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,expr = true,desc = "Noice Scroll forward",  mode = { "i", "n", "s" } },
      { "<c-b>",function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,expr = true,desc = "Noice Scroll backward", mode = { "i", "n", "s" } },
    },
  },

  -- discord presence
  {
    "IogaMaster/neocord",
    event = "BufRead",
    config = function()
      require("neocord").setup {
        global_timer = true,
      }
    end,
  },
}

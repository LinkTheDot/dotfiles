return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    image = { enabled = vim.uv.os_uname().sysname == "Darwin" },
    dashboard = {
      enabled = vim.uv.os_uname().sysname == "Darwin",
      sections = {
        {
          section = "header",
          padding = 2,
        },
      },
      preset = {
        header = string.rep("\n", vim.o.lines),
      },
    },
    indent = { enabled = true },
    input = { enabled = true },
    gh = {
      enabled = true,
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      enabled = true,
      sources = {
        gh_issue = {},
        gh_pr = {},
      },
      win = {
        input = {
          keys = {
            ["<C-j>"] = { "list_down", mode = { "n", "i" } },
            ["<C-k>"] = { "list_up", mode = { "n", "i" } },
          },
        },
        list = {
          keys = {
            ["d"] = { "delete", mode = { "n" } },
          },
        },
      },
      formatters = {
        file = {
          filename_first = true,
        },
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = true },
  },
  keys = {
    {
      "<C-t>",
      function()
        require("snacks").picker.files({
          find_command = { "rg", "--files" },
          hidden = false,
          follow = false,
        })
      end,
      desc = "Find files",
    },
    {
      "<leader>be",
      function()
        require("snacks").picker.buffers({
          layout = {
            preset = "select",
          },
        })
      end,
      desc = "Open buffers in picker",
    },
    {
      "<leader>a",
      function()
        require("snacks").picker.grep()
      end,
      desc = "Live grep",
    },
    {
      "<C-f>",
      function()
        require("snacks").picker.lines()
      end,
      desc = "Current buffer search",
    },
    {
      "<leader>fo",
      function()
        require("snacks").picker.recent({
          filter = { cwd = true },
        })
      end,
      desc = "Find recent files",
    },
    {
      "<leader>sn",
      function()
        require("snacks").picker.notifications()
      end,
      desc = "Show notifications",
    },
    {
      "<leader>sr",
      function()
        require("snacks").picker.resume()
      end,
      desc = "Resume last picker",
    },
    {
      "<leader>sm",
      function()
        require("snacks").picker.marks({
          filter = { cwd = true },
        })
      end,
      desc = "Show marks",
    },
    {
      "<leader>gi",
      function()
        require("snacks").picker.gh_issue()
      end,
      desc = "GitHub Issues (open)",
    },
    {
      "<leader>gI",
      function()
        require("snacks").picker.gh_issue({ state = "all" })
      end,
      desc = "GitHub Issues (all)",
    },
    {
      "<leader>gp",
      function()
        require("snacks").picker.gh_pr()
      end,
      desc = "GitHub Pull Requests (open)",
    },
    {
      "<leader>gP",
      function()
        require("snacks").picker.gh_pr({ state = "all" })
      end,
      desc = "GitHub Pull Requests (all)",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        vim.notify = require("snacks").notifier.notify

        _G.dd = function(...)
          require("snacks").debug.inspect(...)
        end
        _G.bt = function()
          require("snacks").debug.backtrace()
        end
      end,
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "SnacksDashboardOpened",
      callback = function()
        if vim.uv.os_uname().sysname ~= "Darwin" then return end
        vim.defer_fn(function()
          local buf = vim.api.nvim_get_current_buf()
          local ok, err = pcall(function()
            require("snacks").image.placement.new(
              buf,
              vim.fn.expand("~/.config/assets/nvim_header.png"),
              {
                pos = { 1, 0 },
                auto_resize = true,
                on_update_pre = function(p)
                  local ns =
                    vim.api.nvim_create_namespace("snacks.image")
                  vim.api.nvim_buf_clear_namespace(p.buf, ns, 0, -1)
                  local state = p:state()
                  local w = state.loc.width
                  local h = state.loc.height
                  local win_h = vim.api.nvim_win_get_height(0)
                  local win_w = vim.api.nvim_win_get_width(0)
                  p.opts.pos = {
                    math.max(1, math.floor((win_h - h) / 2)),
                    math.max(0, math.floor((win_w - w) / 2)),
                  }
                end,
              }
            )
          end)
          if not ok then
            vim.notify(
              "Dashboard image error: " .. tostring(err),
              vim.log.levels.ERROR
            )
          end
        end, 200)
      end,
    })
  end,
}

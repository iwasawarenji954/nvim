return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    signs = true,
    keywords = {
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
      TODO = { icon = " ", color = "info" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
      HACK = { icon = " ", color = "warning" },
      PERF = { icon = " ", color = "hint", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    highlight = {
      before = "",
      keyword = "wide",
      after = "fg",
      pattern = [[.*<(KEYWORDS)\s*:]],
      comments_only = true,
    },
    search = {
      command = "rg",
      args = {
        "--color=never", "--no-heading", "--with-filename", "--line-number", "--column",
      },
      pattern = [[\b(KEYWORDS):]],
    },
  },
  config = function(_, opts)
    require("todo-comments").setup(opts)
    local todo = require("todo-comments")
    -- Jump between TODOs
    vim.keymap.set("n", "]t", function() todo.jump_next() end, { desc = "Next TODO/FIX/WARN" })
    vim.keymap.set("n", "[t", function() todo.jump_prev() end, { desc = "Prev TODO/FIX/WARN" })
    -- Lists
    vim.keymap.set("n", "<leader>tq", ":TodoQuickFix<CR>", { silent = true, desc = "Todo → QuickFix" })
    vim.keymap.set("n", "<leader>tl", ":TodoLocList<CR>",  { silent = true, desc = "Todo → LocationList" })
  end,
}


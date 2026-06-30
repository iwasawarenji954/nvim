-- telescope.nvim: プレビュー付きの絞り込みリスト
-- 参照/定義の一覧(VSCode の Find All References / Peek 相当)や
-- ファイル検索・全文検索に使う
return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<leader>p", "<cmd>Telescope find_files<cr>", desc = "ファイル検索 (Cmd+P 相当)" },
    { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "全文検索 (Cmd+Shift+F 相当)" },
    { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "開いているバッファ一覧" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "診断(エラー/警告)一覧" },
  },
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { preview_width = 0.55, prompt_position = "top" },
        sorting_strategy = "ascending",
        -- Esc 一発で閉じる(挿入モードからでも)
        mappings = {
          i = { ["<esc>"] = actions.close },
        },
      },
    }
  end,
}

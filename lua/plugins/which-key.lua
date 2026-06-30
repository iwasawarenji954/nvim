-- which-key.nvim: キーを押し始めると「続けて押せるキー一覧」をポップアップ表示するカンペ
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    -- プレフィックスにグループ名を付けて一覧を読みやすくする
    spec = {
      { "<leader>g", group = "git" },
      { "<leader>s", group = "検索 / 置換 (spectre)" },
      { "<leader>t", group = "toggle / todo" },
      { "<leader>c", group = "code (format / action)" },
      { "<leader>f", group = "find (telescope / tree)" },
      { "<leader>r", group = "rename" },
      { "<leader>w", group = "window" },
      { "<leader>p", desc = "ファイル検索" },
      { "<leader>b", desc = "バッファ一覧" },
      { "<leader>o", desc = "URL/ファイルを開く" },
      { "<leader>e", desc = "ファイルツリー開閉" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "このバッファのキーマップ一覧",
    },
    {
      "<leader>K",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "全キーマップ一覧",
    },
  },
}

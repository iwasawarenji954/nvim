return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- 依存関係として telescope.nvim があると、さらに便利に連携できるよ
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- キーマッピングの設定
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
}

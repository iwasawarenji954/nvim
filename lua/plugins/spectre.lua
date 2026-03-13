return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Spectre",
  keys = {
    { "<leader>sr", function() require("spectre").open() end, desc = "Spectre: Project search/replace", mode = "n" },
    { "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Spectre: Search word under cursor", mode = "n" },
    { "<leader>sw", function() require("spectre").open_visual() end, desc = "Spectre: Search selection", mode = "v" },
    { "<leader>sf", function() require("spectre").open_file_search({ select_word = false }) end, desc = "Spectre: File-only search/replace", mode = "n" },
  },
  opts = {
    live_update = true,
  },
}


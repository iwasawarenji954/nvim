return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    size = 15,
    direction = "horizontal",
    start_in_insert = true,
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- Keymaps: only normal/terminal to avoid breaking <C-j> newline in insert mode
    local map = vim.keymap.set
    map("n", "<C-j>", "<Cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
    map("t", "<C-j>", [[<C-\><C-n><Cmd>ToggleTerm<CR>]], { desc = "Toggle terminal" })

    -- Keep line numbers visible (relative) in terminal too
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*",
      callback = function()
        vim.opt_local.number = true
        vim.opt_local.relativenumber = true
      end,
    })
  end,
}

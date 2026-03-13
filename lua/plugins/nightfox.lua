return {
  -- Preferred theme (Neovim)
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    options = {
      styles = {
        comments = "NONE",
        keywords = "NONE",
        types = "NONE",
        functions = "NONE",
        conditionals = "NONE",
        constants = "NONE",
        numbers = "NONE",
        operators = "NONE",
        strings = "NONE",
        variables = "NONE",
      },
    },
  },
  config = function(_, opts)
    require('nightfox').setup(opts)
    vim.cmd('set background=dark')
    vim.cmd('colorscheme nightfox')
  end,
}


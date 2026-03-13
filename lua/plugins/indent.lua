return {
  -- Modern indent guides with rainbow levels
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = { char = "│", tab_char = "│" },
    scope = { enabled = true, show_start = false, show_end = false },
    whitespace = { remove_blankline_trail = false },
    exclude = {
      filetypes = { "help", "alpha", "dashboard", "git", "gitcommit", "TelescopePrompt", "TelescopeResults", "NvimTree", "lazy", "terminal" },
    },
  },
  config = function(_, opts)
    local ibl = require("ibl")
    local hooks = require("ibl.hooks")

    -- Define rainbow highlight groups (OneDark-ish palette fits Nightfox too)
    local rainbow = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#E06C75", nocombine = true })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B", nocombine = true })
      vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#61AFEF", nocombine = true })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66", nocombine = true })
      vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#98C379", nocombine = true })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD", nocombine = true })
      vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#56B6C2", nocombine = true })
    end)

    opts.indent = opts.indent or {}
    opts.scope = opts.scope or {}
    opts.indent.highlight = rainbow
    opts.scope.highlight = rainbow

    ibl.setup(opts)
  end,
}

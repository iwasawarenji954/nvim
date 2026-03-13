return {
  -- Fallback theme for Vim parity
  { "joshdick/onedark.vim" },

  -- Legacy plugins preserved (behavior unchanged)
  { "tpope/vim-commentary" },
  { "tpope/vim-sensible" },
  { "airblade/vim-gitgutter" },
  { "tpope/vim-vinegar" },
  { "junegunn/fzf", build = "./install --bin" },
  -- Disable legacy airline in favor of lualine
  { "vim-airline/vim-airline", enabled = false },
  { "tpope/vim-fugitive" },
  { "terryma/vim-multiple-cursors" },
  { "jiangmiao/auto-pairs" },
  { "preservim/tagbar" },

  -- TypeScript / TSX visuals
  { "leafgarland/typescript-vim" },
  { "yuezk/vim-js" },
  {
    "maxmellon/vim-jsx-pretty",
    init = function()
      vim.g.vim_jsx_pretty_enable = 1
      vim.g.vim_jsx_pretty_colorful_config = 1
      vim.g.vim_jsx_pretty_highlight_close_tag = 1
    end,
  },

  -- Indent guides (visual only)
  { "nathanaelkane/vim-indent-guides", enabled = false },
}

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = {
    'NvimTreeOpen', 'NvimTreeClose', 'NvimTreeToggle',
    'NvimTreeFindFile', 'NvimTreeFindFileToggle'
  },
  opts = {
    disable_netrw = false, -- keep netrw (for vinegar compatibility)
    hijack_netrw = false,
    view = { side = 'left', width = 32, preserve_window_proportions = true },
    renderer = { root_folder_label = ':t' },
    update_focused_file = { enable = true, update_root = false },
    git = { enable = true },
    actions = { open_file = { quit_on_open = false } },
  },
  config = function(_, opts)
    require('nvim-tree').setup(opts)
  end,
}


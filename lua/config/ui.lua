-- Core UI and editor options to mirror your Vim setup
local o, g = vim.opt, vim.g

-- Encoding, filetype, syntax
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

-- UI
o.number = true
o.relativenumber = true
if vim.fn.has('termguicolors') == 1 then
  o.termguicolors = true
end
o.laststatus = 3

-- Mouse: allow normal-mode clicks only (no Visual on double-click)
o.mouse = 'n'
-- Disable multi-click detection entirely (so double-click is treated as two singles)
o.mousetime = 0
-- Ensure drag selects in Normal mode (extend behavior)
o.mousemodel = 'extend'

-- Disable click/drag/release variants across modes, but keep single left-click for cursor move
do
  local modes = { 'n', 'v', 'i', 's', 'o', 't' }
  local opts = { silent = true }

  local buttons = { 'Left', 'Right', 'Middle' }
  local events = { 'Mouse', 'Drag', 'Release' }
  local modifiers = { '', 'S-', 'C-', 'A-', 'M-', 'D-' } -- Meta(M-) and Command(D-)
  local counts = { '', '2-', '3-' } -- single/double/triple

  local function map_mouse(seq)
    for _, m in ipairs(modes) do
      vim.keymap.set(m, seq, '<Nop>', opts)
    end
  end

  for _, btn in ipairs(buttons) do
    -- Basic presses with modifiers and multi-clicks
    for _, mod in ipairs(modifiers) do
      for _, cnt in ipairs(counts) do
        local seq = string.format('<%s%s%s>', cnt, mod, btn .. 'Mouse')
        -- Allow plain single left-click only; disable everything else
        if not (btn == 'Left' and mod == '' and cnt == '') then
          map_mouse(seq)
        end
      end
    end
    -- Drags/Releases with modifiers
    for _, mod in ipairs(modifiers) do
      for _, ev in ipairs({ 'Drag', 'Release' }) do
        local seq = string.format('<%s%s>', mod, btn .. ev)
        if btn == 'Left' and mod == '' then
          -- Allow plain LeftDrag/LeftRelease in Normal mode for visual selection
          for _, m in ipairs({ 'v', 'i', 's', 'o', 't' }) do
            vim.keymap.set(m, seq, '<Nop>', opts)
          end
        else
          map_mouse(seq)
        end
      end
    end
  end
end

-- Wheel: move cursor with scroll (keep cursor in view)
do
  local opts = { noremap = true, silent = true }
  -- Normal/Visual/Operator: move by one line per tick
  vim.keymap.set({ 'n', 'x', 'o' }, '<ScrollWheelUp>', 'k', opts)
  vim.keymap.set({ 'n', 'x', 'o' }, '<ScrollWheelDown>', 'j', opts)
  -- Insert/Select: move without leaving mode
  vim.keymap.set({ 'i', 's' }, '<ScrollWheelUp>', '<C-o>k', opts)
  vim.keymap.set({ 'i', 's' }, '<ScrollWheelDown>', '<C-o>j', opts)
end

-- Indent
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true

-- Search
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true

-- Completion menu
o.wildmenu = true
o.wildmode = 'longest:full,full'

-- Misc
o.history = 1000
o.scrolloff = 8
o.sidescrolloff = 8

-- Whitespace visualization (toggle-able): good for seeing real tab width
o.listchars = 'tab:»·,trail:·,extends:…,precedes:…'
-- Toggle with <leader>tw
vim.keymap.set('n', '<leader>tw', function()
  vim.opt.list = not vim.opt.list:get()
  local state = vim.opt.list:get() and 'ON' or 'OFF'
  vim.notify('Whitespace listchars: ' .. state)
end, { desc = 'Toggle whitespace (tab width view)' })

-- Keymaps matching .vimrc
vim.keymap.set('n', 'A', '^', { noremap = true, silent = true })
vim.keymap.set('n', 'L', '$', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'x', 'o' }, '<S-Down>', 'j', { noremap = true, silent = true })
vim.keymap.set('i', '<S-Down>', '<C-o>j', { noremap = true, silent = true })

-- Sidebar (NvimTree) toggles
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>',     { noremap = true, silent = true, desc = 'Toggle file tree' })
vim.keymap.set('n', '<leader>f', ':NvimTreeFindFile<CR>',   { noremap = true, silent = true, desc = 'Reveal current file in tree' })
vim.keymap.set('n', '<C-b>',     ':NvimTreeToggle<CR>',     { noremap = true, silent = true, desc = 'Toggle file tree (Ctrl-b)' })

-- <Esc> clears search highlight
vim.keymap.set('n', '<Esc>', function()
  if vim.v.hlsearch == 1 then
    vim.cmd('noh')
    return ''
  end
  return '\27'
end, { expr = true, noremap = true, silent = true })

-- Trim trailing spaces on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Airline theme (fallback matches your Vim)
g.airline_theme = 'onedark'
g['airline#extensions#branch#enabled'] = 1
g['airline#extensions#branch#displayed_head_limit'] = 24
g['airline#extensions#branch#use_vcscommand'] = 1

-- Indent guides settings (same as Vim, visual only)
g.indent_guides_enable_on_vim_startup = 1
g.indent_guides_auto_colors = 0
g.indent_guides_guide_size = 1
vim.cmd('highlight IndentGuidesOdd  gui=NONE cterm=NONE guibg=#2c313c ctermbg=236')
vim.cmd('highlight IndentGuidesEven gui=NONE cterm=NONE guibg=#2a2f3a ctermbg=235')

-- C filetype helpers (as in .vimrc)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'c',
  callback = function()
    vim.keymap.set('n', '<F2>', [[:s/^/\/* /<CR>:s/$/ *\//<CR>]], { buffer = true, silent = true })
    vim.keymap.set('n', '<F3>', [[:s/^\/\* // <CR>:s/ \*\/$//<CR>]], { buffer = true, silent = true })
  end,
})

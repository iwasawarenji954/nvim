-- Open links with a specific browser
-- Usage:
--   - Default (macOS): "Google Chrome"
--   - Override with env `NVIM_BROWSER` or `vim.g.preferred_browser`

local fn = vim.fn
local map = vim.keymap.set

local preferred = vim.g.preferred_browser or os.getenv("NVIM_BROWSER") or "Google Chrome"

-- Configure netrw's URL opener (gx) to use a chosen browser
if fn.has("mac") == 1 then
  -- macOS: use `open -a <App>` with the chosen browser
  -- netrw will append the URL to this command
  vim.g.netrw_browsex_viewer = "open -a " .. fn.shellescape(preferred)
else
  -- Unix/Linux fallback: relies on xdg-open (system default browser)
  -- You can set NVIM_BROWSER and implement a custom function if you need a specific browser
  vim.g.netrw_browsex_viewer = "xdg-open"
end

-- Convenience keymap: <leader>o opens URL/file under cursor (same as gx)
map("n", "<leader>o", "gx", { remap = true, silent = true, desc = "Open URL/file under cursor" })

-- Tip: to switch browser on the fly (macOS), put in your config or :lua
--   vim.g.preferred_browser = "Arc"
--   vim.g.netrw_browsex_viewer = "open -a " .. vim.fn.shellescape(vim.g.preferred_browser)


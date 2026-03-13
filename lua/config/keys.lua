-- Map JIS Yen keys to backslash across modes
-- Handles both U+00A5 (¥) and U+FF3C (＼)
local map = vim.keymap.set

-- Normal/Visual/Select/Operator-pending: remap so existing \ mappings work
map({ "n", "x", "s", "o" }, "¥", "\\", { remap = true, silent = true })
map({ "n", "x", "s", "o" }, "＼", "\\", { remap = true, silent = true })

-- Insert/Command-line: just insert a literal backslash
map("i", "¥", "\\", { remap = false })
map("i", "＼", "\\", { remap = false })
map("c", "¥", "\\", { remap = false })
map("c", "＼", "\\", { remap = false })


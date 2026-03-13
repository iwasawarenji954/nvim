return {
  "simeji/winresizer",
  lazy = false,
  init = function()
    -- Allow cancelling/finishing with <Esc>
    vim.g.winresizer_finish_with_escape = 1
  end,
  config = function()
    -- Start winresizer with <leader>wr
    local function start()
      local ok = pcall(vim.cmd, "WinResizerStartResize")
      if not ok then
        pcall(vim.cmd, "WinResizerStart")
      end
    end
    vim.keymap.set("n", "<leader>wr", start, { desc = "Resize windows" })
  end,
}


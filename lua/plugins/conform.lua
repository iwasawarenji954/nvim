return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  opts = {
    -- Prefer eslint_d, fall back to eslint
    formatters_by_ft = {
      go = { "goimports", "gofumpt" },
      javascript = { "eslint_d", "eslint" },
      typescript = { "eslint_d", "eslint" },
      javascriptreact = { "eslint_d", "eslint" },
      typescriptreact = { "eslint_d", "eslint" },
      -- other filetypes untouched
    },
    -- Only ESLint; do not fall back to LSP formatting
    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype
      local js_like = {
        javascript = true,
        typescript = true,
        javascriptreact = true,
        typescriptreact = true,
      }
      if js_like[ft] then
        return { lsp_fallback = false, timeout_ms = 2000 }
      end

      if ft == "go" then
        return { lsp_fallback = true, timeout_ms = 2000 }
      end
    end,
  },
  config = function(_, opts)
    require("conform").setup(opts)
    -- Manual format keymap
    vim.keymap.set({ "n", "x" }, "<leader>cf", function()
      require("conform").format({ async = true, lsp_fallback = false })
    end, { desc = "Format (ESLint)" })
  end,
}

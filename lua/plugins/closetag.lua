return {
  "alvan/vim-closetag",
  init = function()
    -- Enable auto close tags for common web filetypes
    vim.g.closetag_filetypes = table.concat({
      "html",
      "xhtml",
      "phtml",
      "xml",
      "php",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    }, ",")

    -- Treat React-like types as xhtml (self-closing allowed)
    vim.g.closetag_xhtml_filetypes = table.concat({
      "xhtml",
      "javascriptreact",
      "typescriptreact",
    }, ",")

    -- Optional: better detection in TSX/JSX regions (works with various ft names)
    vim.g.closetag_regions = {
      ["typescript.tsx"] = "jsxRegion,tsxRegion,typescriptreact",
      ["javascript.jsx"] = "jsxRegion,javascriptreact",
      ["typescriptreact"] = "jsxRegion,tsxRegion,typescriptreact",
      ["javascriptreact"] = "jsxRegion,javascriptreact",
    }
  end,
}


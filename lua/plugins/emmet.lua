return {
  "mattn/emmet-vim",
  init = function()
    -- Use default leader <C-y>, e.g. <C-y>, to expand
    vim.g.user_emmet_leader_key = "<C-y>"
    -- Don't install globally; enable only for target filetypes
    vim.g.user_emmet_install_global = 0
  end,
  config = function()
    -- Enable Emmet on relevant filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "html",
        "xhtml",
        "xml",
        "css",
        "scss",
        "sass",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "php",
      },
      callback = function()
        vim.cmd("EmmetInstall")
      end,
    })
  end,
}

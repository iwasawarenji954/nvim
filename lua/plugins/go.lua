return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "gopls",
        "goimports",
        "gofumpt",
        "golangci-lint",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "gopls", "ts_ls" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- 補完エンジン(blink.cmp)の capabilities を全 LSP に適用
      local ok_blink, blink = pcall(require, "blink.cmp")
      if ok_blink then
        vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities({}, true) })
      end

      -- telescope があればプレビュー付きの一覧で開く / 無ければ標準動作にフォールバック
      local function pick(picker, fallback)
        return function()
          local ok, builtin = pcall(require, "telescope.builtin")
          if ok then
            builtin[picker]()
          else
            fallback()
          end
        end
      end

      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        map("n", "K", vim.lsp.buf.hover, "LSP Hover")
        map("n", "gd", pick("lsp_definitions", vim.lsp.buf.definition), "Go to Definition")
        map("n", "gr", pick("lsp_references", vim.lsp.buf.references), "Go to References")
        map("n", "gi", pick("lsp_implementations", vim.lsp.buf.implementation), "Go to Implementation")
        map("n", "gy", pick("lsp_type_definitions", vim.lsp.buf.type_definition), "Go to Type Definition")
        map("n", "<leader>rn", vim.lsp.buf.rename, "LSP Rename")
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP Code Action")
      end

      vim.lsp.config("gopls", {
        on_attach = on_attach,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            completeUnimported = true,
            gofumpt = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            staticcheck = true,
            usePlaceholders = true,
          },
        },
      })

      vim.lsp.enable("gopls")

      -- JavaScript / TypeScript (JSX / TSX 含む)
      -- 整形は conform(ESLint)が担うので、ts_ls 側の整形は無効化
      vim.lsp.config("ts_ls", {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          on_attach(client, bufnr)
        end,
      })

      vim.lsp.enable("ts_ls")
    end,
  },
}

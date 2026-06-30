-- blink.cmp: 入力中の自動補完ポップアップ(LSP / スニペット / バッファ / パス)
return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "1.*", -- プリビルドのバイナリを使う(ビルド不要)
  event = "InsertEnter",
  opts = {
    keymap = {
      preset = "default", -- C-n/C-p で移動, C-y で確定, C-space で表示, C-e で閉じる
      ["<CR>"] = { "accept", "fallback" }, -- 候補選択中なら Enter で確定、未選択なら改行
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
    },
    appearance = { nerd_font_variant = "mono" },
    sources = {
      default = { "lsp", "snippets", "path", "buffer" },
    },
    completion = {
      menu = { auto_show = true },
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
    },
    signature = { enabled = true }, -- 関数の引数ヒントを表示
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}

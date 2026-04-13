# Neovim config

## Go 環境

- `mason.nvim` で `gopls`, `goimports`, `gofumpt`, `golangci-lint` を管理
- `gopls` を自動有効化し、hover / definition / references / rename / code action を利用可能
- 保存時に `goimports` + `gofumpt` を実行

初回反映:

```bash
nvim --headless "+Lazy! sync" +qa
```

Neovim 起動後に `:MasonToolsInstall` を実行しても導入できます。

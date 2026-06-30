# Neovim config

`<leader>` は **スペースキー**。以下は今この設定で実際にできることの一覧。

> **キーが覚えられない時は which-key。** `<leader>`(スペース)や `g` を押して少し待つと、
> 続けて押せるキーと機能の一覧がポップアップで出る。`<leader>?` でこのバッファの全キーマップ一覧。

---

## 見た目 / UI

- テーマは **nightfox**(ダーク・背景透過)
- 相対行番号 + 絶対行番号(`number` + `relativenumber`)
- ステータスライン **lualine**(モード / ブランチ / 差分 / 診断 / ファイル名 / 文字コード / 位置 を表示)
- インデントガイド **indent-blankline**(階層ごとに虹色)
- ファイルアイコン(nvim-web-devicons)
- カーソル周辺は常に8行分の余白を確保(`scrolloff`)

| キー | 機能 |
| --- | --- |
| `<leader>tw` | 空白文字の可視化(タブ幅の確認)を ON/OFF |

---

## ファイル操作(ファイルツリー)

左サイドの **nvim-tree** と、netrw 拡張の **vinegar**。

| キー | 機能 |
| --- | --- |
| `<leader>e` / `<C-b>` | ファイルツリーを開閉 |
| `<leader>f` | 今開いているファイルをツリー上で表示 |
| `-` | 親ディレクトリを netrw で開く(vinegar) |

---

## 編集まわり

- **コメント切り替え**(vim-commentary)
- **括弧/クォートの自動補完**(auto-pairs)
- **HTML/JSX タグの自動クローズ**(vim-closetag)
- **複数カーソル**(vim-multiple-cursors)
- 保存時に **行末の空白を自動削除**

| キー | 機能 |
| --- | --- |
| `gcc` | 現在行をコメント化 / 解除 |
| `gc`(範囲) | 選択範囲をコメント化 / 解除 |
| `A` | 行頭の最初の文字へ(`^` の代わり) |
| `L` | 行末へ(`$` の代わり) |
| `<S-Down>` | 表示行ではなく実際の1行下へ |
| `<C-y>,` | Emmet 展開(HTML/CSS/JSX など。例: `div>ul>li*3` を展開) |

---

## 検索 / 置換

- 標準のインクリメンタル検索 + ハイライト(`smartcase`)
- プロジェクト全体の検索・置換 **spectre**

| キー | 機能 |
| --- | --- |
| `<Esc>` | 検索ハイライトを消す |
| `<leader>sr` | プロジェクト全体の検索・置換パネル |
| `<leader>sw` | カーソル下の単語(または選択範囲)で検索 |
| `<leader>sf` | 現在ファイル内だけの検索・置換 |

### ファイル / 全文検索(telescope)

プレビュー付きの絞り込みリスト。挿入モードのまま入力で絞り込み、`<Esc>` で閉じる。

| キー | 機能 | VSCode 相当 |
| --- | --- | --- |
| `<leader>p` | ファイル名で開く | Cmd+P |
| `<leader>/` | プロジェクト全文検索 | Cmd+Shift+F |
| `<leader>b` | 開いているバッファ一覧 | |
| `<leader>fd` | 診断(エラー / 警告)一覧 | |

---

## コード補完 / LSP(Go / JavaScript / TypeScript)

`mason` が LSP・ツールを自動管理:

- **Go** … `gopls` / `goimports` / `gofumpt` / `golangci-lint`。保存時に `goimports` + `gofumpt`
- **JS / TS(JSX / TSX 含む)** … `ts_ls`(typescript-language-server)。整形は保存時の **ESLint**(conform + `eslint_d`/`eslint`)が担当

下記キーは Go / JS / TS 共通(LSP が起動しているバッファで有効):

| キー | 機能 | VSCode 相当 |
| --- | --- | --- |
| `K` | ホバー(型・ドキュメント表示) | ホバー |
| `gd` | 定義へジャンプ | F12 |
| `gr` | **参照元の一覧**をプレビュー付きで表示→選んで飛ぶ | Find All References |
| `gi` | 実装へジャンプ | |
| `gy` | 型定義へジャンプ | |
| `<C-o>` / `<C-i>` | 元の場所に戻る / 進む | Alt+← / Alt+→ |
| `<leader>rn` | リネーム | F2 |
| `<leader>ca` | コードアクション(自動修正など) | Quick Fix |
| `<leader>cf` | 手動でフォーマット(ESLint) | |

> `gr` などはプレビュー付きの絞り込みリスト(telescope)で開く。`<C-n>`/`<C-p>` か矢印で選び `Enter` で飛ぶ。

### 補完ポップアップ(blink.cmp)

入力中に自動で候補ポップアップが出る。補完元は **LSP / スニペット / バッファ内の単語 / パス**。

| キー | 機能 |
| --- | --- |
| `<Tab>` / `<S-Tab>` | 次 / 前の候補へ |
| `<C-n>` / `<C-p>` | 次 / 前の候補へ |
| `<CR>`(Enter) / `<C-y>` | 候補を確定 |
| `<C-space>` | 補完を手動で表示 |
| `<C-e>` | 補完を閉じる |

---

## Git

| キー | 機能 |
| --- | --- |
| `<leader>gg` | **LazyGit**(コミット・ブランチ操作・差分・グラフ等すべて入った TUI) |

- 行ごとの追加/変更マークは **gitgutter** が左端に表示
- ステータスラインにブランチ名と差分量を表示
- `:Git`(fugitive)で Git コマンドも実行可能

> いまの git 操作はほぼ LazyGit(`<leader>gg`)に集約されている状態。

---

## ターミナル / ウィンドウ

| キー | 機能 |
| --- | --- |
| `<C-j>` | 画面下にターミナルを開閉(toggleterm) |
| `<leader>wr` | ウィンドウサイズ変更モード(hjkl で調整、`<Esc>` で確定) |

---

## TODO コメント

`TODO:` `FIXME:` `WARN:` `HACK:` `NOTE:` などを色付き表示してジャンプ・一覧化。

| キー | 機能 |
| --- | --- |
| `]t` / `[t` | 次 / 前の TODO 系コメントへ |
| `<leader>tq` | TODO 一覧を QuickFix に出す |
| `<leader>tl` | TODO 一覧を LocationList に出す |

---

## その他

| キー / コマンド | 機能 |
| --- | --- |
| `<leader>o` / `gx` | カーソル下の URL / ファイルをブラウザ等で開く(mac は Chrome) |
| `:TagbarToggle` | 関数・変数のアウトライン(tagbar) |
| `:Mason` | LSP / ツールの導入状況を確認 |
| マウス | 左クリックでカーソル移動・ホイールで1行スクロール(その他のマウス操作は無効) |

---

## セットアップ

プラグインの初回反映:

```bash
nvim --headless "+Lazy! sync" +qa
```

Go ツールが入らない時は Neovim 起動後に `:MasonToolsInstall`。

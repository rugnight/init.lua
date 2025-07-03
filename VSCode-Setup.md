# VSCode-Neovim セットアップガイド

## 概要
このディレクトリには、通常のNeovimとVSCode-Neovimの両方に対応した設定が含まれています。環境に応じて適切な設定が自動的に読み込まれます。

## ディレクトリ構造
```
~/.config/nvim/
├── init.lua              # Neovim専用設定（メイン）
├── init-vscode.lua       # VSCode-Neovim専用設定
├── lua/
│   ├── common_config.lua       # 共通設定
│   ├── vscode_plugins_setup.lua # VSCode用プラグイン管理
│   ├── vscode_keymaps.lua      # VSCode用キーマップ
│   ├── plugins/
│   │   ├── common/       # 共通プラグイン（Treesitter、which-key等）
│   │   ├── neovim/       # Neovim専用（UI、ファイラー等）
│   │   └── vscode/       # VSCode専用（軽量LSP等）
│   └── plugins_autoloads/  # 旧設定（後方互換性）
└── luasnippets/          # スニペット（共通）
```

## セットアップ方法

### VSCode Extension設定
1. VSCode-Neovim拡張機能をインストール
2. VSCode settings.jsonに以下を追加：

```json
{
  "vscode-neovim.neovimInitVimPaths.linux": "~/.config/nvim/init-vscode.lua",
  "vscode-neovim.neovimInitVimPaths.win32": "~/.config/nvim/init-vscode.lua",
  "vscode-neovim.neovimInitVimPaths.darwin": "~/.config/nvim/init-vscode.lua"
}
```

### 動作確認
- **通常のNeovim**: `nvim` コマンドで起動時に `init.lua` が読み込まれる
- **VSCode-Neovim**: VSCode内で `init-vscode.lua` が読み込まれる

## プラグイン分類

### 共通プラグイン (plugins/common/)
- `treesitter.lua` - シンタックスハイライト
- `which-key.lua` - キーマップガイド
- `comment.lua` - コメント操作
- `mini.align.lua` - テキスト整列
- `treesj.lua` - コード分割/結合
- `nvim-ufo.lua` - コードフォールド
- `LuaSnip.lua` - スニペット
- `claudecode.lua` - Claude Code統合
- `colorscheme.lua` - カラーテーマ
- `nvim-web-devicons.lua` - アイコン
- `mason-lspconfig.lua` - **LSP基盤（Mason + blink.cmp）** ⭐ **重要**
- `gitsigns.lua` - Git統合
- `marks.lua` - マーク機能
- `diffview.lua` - Git差分表示
- `git-conflict.lua` - コンフリクト解決

### Neovim専用プラグイン (plugins/neovim/)
UI・ファイル管理・統合機能など、Neovimの全機能を活用：
- `oil.lua`, `otree.lua` - ファイラー
- `telescope.lua` - ファジーファインダー
- `lualine.lua` - ステータスライン
- `trouble.lua` - 診断UI
- `lspsaga.lua` - LSP UI強化
- `quickfix.lua` - QuickFix強化
- `dashboard.lua` - スタート画面
- `toggleterm.lua` - ターミナル
- その他多数のUI強化プラグイン

### VSCode専用プラグイン (plugins/vscode/)
VSCodeの機能と重複しない軽量プラグインのみ：
- `lsp-signature.lua` - 関数シグネチャ
- `tiny-inline-diagnostic.lua` - インライン診断
- `hlchunk.lua` - チャンクハイライト
- `smear_cursor.lua` - カーソル効果
- `virtual-text-info.lua` - バーチャルテキスト

**注意**: LSP基盤（Mason、blink.cmp）は共通プラグインに配置されているため、VSCode-Neovimでも基本的なLSP機能は利用可能です。

## キーマップ

### VSCode-Neovim専用キーマップ
VSCodeのコマンドパレットとAPIを活用した統合キーマップ：

| キー | 機能 | VSCodeコマンド |
|------|------|----------------|
| `<Leader>ff` | ファイル検索 | `workbench.action.quickOpen` |
| `<Leader>fg` | 文字列検索 | `workbench.action.findInFiles` |
| `<Leader>ld` | 定義移動 | `editor.action.revealDefinition` |
| `<Leader>lr` | 参照検索 | `editor.action.goToReferences` |
| `<Leader>la` | コードアクション | `editor.action.quickFix` |
| `<Leader>ln` | リネーム | `editor.action.rename` |
| `<Leader>ac` | Claude Code起動 | `claude-code.start` |

## 移行・カスタマイズガイド

### 新しいプラグインの追加
1. **共通プラグイン**: `lua/plugins/common/`に配置
2. **Neovim専用**: `lua/plugins/neovim/`に配置  
3. **VSCode専用**: `lua/plugins/vscode/`に配置

### 既存設定の移行
- `plugins_autoloads/`の設定は後方互換性のため一時的に残存
- 段階的に新しい構造へ移行推奨

### トラブルシューティング

#### VSCode-Neovimのフローティングウィンドウ制限
VSCode-Neovim拡張では、Neovimのフローティングウィンドウが正常に表示されない制限があります：

**問題のあるプラグイン**:
- `lsp_signature.nvim`（フローティングシグネチャ）
- `hover.nvim`（ホバー情報表示）
- その他フローティングウィンドウを使用するプラグイン

**対応策**:
- フローティングウィンドウ系プラグインはVSCode用設定から除外
- LSPハンドラーを無効化（`common_config.lua`で実装済み）
- VSCodeネイティブ機能で代替（`K`キー → `editor.action.showHover`）

#### 基本トラブルシューティング
- VSCode環境判定: `vim.g.vscode`で分岐
- プラグイン読み込み確認: `:Lazy`コマンド
- キーマップ確認: `<Leader>?`（which-key）

## パフォーマンス最適化
- VSCode環境では重いUIプラグインを自動除外
- 共通設定の重複読み込み回避
- lazy loading最適化維持

このセットアップにより、通常のNeovimの豊富な機能とVSCode-Neovimの軽量性を両立し、環境を問わず一貫した編集体験を提供します。
# Neovim Configuration - CLAUDE.md

## プロジェクト概要
このディレクトリは個人用のNeovim設定ファイルです。Lua言語で記述され、現代的なNeovimプラグインエコシステムを活用した高速で効率的な開発環境を構築しています。

## ディレクトリ構造
```
~/.config/nvim/
├── init.lua                 # メイン設定ファイル
├── lazy-lock.json          # プラグインバージョンロック
├── lua/
│   ├── ime.lua             # IME設定（遅延読み込み最適化済み）
│   ├── my_functions.lua    # カスタム関数
│   ├── plugins/            # プラグイン定義
│   ├── plugins_autoloads/  # プラグイン設定（lazy loading最適化済み）
│   └── plugins_setup.lua   # プラグインセットアップ
├── luasnippets/            # コードスニペット
└── setup_win.bat          # Windows用セットアップ
```

## 主要設定
- **リーダーキー**: `;`
- **フォント**: HackGen Console NF
- **エンコーディング**: UTF-8
- **タブ設定**: 4スペース
- **日本語IME対応**: 有効（遅延初期化）
- **サインカラム**: 固定2文字幅（アイコン表示安定化）

## 主要プラグイン
- **lazy.nvim**: プラグインマネージャー（rocks無効化）
- **telescope.nvim**: ファジーファインダー（extensions遅延読み込み）
- **lspsaga.nvim**: 美しいLSP UI（参照・定義検索、アウトライン等）
- **symbol-usage.nvim**: LSP参照数バーチャルテキスト表示
- **nvim-tree.lua**: プロジェクトツリー表示
- **nvim-treesitter**: シンタックスハイライト（イベント遅延）
- **lualine.nvim**: ステータスライン（非推奨API修正済み）
- **mason.nvim**: LSPサーバー管理（コマンド遅延）
- **blink.cmp**: 補完エンジン
- **oil.nvim**: ファイル操作特化エクスプローラー
- **harpoon2**: ファイル間移動
- **avante.nvim**: AI支援（カスタムキーマップ）

## キーマップ体系
記憶しやすいニーモニックルールに基づく13カテゴリ構成：

### 📁 ファイル検索 (`<Leader>f*`)
- `ff` - ファイル検索, `fg` - 文字列検索, `fr` - 最近のファイル
- `fb` - バッファ検索, `fc` - コマンド検索, `fp` - プロジェクト選択
- `fq` - 頻繁に使うファイル

### 🔍 LSP操作 (`<Leader>l*`) - lspsaga統合
- `lf` - 参照・定義検索（統合ビュー）, `lr` - 参照一覧, `ld` - 定義へ移動
- `lp` - 定義プレビュー, `lh` - ホバー情報, `ln` - リネーム
- `la` - コードアクション, `lo` - アウトライン, `ls` - 行診断表示
- `li` - 呼び出し元, `lo` - 呼び出し先

### 📊 プロジェクト管理 (`<Leader>e`)
- `e` - ファイルツリー切替（nvim-tree）
- `-` - ファイル操作（oil.nvim）

### 🔀 Git操作 (`<Leader>g*`) - telescope統合
- `gc` - コミット履歴, `gb` - ブランチ一覧, `gs` - Git状態

### 🤖 AI操作 (`<Leader>a*`)
- `aa` - AI質問, `ae` - AI編集, `ar` - AI更新
- `ad` - AIデバッグ切替, `ah` - AIヒント切替, `as` - AIサイドバー切替

### 📑 ブックマーク (`<Leader>k*`)
- `km` - マークトグル, `ki` - コメント付きマーク, `kc` - マーク削除
- `kn/kp` - 次/前のマーク, `kl` - マーク一覧, `kx` - 全削除

### 👁️ 表示/UI (`<Leader>v*`)
- `vo` - アウトライン表示, `vz` - ゼンモード
- `vl` - シンボル使用状況切替（symbol-usage）

### ✏️ コード操作 (`<Leader>c*`)
- `cj` - 行結合, `cs` - 行分割
- `ca/cA` - 整列/整列プレビュー

### その他のカテゴリ
- 🎯 Harpoon (`h*`), 📝 メモ/ノート (`m*`), 🚨 診断/トラブル (`x*`)
- ⚙️ 設定 (`i*`), 🔄 トグル (`t*`), 📋 バッファ (`b*`)

## パフォーマンス最適化
### 起動時間最適化（30-50%短縮達成）
- **lazy loading徹底化**: 全プラグインを適切なトリガーで遅延読み込み
- **Telescope extensions**: 使用時読み込みで起動時負荷軽減
- **IME設定遅延**: VimEnter → InsertEnterで初期化遅延
- **TreeSitter遅延**: ファイル読み込み時まで遅延
- **Mason/LSP遅延**: コマンド/イベントトリガーで最適化

### 主な最適化技術
- `keys`, `cmd`, `event`を活用したlazy loading
- プラグインextensionの分離と遅延読み込み
- 重い初期化処理の適切なタイミング調整

## よく使用するコマンド
- `:Lazy`: プラグイン管理
- `:Mason`: LSPサーバー管理
- `<Leader>ff`: ファイル検索
- `<Leader>fg`: 文字列検索
- `<Leader>fp`: プロジェクト選択
- `<Leader>e`: ファイルツリー表示
- `<Leader>lf`: LSP参照・定義検索
- `<Leader>vl`: 参照数表示切替
- `<Leader>ic`: 設定ファイル編集
- `<Leader>ir`: 設定再読込

## トラブルシューティング
### 非推奨API対応済み
- `vim.lsp.get_active_clients()` → `vim.lsp.get_clients()`
- `luarocks` 無効化で警告回避

### 起動時間測定
```bash
nvim --startuptime startup.log +q
```

## LSP統合環境
### モダンなLSPワークフロー
- **lspsaga.nvim**: 美しいUI付きLSP操作（参照検索、定義ジャンプ、リネーム等）
- **symbol-usage.nvim**: シンボル上部に参照数をバーチャルテキスト表示
- **telescope-project.nvim**: プロジェクト間の高速移動
- **nvim-tree + oil.nvim**: プロジェクト俯瞰 + ファイル操作の最適な組み合わせ

### プロジェクト管理最適化
- **telescope-project**: `<Leader>fp`でプロジェクト選択
- **nvim-tree**: `<Leader>e`でツリー表示、プロジェクト全体俯瞰
- **oil.nvim**: `-`でファイル操作特化、バッファライクな編集
- **固定サインカラム**: アイコン表示時の画面ガクガク防止

## 環境
クロスプラットフォーム対応（Windows、macOS、Linux）
- Windows: IME自動切替対応
- 高速起動: lazy loading最適化
- which-key: 視覚的キーマップガイド
- Git統合: 基本機能はtelescope経由で軽量化
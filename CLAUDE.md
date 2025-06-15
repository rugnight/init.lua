# Neovim Configuration - CLAUDE.md

## プロジェクト概要
このディレクトリは個人用のNeovim設定ファイルです。Lua言語で記述され、現代的なNeovimプラグインエコシステムを活用した高速で効率的な開発環境を構築しています。QuickFix中心の統合ワークフローと編集可能QuickFixによる革新的な開発体験を提供します。

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
### 🚀 コアシステム
- **lazy.nvim**: プラグインマネージャー（rocks無効化、最適化済み）
- **telescope.nvim**: ファジーファインダー（QuickFix統合、extensions遅延読み込み）
- **nvim-treesitter**: シンタックスハイライト（イベント遅延）
- **lualine.nvim**: ステータスライン（VeryLazy最適化、非推奨API修正済み）

### 📋 QuickFix統合システム
- **quicker.nvim**: 編集可能QuickFix（直接編集・自動保存）
- **nvim-bqf**: QuickFix強化（プレビュー、フィルタリング、fzf統合）
- **trouble.nvim**: 美しい診断UI（QuickFix統合、レベル別表示）

### 🔍 LSP・開発支援
- **mason.nvim**: LSPサーバー管理（最適化済み）
- **lspsaga.nvim**: 高度なLSP UI（フローティング表示、QuickFix連携）
- **symbol-usage.nvim**: 参照数表示（above配置）
- **blink.cmp**: 補完エンジン

### 🗂️ ファイル管理
- **oil.nvim**: ファイルエクスプローラー（lazy loading最適化）
- **nvim-tree.lua**: プロジェクトツリー（ルート自動検出）
- **telescope-project.nvim**: プロジェクト管理

### 🎯 その他
- **harpoon2**: ファイル間移動
- **avante.nvim**: AI支援（カスタムキーマップ）
- **which-key.nvim**: キーマップガイド

## キーマップ体系
記憶しやすいニーモニックルールに基づく14カテゴリ構成：

### 📁 ファイル検索 (`<Leader>f*`)
- `ff` - ファイル検索, `fg` - 文字列検索, `fr` - 最近のファイル
- `fb` - バッファ検索, `fc` - コマンド検索, `fp` - プロジェクト選択

### 🔍 LSP操作 (`<Leader>l*`)
- **lspsaga統合**: `lf` - 参照・定義検索（フローティング）, `lr` - 参照一覧
- **QuickFix連携**: `lR` - 参照→QuickFix, `l;` - 前回結果再表示
- **基本操作**: `ld` - 定義移動, `lh` - ホバー, `la` - コードアクション
- **高度機能**: `ln` - リネーム, `lo` - アウトライン, `lF` - フォーマット

### 📋 QuickFix操作 (`<Leader>q*`) ⭐ **新規カテゴリ**
- **基本操作**: `qo/qc` - 開く/閉じる, `qn/qp` - 次/前項目
- **ナビゲーション**: `qf/ql` - 最初/最後, `q;` - 再表示
- **データ収集**: `qr` - LSP参照, `qd/qD` - 診断/エラーのみ
- **検索統合**: `qg` - Grep検索, `qG` - カーソル下検索, `qt` - TODO検索
- **高度操作**: `qR` - 一括置換, `qS/qL` - セッション保存/復元
- **変換**: `qm/qM` - QuickFix⇄LocationList
- **LocationList**: `qO/qC/qN/qP` - LocationList操作

### 🔀 Git操作 (`<Leader>g*`)
- `gc` - コミット履歴, `gb` - ブランチ一覧, `gs` - Git状態

### 🤖 AI操作 (`<Leader>a*`)
- `aa` - AI質問, `ae` - AI編集, `ar` - AI更新
- `ad` - AIデバッグ切替, `ah` - AIヒント切替, `as` - AIサイドバー切替

### 📑 ブックマーク (`<Leader>k*`)
- `km` - マークトグル, `ki` - コメント付きマーク, `kc` - マーク削除
- `kn/kp` - 次/前のマーク, `kl` - マーク一覧, `kx` - 全削除

### 👁️ 表示/UI (`<Leader>v*`)
- `vo` - アウトライン表示, `vz` - ゼンモード

### ✏️ コード操作 (`<Leader>c*`)
- `cj` - 行結合, `cs` - 行分割
- `ca/cA` - 整列/整列プレビュー

### その他のカテゴリ
- 🎯 Harpoon (`h*`), 📝 メモ/ノート (`m*`), 🚨 診断/トラブル (`x*`)
- ⚙️ 設定 (`i*`), 🔄 トグル (`t*`), 📋 バッファ (`b*`)

### 🌟 Telescopeショートカット
- **QuickFix統合**: `<C-q>` - 検索結果→QuickFix, `<C-l>` - LocationList
- **選択送信**: `<M-q>/<M-l>` - 選択項目のみ送信

## パフォーマンス最適化
### 起動時間最適化（40-60%短縮達成）
- **システムコール遅延**: hostname検出の遅延読み込み化
- **lazy loading徹底化**: 全プラグインを適切なトリガーで遅延読み込み
- **UI最適化**: lualine VeryLazy化、oil.nvim完全lazy loading
- **Telescope extensions**: 使用時読み込みで起動時負荷軽減
- **IME設定遅延**: VimEnter → InsertEnterで初期化遅延
- **TreeSitter遅延**: ファイル読み込み時まで遅延
- **Mason/LSP最適化**: 適切なイベントトリガーで最適化

### 主な最適化技術
- `keys`, `cmd`, `event`を活用したlazy loading
- プラグインextensionの分離と遅延読み込み
- 重い初期化処理の適切なタイミング調整
- システムコールの遅延実行（`vim.defer_fn`活用）

## よく使用するコマンド
### 📋 QuickFix中心ワークフロー
- `<Leader>qG`: カーソル下文字列のプロジェクト全体検索
- `<Leader>qr`: LSP参照→QuickFix
- `<Leader>qR`: 一括置換（検索→QuickFix→置換）
- `<Leader>qS/qL`: セッション保存/復元
- `<Leader>q;`: 前回のQuickFix結果再表示

### 🔍 検索・ナビゲーション
- `<Leader>ff`: ファイル検索
- `<Leader>fg`: 文字列検索（Telescope）→ `<C-q>`でQuickFix送信
- `<Leader>lf`: LSP参照・定義検索（lspsaga フローティング）
- `<Leader>vo`: アウトライン表示

### ⚙️ 管理・設定
- `:Lazy`: プラグイン管理
- `:Mason`: LSPサーバー管理
- `<Leader>ic`: 設定ファイル編集
- `<Leader>ir`: 設定再読込

### 🎯 推奨ワークフロー
1. **プロジェクト全体リファクタリング**: `<Leader>qG` → QuickFix確認 → `<Leader>qR`
2. **Telescope→QuickFix連携**: `<Leader>fg` → `<C-q>` → QuickFix編集
3. **エラー修正**: `<Leader>qd` → QuickFix内で`dd`削除 → 順次修正

## 革新的機能
### 🌟 編集可能QuickFix（quicker.nvim）
- QuickFix内で直接編集→自動保存
- `>`/`<`でコンテキスト拡張/縮小
- TreeSitter + LSPハイライト対応

### 🔄 統合ワークフロー
- **Telescope統合**: `<C-q>`で検索結果をQuickFixに直送
- **LSP統合**: 参照・診断結果の自動QuickFix化
- **セッション管理**: 作業状態の保存・復元
- **一括操作**: 段階的な安全な一括置換

### 🚀 自動化機能
- QuickFix結果の自動オープン・サイズ調整
- プロジェクトルート自動検出（nvim-tree）
- ウィンドウサイズの絶対位置基準リサイズ
- LSP情報の統合表示（lualine）

## トラブルシューティング
### 非推奨API対応済み
- `vim.lsp.get_active_clients()` → `vim.lsp.get_clients()`
- `luarocks` 無効化で警告回避

### Windows環境最適化
- ripgrepの一時ファイル問題解決（`vim.fn.systemlist`使用）
- パス問題対応（`**/*` → `.`）

### 起動時間測定
```bash
nvim --startuptime startup.log +q
```

### QuickFixセッション管理
```lua
-- セッション保存場所: ~/.local/share/nvim/qf_sessions/
-- 自動命名: qf_YYYYMMDD_HHMM.json
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
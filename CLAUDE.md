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
- **標準LSP補完**: Neovim標準補完機能使用

### 🗂️ ファイル管理
- **oil.nvim**: ファイルエクスプローラー（lazy loading最適化）
- **Otree.nvim**: プロジェクトツリー（トグル機能、qキー閉じる、プロジェクト自動切替）
- **telescope-project.nvim**: プロジェクト管理

### 🎯 コマンド・入力支援
- **telescope-cmdline.nvim**: VSCodeライクなコマンドパレット（`<Leader><Leader>`）
- **wilder.nvim**: コマンドライン入力補助（`:e ~/Doc<Tab>`等）
- **which-key.nvim**: キーマップガイド（VirtualText競合解決済み）

### 🤖 AI支援システム ⭐ **2025年1月拡張**
- **Claude Code**: 統合開発環境との連携（ターミナル統合、差分表示）
- **Gemini AI**: Google Gemini API連携（コード補完、説明、レビュー、テスト生成）
- **統合キーマップ**: `<Leader>a*`カテゴリで両AI統一操作
- **環境変数設定**: `GEMINI_API_KEY`でGemini API認証

## キーマップ体系
記憶しやすいニーモニックルールに基づく13カテゴリ構成：

### 📁 ファイル検索 (`<Leader>f*`)
- `ff` - ファイル検索, `fg` - 文字列検索, `fr` - 最近のファイル
- `fb` - バッファ検索, `fp` - プロジェクト選択
- `<Leader><Leader>` - **コマンドパレット**（VSCodeライク、全コマンド検索）

### 🎯 LSP操作 (`<Leader>l*`) ⭐ **Telescope統合強化**
- **Telescope参照検索**: `lr` - 参照検索（スマート表示）, `lR` - 参照検索（宣言除外）
- **QuickFix連携**: `lq` - 参照→QuickFix直送, `l;` - 前回結果再表示
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

### 🤖 AI操作 (`<Leader>a*`) ⭐ **Claude Code & Gemini統合**
- **Claude Code**: `ac` - 起動, `ap` - ペースト, `at` - トグル, `af` - フォーカス, `ar` - 再開, `aC` - 続行
- **Gemini AI**: `ag` - チャット, `aG` - コード補完, `ae` - コード説明, `au` - ユニットテスト生成, `av` - コードレビュー, `ah` - ヒント
- **共通操作**: `ab` - バッファ追加, `as` - 選択範囲送信, `aa/ad` - 差分受け入れ/拒否

### 📑 ブックマーク (`<Leader>k*`)
- `km` - マークトグル, `ki` - コメント付きマーク, `kc` - マーク削除
- `kn/kp` - 次/前のマーク, `kl` - マーク一覧, `kx` - 全削除

### 👁️ 表示/UI (`<Leader>v*`)
- `vo` - アウトライン表示, `vz` - ゼンモード
- `o` - アウトライン表示（通常ファイルのみ、特殊バッファ制御済み）
- `vl` - シンボル使用状況切替（which-key連携済み）

### ✏️ コード操作 (`<Leader>c*`)
- `cj` - 行結合, `cs` - 行分割
- `ca/cA` - 整列/整列プレビュー

### その他のカテゴリ
- 📝 メモ/ノート (`m*`), 🚨 診断/トラブル (`x*`) ⭐ **キーマップ競合解決済み**
- ⚙️ 設定 (`i*`), 🔄 トグル (`t*`), 📋 バッファ (`b*`)

### 🌟 コマンドパレット・入力支援 ⭐ **新機能**
- **コマンドパレット**: `<Leader><Leader>` - VSCodeライクな全コマンド検索・実行
- **コマンドライン補助**: `:e ~/Doc<Tab>` - ファイルパス・コマンド名の補完
- **役割分担**: パレット（コマンド発見）+ 補助（入力効率化）

### 🌟 Telescopeショートカット ⭐ **LSP統合強化**
- **QuickFix統合**: `<C-q>` - 検索結果→QuickFix, `<C-l>` - LocationList
- **選択送信**: `<M-q>/<M-l>` - 選択項目のみ送信
- **パス表示最適化**: smart/truncate表示でファイル名視認性向上
- **ファイル除外トグル**: `<C-i>` - Unity/開発ファイル除外のON/OFF切り替え

## パフォーマンス最適化
### 起動時間最適化（40-60%短縮達成）
- **システムコール遅延**: hostname検出の遅延読み込み化
- **lazy loading徹底化**: 全プラグインを適切なトリガーで遅延読み込み
- **UI最適化**: lualine VeryLazy化、oil.nvim完全lazy loading
- **Telescope extensions**: 使用時読み込みで起動時負荷軽減
- **IME設定遅延**: VimEnter → InsertEnterで初期化遅延
- **TreeSitter遅延**: ファイル読み込み時まで遅延
- **Mason/LSP最適化**: 適切なイベントトリガーで最適化

### 設定品質最適化（2024年12月最新）
- **ウィンドウ移動強化**: `noremap = true`でプラグイン競合を根本解決
- **不要ファイル整理**: 使用されていない`quickfix_*.lua`等を削除
- **キーマップ統一**: 絵文字カテゴリ分類で視認性・学習効率向上
- **設定一貫性**: 13ファイルにわたる日本語表記統一、which-key完全連携

### 主な最適化技術
- `keys`, `cmd`, `event`を活用したlazy loading
- プラグインextensionの分離と遅延読み込み
- 重い初期化処理の適切なタイミング調整
- システムコールの遅延実行（`vim.defer_fn`活用）

## よく使用するコマンド
### 📋 QuickFix中心ワークフロー ⭐ **統合強化版**
- `<Leader>qG`: カーソル下文字列のプロジェクト全体検索
- `<Leader>lq`: LSP参照→QuickFix直送（新）
- `<Leader>qR`: 一括置換（検索→QuickFix→置換）
- `<Leader>qS/qL`: セッション保存/復元
- `<Leader>q;`: 前回のQuickFix結果再表示

### 📁 ファイル管理 ⭐ **Otree操作性向上**
- `<Leader>e`: ファイルツリー完全トグル（開閉自動判定）
- `-`: oil.nvimファイル操作（親ディレクトリ）
- Otree内: `q/Esc`で閉じる、プロジェクト自動検出

### 🔍 検索・ナビゲーション ⭐ **Telescope統合完了**
- `<Leader>ff`: ファイル検索（Unity/開発ファイル自動除外、`<C-i>`でトグル）
- `<Leader>fg`: 文字列検索（Telescope）→ `<C-q>`でQuickFix送信、`<C-i>`でファイル除外切替
- `<Leader>lr`: LSP参照検索（Telescope、パス表示最適化）
- `<Leader>lR`: LSP参照検索（宣言除外、短縮表示）
- `<Leader>vo` / `<Leader>o`: アウトライン表示（特殊バッファ制御済み）

### ⚙️ 管理・設定
- `:Lazy`: プラグイン管理
- `:Mason`: LSPサーバー管理
- `<Leader>ic`: 設定ファイル編集
- `<Leader>ir`: 設定再読込

### 🎯 推奨ワークフロー ⭐ **統合強化版**
1. **プロジェクト全体リファクタリング**: `<Leader>qG` → QuickFix確認 → `<Leader>qR`
2. **LSP参照→QuickFix連携**: `<Leader>lr` → `<C-q>` または `<Leader>lq`直送
3. **Telescope→QuickFix連携**: `<Leader>fg` → `<C-q>` → QuickFix編集
4. **エラー修正**: `<Leader>qd` → QuickFix内で`dd`削除 → 順次修正

## 革新的機能
### 🌟 編集可能QuickFix（quicker.nvim）
- QuickFix内で直接編集→自動保存
- `>`/`<`でコンテキスト拡張/縮小
- TreeSitter + LSPハイライト対応

### 🔄 統合ワークフロー ⭐ **2025年1月強化版**
- **コマンドパレット統合**: `<Leader><Leader>`でVSCodeライクなコマンド発見・実行
- **入力補助統合**: `:e ~/Doc<Tab>`でリアルタイムファイルパス補完
- **Telescope統合**: `<C-q>`で検索結果をQuickFixに直送、パス表示最適化
- **Unity開発最適化**: metaファイル・dllなど実行ファイル自動除外、`<C-i>`でトグル切替
- **LSP統合**: Telescope参照検索→QuickFix、競合解消済み
- **セッション管理**: 作業状態の保存・復元
- **一括操作**: 段階的な安全な一括置換
- **UI制御**: アウトライン特殊バッファ制御、ウィンドウ移動競合解決

### 🚀 自動化機能
- QuickFix結果の自動オープン・サイズ調整
- プロジェクトルート自動検出（Otree.nvim）
- ウィンドウサイズの絶対位置基準リサイズ
- LSP情報の統合表示（lualine）
- キーマップ説明の絵文字自動分類（📁🎯📋🤖等）

## トラブルシューティング
### 非推奨API対応済み
- `vim.lsp.get_active_clients()` → `vim.lsp.get_clients()`
- `luarocks` 無効化で警告回避

### プラグイン競合解決済み（2025年1月）
- **キーマップ競合**: `<Leader>e`診断フロート→`<Leader>xd`に移動、ファイルマネージャー優先
- **ウィンドウ移動**: `noremap = true`でoil.nvim等との`<C-l>`競合解決
- **アウトライン制御**: 特殊バッファ（Otree、QuickFix等）での誤動作防止
- **LSP参照**: lspsaga→Telescope統合でキーマップ重複解消
- **VirtualText表示**: which-key表示時のsymbol-usage自動制御で視認性向上
- **Otree操作**: qキー閉じる機能とトグル完全実装

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

### 設定品質管理
- 不要ファイル整理済み（quickfix_*.lua等削除）
- キーマップ説明統一（絵文字カテゴリ分類）
- which-key連携完全化

## LSP統合環境
### モダンなLSPワークフロー
- **lspsaga.nvim**: 美しいUI付きLSP操作（参照検索、定義ジャンプ、リネーム等）
- **symbol-usage.nvim**: シンボル上部に参照数をバーチャルテキスト表示
- **telescope-project.nvim**: プロジェクト間の高速移動
- **Otree.nvim + oil.nvim**: 統合ファイル管理、プロジェクト俯瞰 + ファイル操作の最適な組み合わせ

### プロジェクト管理最適化
- **telescope-project**: `<Leader>fp`でプロジェクト選択
- **Otree.nvim**: `<Leader>e`でツリー表示、oil.nvim統合、プロジェクト全体俯瞰
- **oil.nvim**: `-`でファイル操作特化、バッファライクな編集
- **固定サインカラム**: アイコン表示時の画面ガクガク防止

## 環境
クロスプラットフォーム対応（Windows、macOS、Linux）
- Windows: IME自動切替対応
- 高速起動: lazy loading最適化
- which-key: 視覚的キーマップガイド
- Git統合: 基本機能はtelescope経由で軽量化

### AI環境設定 ⭐ **新規追加**
#### Gemini AI設定
```bash
# Google AI Studio（https://aistudio.google.com/app/apikey）でAPIキー取得
export GEMINI_API_KEY="your_api_key_here"

# Windows（PowerShell）
$env:GEMINI_API_KEY="your_api_key_here"

# または .bashrc/.zshrcに永続設定
echo 'export GEMINI_API_KEY="your_api_key_here"' >> ~/.bashrc
```

#### Claude Code設定
- Claude Codeは既存設定済み（`<Leader>a*`キーマップ）
- ターミナル統合、差分表示機能使用可能

## Otree.nvim 設定知見

### 基本設定 ⭐ **操作性向上済み**
Otree.nvimはnvim-treeの代替として導入し、oil.nvimとの統合を重視した設定を採用。

```lua
require("Otree").setup({
  win_size = 30,
  hijack_netrw = true,
  oil = "float", -- oil.nvim連携（フロート表示）
  git = {
    enable = false, -- 大きなプロジェクトでのパフォーマンス改善
  },
  use_default_keymaps = false, -- カスタムキーマップ使用
  keymaps = {
    ["q"] = "actions.close",      -- qキーで閉じる
    ["<Esc>"] = "actions.close",  -- Escキーでも閉じる
    -- その他基本操作キーマップ...
  },
})
```

### プロジェクトルート自動検出機能
`<Leader>e`でファイルツリーを開く際、現在のファイルから自動的にプロジェクトルートを検出：

- **検出パターン**: `.git`, `*.csproj`, `*.sln`, `package.json`, `Cargo.toml`, `pom.xml`, `init.lua`
- **動的切り替え**: 異なるプロジェクトファイルを開いた際、自動的にプロジェクトルートを変更
- **バッファ管理**: プロジェクト切り替え時は既存のOtreeバッファを削除して再作成

### 完全トグル機能 ⭐ **2024年12月実装**
`<Leader>e`キーマップの正確なトグル動作：
- **状態検知**: ウィンドウのfiletype='Otree'で開閉状態を判定
- **開いている場合**: ウィンドウを閉じる
- **閉じている場合**: プロジェクトルート検出→ツリーを開く
- **プロジェクト切り替え対応**: 異なるプロジェクトでは自動リフレッシュ

### キーマップ改善
1. **外部からの操作**: `<Leader>e` - 完全トグル
2. **内部での操作**: `q/Esc` - 閉じる、`f` - フォーカス、`r` - リフレッシュ
3. **ファイル操作**: `o` - oil.nvim連携、基本ナビゲーション維持

### 制限事項と対応
1. **ファイルフォーカス機能**: `f`キーによる現在ファイルへのフォーカスは大きなプロジェクトで不安定
   - 自動フォーカス機能は無効化
   - 手動での`f`キー操作に依存

2. **競合解決済み**:
   - ウィンドウ移動キー（`<C-l>`等）との競合解消
   - カスタムキーマップで安全な操作確保

### 推奨ワークフロー ⭐ **改善版**
1. `<Leader>e`: プロジェクトツリーの完全トグル（開閉自動判定）
2. `-`: oil.nvimでファイル操作（親ディレクトリ移動）
3. Otree内: `q/Esc`で素早く閉じる、`f`で必要時フォーカス
4. プロジェクト切り替え: 自動検出→自動リフレッシュ

## Telescope ファイル除外システム ⭐ **2024年12月新機能**

### 🎯 Unity/開発ファイル自動除外
デフォルトで以下のファイル・フォルダを除外し、検索効率を大幅改善：

#### Unity関連
- `*.meta` - Unityメタファイル
- `Library/**` - Unityライブラリフォルダ
- `Temp/**` - Unity一時ファイル
- `Logs/**` - Unityログファイル

#### 実行ファイル・バイナリ
- `*.dll`, `*.exe` - Windows実行ファイル
- `*.so`, `*.dylib` - Unix系共有ライブラリ
- `*.pdb`, `*.mdb` - デバッグ情報ファイル

#### 開発環境・ビルド出力
- `obj/**`, `bin/**` - .NETビルド出力
- `.vs/**`, `.vscode/**` - IDE設定フォルダ
- `node_modules/**` - Node.js依存関係

### 📋 動的トグル機能
- **基本**: `.gitignore`に基づく除外（デフォルトON）
- **トグルキー**: `<C-i>` - Telescope画面内で除外ON/OFF切り替え
- **対象**: ファイル検索（`<Leader>ff`）と文字列検索（`<Leader>fg`）
- **状態表示**: 画面下部にメッセージで現在の状態を表示

### 🚀 技術仕様
- **ripgrep使用**: `--glob`パターンによる高速除外
- **リアルタイム切替**: 検索中でも即座にフィルター変更
- **最小限.git除外**: 全表示モードでも`.git`フォルダは常に除外
- **パフォーマンス**: 大型Unityプロジェクトでも高速検索を実現

### 🎯 推奨ワークフロー
1. `<Leader>ff` / `<Leader>fg` - 通常検索（不要ファイル自動除外）
2. `<C-i>` - 必要時に全ファイル表示に切り替え
3. 再度 `<C-i>` - 除外モードに戻す
4. 状態メッセージで現在の除外設定を確認
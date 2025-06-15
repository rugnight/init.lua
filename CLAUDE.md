# Neovim Configuration - CLAUDE.md

## プロジェクト概要
このディレクトリは個人用のNeovim設定ファイルです。Lua言語で記述され、現代的なNeovimプラグインエコシステムを活用した開発環境を構築しています。

## ディレクトリ構造
```
~/.config/nvim/
├── init.lua                 # メイン設定ファイル
├── lazy-lock.json          # プラグインバージョンロック
├── lua/
│   ├── ime.lua             # IME設定
│   ├── my_functions.lua    # カスタム関数
│   ├── plugins/            # プラグイン定義
│   ├── plugins_autoloads/  # プラグイン設定
│   └── plugins_setup.lua   # プラグインセットアップ
├── luasnippets/            # コードスニペット
└── setup_win.bat          # Windows用セットアップ
```

## 主要設定
- **リーダーキー**: `;`
- **フォント**: HackGen Console NF
- **エンコーディング**: UTF-8
- **タブ設定**: 4スペース
- **日本語IME対応**: 有効

## 主要プラグイン
- **lazy.nvim**: プラグインマネージャー
- **telescope.nvim**: ファジーファインダー
- **nvim-treesitter**: シンタックスハイライト
- **lualine.nvim**: ステータスライン
- **mason.nvim**: LSPサーバー管理
- **blink.cmp**: 補完エンジン
- **oil.nvim**: ファイルエクスプローラー
- **harpoon2**: ファイル間移動
- **lazygit**: Git統合

## よく使用するコマンド
- `:Lazy`: プラグイン管理
- `:Mason`: LSPサーバー管理
- `:Telescope find_files`: ファイル検索
- `:Oil`: ファイルエクスプローラー
- `<Leader>ii`: init.lua編集
- `<Leader>is`: init.lua再読込

## 環境
クロスプラットフォーム対応（Windows、macOS、Linux）
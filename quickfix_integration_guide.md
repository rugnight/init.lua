# QuickFix強化統合ガイド

## 現在の設定への統合方法

### 1. プラグイン設定の更新

**`/mnt/c/Users/rugni/.config/nvim/lua/plugins_autoloads/quickfix.lua`** を以下のように更新：

```lua
return {
  -- 既存のnvim-bqf設定（そのまま維持）
  {
    "kevinhwang91/nvim-bqf",
    event = "QuickFixCmdPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "junegunn/fzf",
    },
    opts = {
      auto_enable = true,
      auto_resize_height = true,
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border_chars = { "┃", "━", "┏", "┓", "┗", "┛", "┣", "┫", "┳", "┻" },
      },
      func_map = {
        vsplit = "",
        ptogglemode = "z,",
        stoggleup = "",
      },
      filter = {
        fzf = {
          action_for = { ["ctrl-s"] = "split" },
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
        },
      },
    },
  },

  -- 【新規追加】quicker.nvim
  {
    "stevearc/quicker.nvim",
    event = "QuickFixCmdPost",
    opts = {
      edit = { enabled = true, autosave = true },
      context = 3,
      highlight = { treesitter = true, lsp = true },
      keys = {
        { ">", function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end, desc = "コンテキスト展開" },
        { "<", function() require("quicker").collapse() end, desc = "コンテキスト折りたたみ" },
      },
    },
  },

  -- 【新規追加】vim-qf
  {
    "romainl/vim-qf",
    event = "QuickFixCmdPost",
    init = function()
      vim.g.qf_shorten_path = 3
      vim.g.qf_auto_open_quickfix = false
      vim.g.qf_auto_open_loclist = false
      vim.g.qf_auto_resize = true
      vim.g.qf_max_height = 15
    end,
  },

  -- 既存のtrouble.nvim設定を改善
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      -- 既存のキーマップ + 新規追加
      { "<leader>qx", "<cmd>Trouble diagnostics toggle<cr>", desc = "診断一覧(Trouble)" },
      { "<leader>qX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "バッファ診断(Trouble)" },
      { "<leader>qs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "シンボル一覧(Trouble)" },
      { "<leader>qr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP参照(Trouble)" },
      { "<leader>qL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List(Trouble)" },
      { "<leader>qQ", "<cmd>Trouble qflist toggle<cr>", desc = "QuickFix List(Trouble)" },
      
      -- 新規追加：診断レベル別表示
      { "<leader>xe", "<cmd>Trouble diagnostics toggle severity=ERROR<cr>", desc = "エラーのみ表示" },
      { "<leader>xw", "<cmd>Trouble diagnostics toggle severity=WARN<cr>", desc = "警告のみ表示" },
    },
  },
}
```

### 2. which-key設定の更新

**`/mnt/c/Users/rugni/.config/nvim/lua/plugins_autoloads/which-key.lua`** に以下を追加：

```lua
-- 既存のグループ定義に追加
wk.add({
  -- 既存の設定...
  { "<leader>q", group = "📋 QuickFix操作" },  -- 既存の行を更新
  { "<leader>qo", desc = "QuickFix開く" },
  { "<leader>qc", desc = "QuickFix閉じる" },
  { "<leader>qn", desc = "次のエラー" },
  { "<leader>qp", desc = "前のエラー" },
  { "<leader>qR", desc = "段階的一括置換" },
  { "<leader>qS", desc = "セッション保存" },
  { "<leader>qL", desc = "セッション復元" },
  { "<leader>qi", desc = "統計表示" },
  -- LocationList
  { "<leader>l", group = "📍 LocationList" },
  { "<leader>lo", desc = "LocationList開く" },
  { "<leader>lc", desc = "LocationList閉じる" },
  { "<leader>ln", desc = "次のLocation" },
  { "<leader>lp", desc = "前のLocation" },
})
```

### 3. 初期化スクリプトの追加

**`/mnt/c/Users/rugni/.config/nvim/init.lua`** に以下を追加（最下部に）：

```lua
-- QuickFix強化設定の読み込み（最後に追加）
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- QuickFix強化キーマップの設定
    require('quickfix_keymaps')
  end,
})
```

### 4. Telescopeとの統合強化

**`/mnt/c/Users/rugni/.config/nvim/lua/plugins_autoloads/telescope.lua`** に以下を追加：

```lua
-- Telescope設定のmappingsに追加
defaults = {
  mappings = {
    i = {
      -- 既存のマッピング...
      ["<C-q>"] = function(prompt_bufnr)
        require('telescope.actions').send_to_qflist(prompt_bufnr)
        vim.cmd('copen')
      end,
      ["<C-l>"] = require('telescope.actions').send_to_loclist,
    },
    n = {
      -- 既存のマッピング...  
      ["<C-q>"] = function(prompt_bufnr)
        require('telescope.actions').send_to_qflist(prompt_bufnr)
        vim.cmd('copen')
      end,
      ["<C-l>"] = require('telescope.actions').send_to_loclist,
    },
  },
},
```

## 実践的ワークフロー例

### 1. プロジェクト全体リファクタリング
```
1. <leader>fg → 検索パターン入力 → QuickFixに結果表示
2. zf → fzfモードでフィルタリング
3. <leader>qR → 段階的置換実行
4. <leader>qS → 作業セッション保存
```

### 2. エラー修正ワークフロー
```
1. <leader>xe → エラー診断のみ表示
2. <leader>qn/<leader>qp → エラー間移動
3. 修正後 → <leader>qd → 修正済みバッファ削除
```

### 3. LSP統合ワークフロー
```
1. <leader>lR → LSP参照をQuickFixに送信
2. > → コンテキスト展開（quicker.nvim）
3. 直接編集 → :w → 一括保存（quicker.nvim）
```

## パフォーマンス最適化のポイント

### 1. 遅延読み込み最適化
- `event = "QuickFixCmdPost"` で初回使用時のみ読み込み
- AutoCommandを使った段階的初期化

### 2. メモリ効率化
- セッション保存はJSON形式で軽量化
- 大量エントリ時の自動フィルタリング

### 3. UI応答性向上
- 非同期処理での検索実行
- プレビューウィンドウの遅延更新

## トラブルシューティング

### よくある問題と解決策

1. **プラグイン競合**
   - quicker.nvimとnvim-bqf併用時のプレビュー更新遅延
   - 解決：nvim-bqfのpreview.delay_syntaxを調整

2. **キーマップ競合**
   - 既存のキーマップとの重複
   - 解決：which-key設定で優先度調整

3. **パフォーマンス問題**
   - 大量エントリ時の動作遅延
   - 解決：cfilterプラグインでエントリ絞り込み

## 段階的導入推奨順序

### Phase 1: 基本強化
1. quicker.nvimの追加
2. 基本キーマップの設定
3. AutoCommand設定

### Phase 2: 統合強化  
1. Telescope統合
2. LSP統合
3. 診断統合

### Phase 3: ワークフロー最適化
1. セッション管理
2. 一括操作機能
3. 統計・分析機能

この順序で段階的に導入することで、既存の設定を破綻させることなく、QuickFix機能を大幅に強化できます。
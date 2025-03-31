-- trouble.nvim の設定
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "TroubleToggle", "Trouble" },
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "ドキュメント診断 (Trouble)" },
    { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "ワークスペース診断 (Trouble)" },
    { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "ロケーションリスト (Trouble)" },
    { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "クイックフィックスリスト (Trouble)" },
    { "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", desc = "参照一覧 (Trouble)" },
    { "<leader>xd", "<cmd>TroubleToggle lsp_definitions<cr>", desc = "定義一覧 (Trouble)" },
    { "<leader>xt", "<cmd>TroubleToggle lsp_type_definitions<cr>", desc = "型定義一覧 (Trouble)" },
    { "gR", "<cmd>TroubleToggle lsp_references<cr>", desc = "LSP参照一覧 (Trouble)" },
  },
  opts = {
    position = "bottom", -- "bottom" または "left"
    height = 10, -- 高さを調整（"bottom" でのみ適用）
    width = 50, -- 幅を調整（"left" でのみ適用）
    icons = true, -- アイコンを使用
    mode = "workspace_diagnostics", -- デフォルトモード
    fold_open = "", -- 開いたフォールディングのアイコン
    fold_closed = "", -- 閉じたフォールディングのアイコン
    group = true, -- グループごとにアイテムをまとめる
    padding = true, -- パディングを追加
    cycle_results = true, -- Tab/S-Tabでの結果間のサイクル
    action_keys = { -- カスタムキーマッピング
      close = "q", -- Troubleを閉じる
      cancel = "<esc>", -- キャンセル
      refresh = "r", -- 更新
      jump = {"<cr>", "<tab>"}, -- 項目にジャンプ
      open_split = {"<c-x>"}, -- 水平分割して開く
      open_vsplit = {"<c-v>"}, -- 垂直分割して開く
      open_tab = {"<c-t>"}, -- 新しいタブで開く
      jump_close = {"o"}, -- ジャンプして閉じる
      toggle_mode = "m", -- モード切り替え
      toggle_preview = "P", -- プレビューの切り替え
      hover = "K", -- ホバー情報を表示
      preview = "p", -- プレビュー表示
      close_folds = {"zM", "zm"}, -- すべてのフォールドを閉じる
      open_folds = {"zR", "zr"}, -- すべてのフォールドを開く
      toggle_fold = {"zA", "za"}, -- フォールドの切り替え
      previous = "k", -- 前の項目
      next = "j" -- 次の項目
    },
    indent_lines = true, -- インデント線を表示
    auto_open = false, -- 診断がある場合に自動で開かない
    auto_close = false, -- ジャンプ後に自動で閉じない
    auto_preview = true, -- 項目を選択時に自動でプレビュー
    auto_fold = false, -- 自動フォールディングを無効
    auto_jump = {"lsp_definitions"}, -- lsp_definitions で自動ジャンプ
    signs = {
      -- LSP診断のアイコン
      error = "",
      warning = "",
      hint = "",
      information = "",
      other = ""
    },
    use_diagnostic_signs = false -- LSPの診断サインを使う
  }
}
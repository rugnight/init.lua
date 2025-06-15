-- QuickFix強化設定 - 現在の設定への追加推奨内容
return {
  -- 既存のnvim-bqf設定はそのまま維持
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

  -- 【新規追加】quicker.nvim - 2024年の新星
  {
    "stevearc/quicker.nvim",
    event = "QuickFixCmdPost",
    opts = {
      -- QuickFixバッファを編集可能にする
      edit = {
        enabled = true,
        autosave = true, -- 編集後自動保存
      },
      -- 周辺コンテキスト表示
      context = 3,
      -- シンタックスハイライト
      highlight = {
        treesitter = true,
        lsp = true,
      },
      -- カスタムキーマップ（QuickFixウィンドウ内）
      keys = {
        {
          ">",
          function()
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
          end,
          desc = "コンテキスト展開",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "コンテキスト折りたたみ",
        },
      },
    },
  },

  -- 【新規追加】vim-qf - 経典プラグイン
  {
    "romainl/vim-qf",
    event = "QuickFixCmdPost",
    init = function()
      -- パス表示を短縮
      vim.g.qf_shorten_path = 3
      -- 自動オープンを無効（手動制御）
      vim.g.qf_auto_open_quickfix = false
      vim.g.qf_auto_open_loclist = false
      -- 自動リサイズ
      vim.g.qf_auto_resize = true
      vim.g.qf_max_height = 15
    end,
  },

  -- 既存のtrouble.nvim設定を統合・改善
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      -- QuickFix統合キーマップ（既存設定を改善）
      { "<leader>qx", "<cmd>Trouble diagnostics toggle<cr>", desc = "診断一覧(Trouble)" },
      { "<leader>qX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "バッファ診断(Trouble)" },
      { "<leader>qs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "シンボル一覧(Trouble)" },
      { "<leader>qr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP参照(Trouble)" },
      { "<leader>qL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List(Trouble)" },
      { "<leader>qQ", "<cmd>Trouble qflist toggle<cr>", desc = "QuickFix List(Trouble)" },
      
      -- 【新規追加】診断レベル別表示
      { "<leader>xe", "<cmd>Trouble diagnostics toggle severity=ERROR<cr>", desc = "エラーのみ表示" },
      { "<leader>xw", "<cmd>Trouble diagnostics toggle severity=WARN<cr>", desc = "警告のみ表示" },
    },
    opts = {
      auto_preview = true,
      modes = {
        symbols = {
          desc = "シンボル一覧",
          focus = true,
          win = { type = "float", position = 'right' },
        },
        -- 【新規追加】QuickFix専用モード
        qf_enhanced = {
          mode = "qflist",
          preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.3,
          },
        },
      },
    },
  },
}
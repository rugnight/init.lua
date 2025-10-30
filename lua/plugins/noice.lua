----------------------------------------------------------------------------------------------------
--- 美しい統合UI (messages, cmdline, popupmenu)
--- 実験的プラグイン - 段階的導入
----------------------------------------------------------------------------------------------------
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify", -- 既存のnvim-notifyと統合
    "nvim-treesitter/nvim-treesitter", -- シンタックスハイライト用
  },
  config = function()
    require("noice").setup({
      -- 推奨プリセット設定（機能強化版）
      presets = {
        bottom_search = true,         -- 検索UIを下部に配置（noiceの美しい検索UI）
        command_palette = true,       -- コマンドパレット強化
        long_message_to_split = true, -- 長いメッセージを分割表示
        inc_rename = false,           -- inc-rename統合（未使用）
        lsp_doc_border = true,        -- LSPドキュメントのボーダー
      },

      -- LSP設定
      lsp = {
        override = {
          -- LSPマークダウンの美しい表示
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          -- cmpとの統合
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          enabled = true,
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          throttle = 1000 / 30, -- 30fps
          view = "mini",
        },
        hover = {
          enabled = true,
          silent = false, -- ホバー時のメッセージ表示
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true,
            luasnip = true,
            throttle = 50,
          },
        },
      },

      -- メッセージルーティング
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true }, -- "written"メッセージをスキップ
        },
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "more lines",
          },
          opts = { skip = true }, -- "more lines"メッセージをスキップ
        },
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "fewer lines",
          },
          opts = { skip = true }, -- "fewer lines"メッセージをスキップ
        },
        {
          filter = {
            event = "notify",
            kind = "warn",
            find = "Otree: unknown action",
          },
          opts = { skip = true }, -- Otreeの不明なアクション警告をスキップ
        },
        {
          filter = {
            event = "notify",
            kind = "warn",
            find = "lazy%.nvim.*Config Change Detected",
          },
          opts = { skip = true }, -- lazy.nvimの設定変更通知をスキップ
        },
      },

      -- コマンドライン設定（強化版）
      cmdline = {
        enabled = true,
        view = "cmdline_popup", -- ポップアップ形式
        opts = {}, -- グローバルopts
        format = {
          -- コマンド
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          -- 検索（強化されたアイコンと設定）
          search_down = { pattern = "^/", icon = " ", lang = "regex" },
          search_up = { pattern = "^%?", icon = " ", lang = "regex" },
          -- システムコマンド
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          -- 各種言語
          lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          -- 追加コマンド
          substitute = { pattern = "^:%%?s/", icon = "", lang = "regex" },
          input = { view = "cmdline_input", icon = "󰥻 " },
        },
      },

      -- メッセージ表示設定（強化版）
      messages = {
        enabled = true,
        view = "notify", -- nvim-notifyを使用
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext", -- 検索結果をバーチャルテキストで表示
      },

      -- ポップアップメニュー設定（強化版）
      popupmenu = {
        enabled = true,
        backend = "nui", -- nui.nvimを使用
        -- 美しいアイコン設定
        kind_icons = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = " ",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "",
          Event = "",
          Operator = "󰆕",
          TypeParameter = " ",
          Array = "󰅪",
          Boolean = "",
          Number = "",
          String = "󰀬",
          Object = "󰅩",
          Key = "󰌋",
          Null = "󰟢",
        },
      },

      -- ビュー設定（強化版）
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
        -- 検索結果の美しい表示
        virtualtext = {
          backend = "virtualtext",
        },
        -- 分割表示設定
        split = {
          enter = true,
          size = "20%",
        },
        -- mini通知設定（穏やかな表示）
        mini = {
          position = {
            row = -2,
          },
          size = {
            width = "auto",
            height = "auto",
          },
          border = {
            style = "none",
          },
          timeout = 2000, -- 2秒で自動消去（穏やか）
          reverse = false, -- 新しいメッセージを下に表示
          win_options = {
            winblend = 30,
          },
        },
      },

      -- 通知設定（nvim-notifyとの統合、穏やかな設定）
      notify = {
        enabled = true,
        view = "notify",
        timeout = 3000, -- 3秒で自動消去
        max_width = 50, -- 最大幅制限
        max_height = 10, -- 最大高さ制限
        level = vim.log.levels.INFO, -- INFO以上のみ表示（DEBUG等を除外）
      },

      -- パフォーマンス最適化
      throttle = 1000 / 30, -- 30fps制限

      -- 健康チェック設定
      health = {
        checker = false, -- 定期的な健康チェックを無効化（パフォーマンス向上）
      },

      -- スマートな移動設定
      smart_move = {
        enabled = true, -- スマート移動を有効化
        excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
      },

      -- 高度なフィルタリング
      format = {
        level = {
          icons = {
            error = " ",
            warn = " ",
            info = " ",
            debug = " ",
            trace = "✎ ",
          },
        },
      },
    })

    -- noice用キーマップ
    vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
      if not require("noice.lsp").scroll(4) then
        return "<c-f>"
      end
    end, { silent = true, expr = true, desc = "Scroll forward" })

    vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
      if not require("noice.lsp").scroll(-4) then
        return "<c-b>"
      end
    end, { silent = true, expr = true, desc = "Scroll backward" })

    -- 📋 Noice基本操作
    vim.keymap.set("n", "<leader>nm", "<cmd>Noice history<cr>", { desc = "🔔 全メッセージ履歴" })
    vim.keymap.set("n", "<leader>nl", "<cmd>Noice last<cr>", { desc = "🔔 最新メッセージ" })
    vim.keymap.set("n", "<leader>nd", "<cmd>Noice dismiss<cr>", { desc = "🔔 通知消去" })

    -- Warning/Error専用の表示機能（改良版）
    vim.keymap.set("n", "<leader>nw", function()
      require("noice").cmd("history")
      -- 履歴表示後にwarningでフィルタ（エラーハンドリング付き）
      vim.defer_fn(function()
        -- 安全にパターン検索を実行
        local ok, _ = pcall(function()
          vim.cmd("silent! g/WARN\\|ERROR\\|warn\\|error/")
        end)
        if not ok then
          -- パターンが見つからない場合の処理
          vim.notify("Warning/Errorメッセージが見つかりませんでした", vim.log.levels.INFO, { title = "Noice" })
        end
      end, 100)
    end, { desc = "🔔 Warning/Error履歴" })

    -- より実用的な診断メッセージ表示
    vim.keymap.set("n", "<leader>ne", function()
      -- LSP診断をQuickFixに表示（より確実）
      vim.diagnostic.setqflist({ severity = { min = vim.diagnostic.severity.ERROR } })
      vim.cmd("copen")
    end, { desc = "🔔 LSPエラー診断" })

    -- 通知履歴から特定レベルのメッセージを検索
    vim.keymap.set("n", "<leader>nf", function()
      require("noice").cmd("history")
      vim.defer_fn(function()
        -- 検索モードに入る
        vim.api.nvim_feedkeys("/", "n", false)
      end, 100)
    end, { desc = "🔔 履歴内検索" })

    -- Telescopeでメッセージ履歴を見やすく表示
    vim.keymap.set("n", "<leader>nt", function()
      pcall(function()
        require("noice").cmd("telescope")
      end)
    end, { desc = "🔔 メッセージ履歴（Telescope）" })

    -- 最近の情報メッセージのみ表示
    vim.keymap.set("n", "<leader>ni", function()
      require("noice").cmd("history")
      vim.defer_fn(function()
        -- INFO レベルのメッセージを検索
        vim.api.nvim_feedkeys("/\\(INFO\\|info\\|Info\\)", "n", false)
      end, 100)
    end, { desc = "🔔 情報メッセージ履歴" })

    -- 高度なnoice機能
    vim.keymap.set("n", "<leader>ns", "<cmd>Noice stats<cr>", { desc = "🔔 Noice統計情報" })

    -- Escキーでnoice通知を消去（安全な実装）
    vim.keymap.set({ "n", "i" }, "<Esc>", function()
      -- pcallで安全にdismissを実行
      pcall(function()
        require("noice").cmd("dismiss")
      end)
      return "<Esc>"
    end, { expr = true, desc = "Dismiss noice and normal Esc" })

    -- コマンドライン履歴の改善
    vim.keymap.set("c", "<S-Enter>", function()
      require("noice").redirect(vim.fn.getcmdline())
    end, { desc = "Redirect Cmdline" })

    -- より良い検索体験のためのautocmd
    local noice_group = vim.api.nvim_create_augroup("NoiceConfig", { clear = true })
    vim.api.nvim_create_autocmd("CmdlineEnter", {
      group = noice_group,
      pattern = { "/", "?" },
      callback = function()
        -- 検索時の特別な設定
        vim.opt_local.hlsearch = true
      end,
    })
  end,
}
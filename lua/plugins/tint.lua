----------------------------------------------------------------------------------------------------
--- 非アクティブウィンドウの暗色化（画面分割時の視認性向上）
--- モダンで軽量なウィンドウハイライトプラグイン
----------------------------------------------------------------------------------------------------
return {
  "levouh/tint.nvim",
  event = "WinNew", -- ウィンドウ作成時に読み込み
  config = function()
    require("tint").setup({
      -- 基本設定（より穏やかな設定）
      tint = -15, -- 非アクティブウィンドウの暗さ（-30から-15に変更、より穏やか）
      saturation = 0.8, -- 彩度の調整（0.6から0.8に変更、より自然な色合い）

      -- ハイライト変換方式
      transforms = require("tint").transforms.SATURATE_TINT,

      -- 詳細設定
      tint_background_colors = true, -- 背景色も暗くする
      tint_foreground_colors = false, -- 前景色（テキスト色）は変更しない

      -- 除外するハイライトグループ（最小限に変更）
      highlight_ignore_patterns = {
        "WinSeparator", -- ウィンドウ境界線
        "Status.*", -- ステータスライン関連
        "TabLine.*", -- タブライン関連
        "BufferLine.*", -- バッファライン関連
        "lualine.*", -- lualine関連
        -- NoiceCmd.*を削除してnoice画面も暗くする
        -- TelescopePrompt.*を削除してtelescope画面も暗くする
        -- NvimTree.*、Otree.*を削除してファイルツリーも暗くする
      },

      -- 除外するウィンドウタイプ（Claude用画面も含めて暗くするため、ターミナルを除外しない）
      window_ignore_function = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
        local filetype = vim.api.nvim_buf_get_option(bufid, "filetype")

        -- 最小限の除外設定（Claudeターミナルも暗くする）
        local excluded_buftypes = {
          -- "terminal", -- 削除：Claude用ターミナルも暗くする
          "quickfix", -- QuickFixは除外
          -- "help", -- 削除：ヘルプも暗くする
          -- "nofile", -- 削除：特殊バッファも暗くする
          -- "prompt", -- 削除：プロンプトバッファも暗くする
        }

        -- ごく一部のみ除外
        local excluded_filetypes = {
          -- "neo-tree", -- 削除：ファイルツリーも暗くする
          -- "Otree", -- 削除：Otreeも暗くする
          -- "oil", -- 削除：oilも暗くする
          -- "telescope", -- 削除：telescopeも暗くする
          "lazy", -- プラグインマネージャーのみ除外
          "mason", -- LSPサーバー管理のみ除外
          -- "lspinfo", -- 削除：LSP情報も暗くする
          -- "null-ls-info", -- 削除
          -- "checkhealth", -- 削除
          -- "help", -- 削除
          -- "startuptime", -- 削除
          "qf", -- QuickFixのみ除外
          -- "trouble", -- 削除：troubleも暗くする
        }

        return vim.tbl_contains(excluded_buftypes, buftype) or
               vim.tbl_contains(excluded_filetypes, filetype)
      end,
    })

    -- キーマップ設定（オプション）
    vim.keymap.set("n", "<leader>vt", "<cmd>TintToggle<cr>", {
      desc = "👁️ ウィンドウ暗色化切替",
      silent = true
    })

    -- 手動でtintを無効/有効にするコマンド
    vim.keymap.set("n", "<leader>vT", function()
      local tint = require("tint")
      if tint.is_enabled() then
        tint.disable()
        vim.notify("Tint disabled", vim.log.levels.INFO)
      else
        tint.enable()
        vim.notify("Tint enabled", vim.log.levels.INFO)
      end
    end, {
      desc = "👁️ ウィンドウ暗色化手動切替",
      silent = true
    })
  end,
}
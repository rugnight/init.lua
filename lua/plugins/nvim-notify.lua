----------------------------------------------------------------------------------------------------
--- 通知表示を美しく（noice.nvim統合対応）
----------------------------------------------------------------------------------------------------
return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	config = function()
		require("notify").setup({
			-- noice.nvim統合に最適化された設定
			background_colour = "#000000",
			fps = 30,
			icons = {
				DEBUG = "",
				ERROR = "",
				INFO = "",
				TRACE = "✎",
				WARN = ""
			},
			level = 2,
			minimum_width = 50,
			render = "compact", -- noice統合に適したレンダラー
			stages = "fade_in_slide_out",
			timeout = 3000,
			top_down = true,
			-- noice.nvimとの統合のため、LSPハンドラーは設定しない
			on_open = function(win)
				local config = vim.api.nvim_win_get_config(win)
				config.focusable = false
				vim.api.nvim_win_set_config(win, config)
			end,
		})

		-- デフォルトのnotify関数をnvim-notifyに設定
		vim.notify = require("notify")
	end,
	keys = {
		{ "<leader>vn", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "🔔 通知を閉じる" },
	},
}

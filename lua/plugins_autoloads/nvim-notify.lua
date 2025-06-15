----------------------------------------------------------------------------------------------------
--- 通知表示を美しく（自動消去でEnter不要）
----------------------------------------------------------------------------------------------------
return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	config = function()
		require("notify").setup({
			-- 通知の自動消去時間（ミリ秒）
			timeout = 3000,
			-- 表示位置
			top_down = true,
			-- アニメーション
			stages = "fade_in_slide_out",
			-- LSPメッセージを短縮表示
			on_open = function(win)
				local config = vim.api.nvim_win_get_config(win)
				config.focusable = false
				vim.api.nvim_win_set_config(win, config)
			end,
		})
		
		-- LSPの情報メッセージのみを抑制（シンプル版）
		local original_handler = vim.lsp.handlers["window/logMessage"]
		vim.lsp.handlers["window/logMessage"] = function(err, result, ctx)
			-- csharp_lsの情報メッセージは無視
			if result and result.message and string.find(result.message, "csharp%-ls:") then
				return  -- 無視
			end
			-- その他のメッセージは通常通り処理
			if original_handler then
				original_handler(err, result, ctx)
			end
		end
	end,
	keys = {
		{ "<leader>tn", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "通知を閉じる" },
	},
}
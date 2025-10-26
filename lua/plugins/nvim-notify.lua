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
		
		-- LSPの情報メッセージを完全に抑制
		vim.lsp.handlers["window/logMessage"] = function(err, result, ctx)
			-- すべてのLSP logMessageを無視
			return
		end
		
		-- LSPの表示メッセージも抑制
		vim.lsp.handlers["window/showMessage"] = function(err, result, ctx)
			-- ERRORレベルのみ表示
			if result and result.type == vim.lsp.protocol.MessageType.Error then
				vim.notify(result.message, vim.log.levels.ERROR, { title = "LSP Error" })
			end
		end
	end,
	keys = {
		{ "<leader>vn", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "通知を閉じる" },
	},
}

return {
	"hedyhli/outline.nvim",
	lazy = true,
	cmd = { "Outline", "OutlineOpen" },
	keys = { -- Example mapping to toggle outline
		keys = {
		{ "<leader>lO", "<cmd>Outline<CR>", desc = "🎯 アウトライン表示" },
	},
		{ "<leader>o", function()
			-- 通常のファイル（特殊バッファ以外）でのみアウトラインを開く
			local buftype = vim.bo.buftype
			local filetype = vim.bo.filetype
			
			-- 特殊バッファ（Otree、QuickFix、Help等）以外で開く
			if buftype == "" and filetype ~= "Otree" and filetype ~= "qf" and filetype ~= "help" then
				vim.cmd("Outline")
			else
				vim.notify("アウトラインは通常のファイルでのみ使用できます", vim.log.levels.WARN)
			end
		end, desc = "👁️ アウトライン表示" },
	},
	opts = {
		outline_window = {
			position = 'right',
			width = 25,
			relative_width = true,
			auto_close = false,
			auto_jump = false,
			jump_highlight_duration = 300,
			center_on_jump = true,
			show_numbers = false,
			show_relative_numbers = false,
			wrap = false,
			focus_on_open = true,
			winhl = '',
		},
		outline_items = {
			show_symbol_details = true,
			show_symbol_lineno = false,
			highlight_hovered_item = true,
			auto_set_cursor = true,
			auto_update_events = {
				follow = { 'CursorMoved' },
				items = { 'InsertLeave', 'WinEnter', 'BufEnter', 'BufWinEnter', 'TabEnter', 'BufWritePost' },
			},
		},
		-- アウトラインウィンドウの優先度を設定
		guides = {
			enabled = true,
			markers = {
				bottom = '└',
				middle = '├',
				vertical = '│',
			},
		},
		symbol_folding = {
			autofold_depth = 1,
			auto_unfold_hover = true,
			auto_unfold = {
				only = true,
				hovered = true,
			},
		},
		preview_window = {
			auto_preview = false,
			open_hover_on_preview = false,
			width = 50,
			min_width = 50,
			relative_width = true,
			border = 'single',
			winhl = 'NormalFloat:',
			live = false,
		},
	},
}

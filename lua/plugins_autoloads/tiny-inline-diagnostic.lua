----------------------------------------------------------------------------------------------------
--- インライン診断表示の改善
----------------------------------------------------------------------------------------------------
return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require('tiny-inline-diagnostic').setup({
			signs = {
				left = "",
				right = "",
				diag = "●",
				arrow = "    ",
				up_arrow = "    ",
				vertical = " │",
				vertical_end = " └"
			},
			hi = {
				error = "DiagnosticError",
				warn = "DiagnosticWarn",
				info = "DiagnosticInfo",
				hint = "DiagnosticHint",
				arrow = "NonText",
				background = "CursorLine", -- バックグラウンドカラー
			},
			blend = {
				factor = 0.27,
			},
			options = {
				show_source = false,
				throttle = 20,
				softwrap = 15,
				multiple_diag_under_cursor = false,
				multilines = false,
				show_all_diags_on_cursorline = false,
			}
		})
	end,
	keys = {
		{ "<leader>vd", function() require("tiny-inline-diagnostic").toggle() end, desc = "インライン診断切替" },
	},
}
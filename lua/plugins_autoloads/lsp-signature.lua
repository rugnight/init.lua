----------------------------------------------------------------------------------------------------
--- 関数シグネチャとパラメータ情報の常時表示
----------------------------------------------------------------------------------------------------
return {
	{
		"ray-x/lsp_signature.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require('lsp_signature').setup({
				bind = true,
				doc_lines = 10,
				max_height = 12,
				max_width = 80,
				noice = false,
				wrap = true,
				floating_window = true,
				floating_window_above_cur_line = true,
				floating_window_off_x = 1,
				floating_window_off_y = 0,
				close_timeout = 4000,
				fix_pos = false,
				hint_enable = true,
				hint_prefix = "🐙 ",
				hint_scheme = "String",
				hi_parameter = "LspSignatureActiveParameter",
				handler_opts = {
					border = "rounded"
				},
				always_trigger = false,
				auto_close_after = nil,
				extra_trigger_chars = {},
				zindex = 200,
				padding = '',
				transparency = nil,
				shadow_blend = 36,
				shadow_guibg = 'Black',
				timer_interval = 200,
				toggle_key = nil,
				select_signature_key = nil,
				move_cursor_key = nil,
			})
		end,
		keys = {
			{ "<leader>ls", function() require('lsp_signature').toggle_float_win() end, desc = "シグネチャ表示切替" },
		},
	},
	{
		-- 型情報とドキュメントのホバー表示
		"lewis6991/hover.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hover").setup {
				init = function()
					-- Require providers
					require("hover.providers.lsp")
					require('hover.providers.gh')
					require('hover.providers.gh_user')
					require('hover.providers.jira')
					require('hover.providers.dap')
					require('hover.providers.fold_preview')
					require('hover.providers.diagnostic')
					require('hover.providers.man')
					require('hover.providers.dictionary')
				end,
				preview_opts = {
					border = 'single'
				},
				-- Whether the contents of a currently open hover window should be moved
				-- to a :h preview-window when pressing the hover keymap.
				preview_window = false,
				title = true,
				mouse_providers = {
					'LSP'
				},
				mouse_delay = 1000
			}
		end,
		keys = {
			{ "K", function() require("hover").hover() end, desc = "ホバー情報" },
			{ "gK", function() require("hover").hover_select() end, desc = "ホバー選択" },
			{ "<C-p>", function() require("hover").hover() end, mode = "n", desc = "ホバー情報" },
		},
	}
}
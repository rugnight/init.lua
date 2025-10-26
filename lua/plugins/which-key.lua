-------------------------------------------------- 
--- キーバインドの候補をヘルプ表示してくれる
--------------------------------------------------
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		
		-- 明示的な設定でコンパクトな縦リスト表示
		wk.setup({
			preset = "helix", -- helix presetで縦リスト表示を試す
			delay = 200,
			expand = 0,
			notify = false,
			triggers = {
				{ "<auto>", mode = "nixsotc" },
				{ "m", mode = { "n" } },
			},
			win = {
				border = "single",
				padding = { 1, 1 },
				wo = {
					winblend = 0,
				},
			},
			layout = {
				width = { min = 20, max = 30 }, -- さらに幅を狭くして全て1列表示を強制
				height = { min = 4, max = 25 },
				spacing = 10,
				align = "left",
			},
			-- 1列表示を強制
			disable = {
				buftypes = {},
				filetypes = {},
			},
			-- 追加の1列表示設定
			replace = {
				["<space>"] = "SPC",
				["<cr>"] = "RET",
				["<tab>"] = "TAB",
			},
			show_help = false,
			show_keys = true,
			icons = {
				breadcrumb = "»",
				separator = "→",
				group = "+",
			},
			sort = { "local", "order", "group", "alphanum", "mod" },
		})
		
		-- グループ名を定義
		wk.add({
			{ "<leader>f", group = "📁 ファイル検索" },
			{ "<leader>l", group = "🔍 LSP操作" },
			{ "<leader>g", group = "🔀 Git操作" },
			{ "<leader>m", group = "📝 メモ/ノート" },
			{ "<leader>x", group = "🚨 診断/トラブル" },
			{ "<leader>i", group = "⚙️ 設定" },
			{ "<leader>t", group = "🖥️ ターミナル" },
			{ "<leader>b", group = "📋 バッファ" },
			{ "<leader>v", group = "👁️ 表示/UI" },
			{ "<leader>c", group = "✏️ コード操作" },
			{ "<leader>a", group = "🤖 AI操作" },
			{ "<leader>k", group = "📑 ブックマーク" },
			{ "<leader>q", group = "📋 QuickFix操作" },
		})
		
		-- which-key表示時にsymbol-usageのVirtualTextを一時非表示（安全なガード付き）
		local symbol_usage_enabled = true
		
		local augroup = vim.api.nvim_create_augroup("WhichKeySymbolUsage", { clear = true })
		
		vim.api.nvim_create_autocmd("User", {
			group = augroup,
			pattern = "WhichKeyShow",
			callback = function()
				if vim.fn.exists(":SymbolUsageToggle") == 2 then
					local ok, symbol_usage = pcall(require, "symbol-usage")
					if ok and symbol_usage_enabled and symbol_usage.toggle then
						pcall(symbol_usage.toggle)
						symbol_usage_enabled = false
					end
				end
			end,
		})
		
		vim.api.nvim_create_autocmd("User", {
			group = augroup,
			pattern = "WhichKeyHide",
			callback = function()
				if vim.fn.exists(":SymbolUsageToggle") == 2 then
					local ok, symbol_usage = pcall(require, "symbol-usage")
					if ok and not symbol_usage_enabled and symbol_usage.toggle then
						pcall(symbol_usage.toggle)
						symbol_usage_enabled = true
					end
				end
			end,
		})
	end,
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "⚙️ ローカルキーマップ",
		},
	},
}

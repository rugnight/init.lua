-------------------------------------------------- 
--- キーバインドの候補をヘルプ表示してくれる
--------------------------------------------------
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		triggers = {
			{ "<auto>", mode = "nixsotc" },
			{ "m", mode = { "n" } },
		}
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "⚙️ ローカルキーマップ",
		},
	},
	config = function()
		local wk = require("which-key")
		wk.setup()
		
		-- グループ名を定義
		wk.add({
			{ "<leader>f", group = "📁 ファイル検索" },
			{ "<leader>l", group = "🔍 LSP操作" },
			{ "<leader>g", group = "🔀 Git操作" },
			{ "<leader>m", group = "📝 メモ/ノート" },
			{ "<leader>x", group = "🚨 診断/トラブル" },
			{ "<leader>i", group = "⚙️ 設定" },
			{ "<leader>t", group = "🔄 トグル" },
			{ "<leader>b", group = "📋 バッファ" },
			{ "<leader>v", group = "👁️ 表示/UI" },
			{ "<leader>c", group = "✏️ コード操作" },
			{ "<leader>a", group = "🤖 AI操作" },
			{ "<leader>k", group = "📑 ブックマーク" },
			{ "<leader>q", group = "📋 QuickFix操作" },
		})
	end,
}

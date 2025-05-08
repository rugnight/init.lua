-------------------------------------------------- 
--- キーバインドの候補をヘルプ表示してくれる
--------------------------------------------------
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		triggers = {
			{ "m", mode = { "n" } },
		}
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "ローカルキーマップ",
		},
	},
}

return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets", -- 大量の既製スニペット
	},
	keys = {
		{ "<C-l>", function()
			local ls = require("luasnip")
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, silent = true, mode = {"i", "s"} },
		-- スニペット検索・編集（scissorsのTelescope機能を使用）
		{ "<Leader>fs", function()
			if _G.safe_scissors_edit then
				_G.safe_scissors_edit()
			else
				require("scissors").editSnippet()
			end
		end, desc = "📁 スニペット検索・編集" },
	},
	config = function()
		local ls = require("luasnip")
		
		ls.setup({
			-- 履歴保存
			history = true,
			-- 更新時の事象処理
			update_events = "TextChanged,TextChangedI",
			-- 削除時の自動クリーンアップ
			delete_check_events = "TextChanged",
			-- 自動スニペット有効化
			enable_autosnippets = true,
		})
		
		-- friendly-snippetsを読み込み
		require("luasnip.loaders.from_vscode").lazy_load()
		-- カスタムスニペットを読み込み
		require("luasnip.loaders.from_lua").load()

	end,
}

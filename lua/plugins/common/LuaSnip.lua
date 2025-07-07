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
		-- デバッグ: スニペット情報表示
		{ "<Leader>fd", function()
			local ls = require("luasnip")
			local snippets = ls.get_snippets()
			print("Available snippets:")
			for ft, snips in pairs(snippets) do
				print(string.format("  %s: %d snippets", ft, #snips))
				for _, snip in ipairs(snips) do
					print(string.format("    - %s", snip.trigger))
				end
			end
		end, desc = "📁 スニペット情報表示" },
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
			-- 選択モードでのスニペット展開を有効化
			store_selection_keys = "<Tab>",
		})
		
		-- friendly-snippetsを読み込み
		require("luasnip.loaders.from_vscode").lazy_load()
		-- カスタムスニペットを読み込み（パス指定）
		require("luasnip.loaders.from_lua").load({
			paths = { vim.fn.stdpath("config") .. "/luasnippets/" }
		})
		
		-- スニペット再読み込みコマンド
		vim.api.nvim_create_user_command("LuaSnipReload", function()
			require("luasnip.loaders.from_lua").load({
				paths = { vim.fn.stdpath("config") .. "/luasnippets/" }
			})
			print("LuaSnip snippets reloaded!")
		end, { desc = "Reload LuaSnip snippets" })

	end,
}

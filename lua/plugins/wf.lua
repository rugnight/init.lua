--------------------------------------------------
--- キーバインドの候補をヘルプ表示（wf.nvim）
--- Helix風の右下一行表示、ファジー検索対応
--------------------------------------------------
return {
	"Cassin01/wf.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		local wf = require("wf")

		-- wf.nvimのセットアップ
		wf.setup({
			theme = "default", -- テーマ: default, space, chad
		})

		-- which_keyビルトイン機能を使用して複数のプレフィックスキーにマッピング
		local which_key = require("wf.builtin.which_key")

		-- メインのリーダーキーマッピング（動的リーダーキー取得）
		vim.keymap.set("n", "<leader>",
			which_key({
				text_insert_in_advance = vim.g.mapleader
			}),
			{
				noremap = true,
				silent = true,
				desc = "[wf.nvim] which-key /"
			}
		)

		-- gプレフィックス（goto系キーマップ）
		vim.keymap.set("n", "g",
			which_key({
				text_insert_in_advance = "g"
			}),
			{
				noremap = true,
				silent = true,
				desc = "[wf.nvim] g prefix"
			}
		)

		-- zプレフィックス（fold系キーマップ）
		vim.keymap.set("n", "z",
			which_key({
				text_insert_in_advance = "z"
			}),
			{
				noremap = true,
				silent = true,
				desc = "[wf.nvim] z prefix"
			}
		)

		-- [プレフィックス（前へ移動系）
		vim.keymap.set("n", "[",
			which_key({
				text_insert_in_advance = "["
			}),
			{
				noremap = true,
				silent = true,
				desc = "[wf.nvim] [ prefix"
			}
		)

		-- ]プレフィックス（次へ移動系）
		vim.keymap.set("n", "]",
			which_key({
				text_insert_in_advance = "]"
			}),
			{
				noremap = true,
				silent = true,
				desc = "[wf.nvim] ] prefix"
			}
		)

		-- "プレフィックス（レジスタ）
		vim.keymap.set("n", '"',
			which_key({
				text_insert_in_advance = '"'
			}),
			{
				noremap = true,
				silent = true,
				desc = "[wf.nvim] register"
			}
		)

		-- 'プレフィックス（マーク）
		vim.keymap.set("n", "'",
			which_key({
				text_insert_in_advance = "'"
			}),
			{
				noremap = true,
				silent = true,
				desc = "[wf.nvim] mark"
			}
		)

		-- ローカルキーマップ表示（<leader>?）
		vim.keymap.set("n", "<leader>?", function()
			-- wf.nvimでローカルキーマップを表示
			which_key()()
		end, {
			noremap = true,
			silent = true,
			desc = "⚙️ ローカルキーマップ",
		})

		-- symbol-usage.nvimとの連携は、wf.nvimのイベントフックがあれば実装可能
		-- 現時点では標準機能として提供されていないため、必要に応じて追加実装
	end,
}
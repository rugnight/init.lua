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
			-- 表示設定の最適化（候補が多い場合）
			-- n_columns = 3, -- 列数を増やす（デフォルト: 1）
			-- max_height = 0.8, -- ウィンドウの最大高さ（画面の80%）
		})

		-- which_keyビルトイン機能を使用して複数のプレフィックスキーにマッピング
		local which_key = require("wf.builtin.which_key")

		-- カテゴリグループ定義（wf.nvim用）
		-- 辞書形式でプレフィックスとグループ名を対応付け
		local leader_key_group_dict = {
			[vim.g.mapleader .. "f"] = "[📁 ファイル検索]",
			[vim.g.mapleader .. "l"] = "[🎯 LSP操作]",
			[vim.g.mapleader .. "q"] = "[📋 QuickFix]",
			[vim.g.mapleader .. "g"] = "[🔀 Git]",
			[vim.g.mapleader .. "a"] = "[🤖 AI]",
			[vim.g.mapleader .. "k"] = "[📑 ブックマーク]",
			[vim.g.mapleader .. "v"] = "[👁️ 表示/UI]",
			[vim.g.mapleader .. "c"] = "[✏️ コード]",
			[vim.g.mapleader .. "m"] = "[📝 メモ]",
			[vim.g.mapleader .. "n"] = "[🔔 通知/ログ]",
			[vim.g.mapleader .. "u"] = "[🎮 UnrealEngine]",
			[vim.g.mapleader .. "x"] = "[🚨 診断]",
			[vim.g.mapleader .. "i"] = "[⚙️ 設定]",
			[vim.g.mapleader .. "t"] = "[🔄 トグル]",
			[vim.g.mapleader .. "b"] = "[📋 バッファ]",
		}

		-- 標準キーのグループ定義
		local standard_key_group_dict = {
			["g"] = "[移動・編集]",
			["gr"] = "[LSP操作]",
			["z"] = "[折りたたみ・画面位置]",
			["["] = "[前へ移動]",
			["]"] = "[次へ移動]",
			['"'] = "[レジスタ]",
			["'"] = "[マーク]",
		}

		-- メインのリーダーキーマッピング（グループ化対応）
		vim.keymap.set("n", "<leader>",
			which_key({
				text_insert_in_advance = vim.g.mapleader,
				key_group_dict = leader_key_group_dict
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
				text_insert_in_advance = "g",
				key_group_dict = standard_key_group_dict
			}),
			{
				noremap = true,
				silent = true,
				desc = "[wf.nvim] g prefix"
			}
		)

		-- grプレフィックス（LSP系キーマップ: Neovim 0.11デフォルト）
		vim.keymap.set("n", "gr",
			which_key({
				text_insert_in_advance = "gr",
				key_group_dict = standard_key_group_dict
			}),
			{
				noremap = false,
				silent = true,
				desc = "[wf.nvim] gr prefix (LSP)"
			}
		)

		-- zプレフィックス（fold系キーマップ）
		vim.keymap.set("n", "z",
			which_key({
				text_insert_in_advance = "z",
				key_group_dict = standard_key_group_dict
			}),
			{
				noremap = false,
				silent = true,
				desc = "[wf.nvim] z prefix"
			}
		)

		-- [プレフィックス（前へ移動系）
		vim.keymap.set("n", "[",
			which_key({
				text_insert_in_advance = "[",
				key_group_dict = standard_key_group_dict
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
				text_insert_in_advance = "]",
				key_group_dict = standard_key_group_dict
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
				text_insert_in_advance = '"',
				key_group_dict = standard_key_group_dict
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
				text_insert_in_advance = "'",
				key_group_dict = standard_key_group_dict
			}),
			{
				noremap = true,
				silent = true,
				desc = "[wf.nvim] mark"
			}
		)

		-- カテゴリキーのマッピング削除（重複表示回避のため）
		-- 注意: カテゴリキーを明示的にマッピングすると重複表示になるため、
		-- <Leader>のマッピングのみで対応。素早く入力すればwf.nvim起動前にコマンド実行可能。

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
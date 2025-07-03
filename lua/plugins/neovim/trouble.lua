return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- キーマッピングをkeys配列で定義（lazy.nvimの推奨方法）
	keys = {
		{ "<leader>xd", "<cmd>Trouble document_diagnostics toggle<cr>", desc = "現在のファイルの診断" },
		--{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "ロケーションリスト" },
		{ "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "クイックフィックスリスト" },
		{ "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>", desc = "参照一覧" },
		--{ "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "シンボル一覧" },
		{ "<leader>xw", "<cmd>Trouble workspace_diagnostics toggle<cr>", desc = "ワークスペース全体の診断" },
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "診断一覧の表示/非表示" },
	},
	opts = {
		auto_preview = true, -- 自動プレビューを有効化
		modes = {
			symbols = {
				desc = "シンボル一覧",
				focus = true,
				--win = { position = "left" },
				win = { type = "float", position='right'}
			},
		},
	},
	-- configブロックは削除し、optsとkeysに移行
}

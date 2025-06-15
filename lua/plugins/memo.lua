return {
	'utouto97/memo.nvim',
	requires = {
		'nvim-telescope/telescope.nvim',
		'nvim-lua/plenary.nvim'
	},
	opts = {
		memo_dir = '~/.memo'
	},
	keys = {
		{ "<Leader>mm", mode = { "n" }, "<cmd>Memo<cr>", desc = "メモを作成" },
		{ "<Leader>ml", mode = { "n" }, "<cmd>Telescope memo<cr>", desc = "メモを検索" },
	},
	config = function()
		require('memo').setup(opts)
	end,
}

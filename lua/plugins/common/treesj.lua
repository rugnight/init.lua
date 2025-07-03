----------------------------------------------------------------------------------------------------
--- 単一行、複数行のコードを相互変換する
----------------------------------------------------------------------------------------------------
return {
	'Wansmer/treesj',
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
	config = function()
		require('treesj').setup({})
	end,
	keys = {
		{ "<Leader>cj", function() require('treesj').join() end, desc = "✏️ 行結合" },
		{ "<Leader>cs", function() require('treesj').split() end, desc = "✏️ 行分割" },
	},
}

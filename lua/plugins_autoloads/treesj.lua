----------------------------------------------------------------------------------------------------
--- 単一行、複数行のコードを相互変換する
----------------------------------------------------------------------------------------------------
return {
	'Wansmer/treesj',
	keys = { '<space>m', '<space>j', '<space>s' },
	dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
	config = function()
		require('treesj').setup({--[[ your config ]]})
		vim.keymap.set("nv", "<Leader>cj", require('treesj').join(), { desc = "行結合" })
		vim.keymap.set("nv", "<Leader>cs", require('treesj').split(), { desc = "行分割" })
	end
}

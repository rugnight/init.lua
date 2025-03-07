----------------------------------------------------------------------------------------------------
--- 単一行、複数行のコードを相互変換する
----------------------------------------------------------------------------------------------------
return {
	'Wansmer/treesj',
	keys = { '<space>m', '<space>j', '<space>s' },
	dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
	config = function()
		require('treesj').setup({--[[ your config ]]})
		vim.keymap.set("nv", "<Leader>j", require('treesj').join())
		vim.keymap.set("nv", "<Leader>s", require('treesj').split())
	end
}

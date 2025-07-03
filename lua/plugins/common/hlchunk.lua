----------------------------------------------------------------------------------------------------
--- カッコ、タブレベルの強調表示
----------------------------------------------------------------------------------------------------
return {
	'shellRaining/hlchunk.nvim',
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require('hlchunk').setup({})
		require('hlchunk').setup({
			chunk = {
				enable = true
			},
			indent = {
				enable = true
			}
		})
	end
}

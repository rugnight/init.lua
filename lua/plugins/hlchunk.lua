----------------------------------------------------------------------------------------------------
--- カッコ、タブレベルの強調表示
----------------------------------------------------------------------------------------------------
return {
	'shellRaining/hlchunk.nvim',
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require('hlchunk').setup({
			chunk = {
				enable = true
			},
			indent = {
				enable = false  -- インデントガイド（罫線）を無効化
			}
		})
	end
}

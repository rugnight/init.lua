----------------------------------------------------------------------------------------------------
--- インライン診断表示
----------------------------------------------------------------------------------------------------
return {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("lsp_lines").setup()
		-- デフォルトの仮想テキスト診断を無効化してlsp_linesを使用
		vim.diagnostic.config({
			virtual_text = false,
		})
	end,
	keys = {
		{ "<leader>ll", function() require("lsp_lines").toggle() end, desc = "🎯 インライン診断切替" },
	},
}
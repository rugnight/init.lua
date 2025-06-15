return {
	----------------------------------------------------------------------------------------------------
	--- Markdown入力補助
	----------------------------------------------------------------------------------------------------
	{
		'ixru/nvim-markdown'
	},
	----------------------------------------------------------------------------------------------------
	--- Markdownプレビュー
	----------------------------------------------------------------------------------------------------
	--{
	--	"OXY2DEV/markview.nvim",
	--	lazy = false,      -- Recommended
	--	-- ft = "markdown" -- If you decide to lazy-load anyway
	--	dependencies = {
	--		"nvim-treesitter/nvim-treesitter",
	--		"nvim-tree/nvim-web-devicons"
	--	},
	--	opts = {
	--		initial_state = false,
	--		--hybrid_modes = { "n" },
	--	},
	--	config = function(_, opts)
	--		require("markview").setup()
	--		-- vim.keymap.set("n", "<C-p>", ":Markview toggleAll<CR>")
	--	end
	--}
}

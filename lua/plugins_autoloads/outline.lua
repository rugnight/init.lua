return {
	"hedyhli/outline.nvim",
	lazy = true,
	cmd = { "Outline", "OutlineOpen" },
	keys = { -- Example mapping to toggle outline
		{ "<leader>vo", "<cmd>Outline<CR>", desc = "アウトライン表示" },
	},
	opts = {
		-- Your setup opts here
	},
}

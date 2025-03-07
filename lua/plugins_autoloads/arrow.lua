-------------------------------------------------- 
--- ブックマーク
--------------------------------------------------
return {
	"otavioschwanck/arrow.nvim",
	opts = {
		show_icons = true,
		leader_key = ',', -- Recommended to be a single key
		buffer_leader_key = ',,', -- Per Buffer Mappings
		-- separate_by_branch = false,
	},
	config = function(_, opts)
		require("arrow").setup(opts)
		--vim.keymap.set("n", "<Leader>h", require("arrow.persist").previous, { desc = "Arrow 前へ" })
		--vim.keymap.set("n", "<Leader>l", require("arrow.persist").next, { desc = "Arrow 次へ" })
		-- vim.keymap.set("n", "<Leader>t", require("arrow.persist").toggle, { desc = "Arrow トグル" })
	end,
}

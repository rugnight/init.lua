return {
	'tomasky/bookmarks.nvim',
	-- after = "telescope.nvim",
	keys = {
		{ "<leader>km", desc = "📑 マークをトグル" },
		{ "<leader>ki", desc = "📑 マーク(コメント付き)" },
		{ "<leader>kc", desc = "📑 マークを削除" },
		{ "<leader>kn", desc = "📑 次のマーク" },
		{ "<leader>kp", desc = "📑 前のマーク" },
		{ "<leader>kl", desc = "📑 マーク一覧" },
		{ "<leader>kx", desc = "📑 すべてのマークを削除" },
	},
	config = function()
		require('bookmarks').setup {
			-- sign_priority = 8,  --set bookmark sign priority to cover other sign
			save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
			keywords =  {
				["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
				["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
				["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
				["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
			},
			on_attach = function(bufnr)
				local bm = require "bookmarks"
				local map = vim.keymap.set
				map("n","<leader>km",bm.bookmark_toggle, { desc = "📑 マークをトグル" }) -- add or remove bookmark at current line
				map("n","<leader>ki",bm.bookmark_ann, { desc = "📑 マーク(コメント付き)" }) -- add or edit mark annotation at current line
				map("n","<leader>kc",bm.bookmark_clean, { desc = "📑 マークを削除" }) -- clean all marks in local buffer
				map("n","<leader>kn",bm.bookmark_next, { desc = "📑 次のマーク" }) -- jump to next mark in local buffer
				map("n","<leader>kp",bm.bookmark_prev, { desc = "📑 前のマーク" }) -- jump to previous mark in local buffer
				map("n","<leader>kl",":Telescope bookmarks list<CR>", { desc = "📑 マーク一覧" }) -- show marked file list in quickfix window
				map("n","<leader>kx",bm.bookmark_clear_all, { desc = "📑 すべてのマークを削除" }) -- removes all bookmarks
			end
		}
		require('telescope').load_extension('bookmarks')
	end,
}

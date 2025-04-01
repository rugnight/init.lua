return {
	{
		"lewis6991/gitsigns.nvim", -- Gitの変更を視覚化
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				-- キーマッピング
				vim.keymap.set("n", "]c", function()
					if vim.wo.diff then return "]c" end
					vim.schedule(function() gs.next_hunk() end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "次の変更へ" })

				vim.keymap.set("n", "[c", function()
					if vim.wo.diff then return "[c" end
					vim.schedule(function() gs.prev_hunk() end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "前の変更へ" })

				vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = bufnr, desc = "変更のプレビュー" })
				vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { buffer = bufnr, desc = "変更を元に戻す" })
				vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { buffer = bufnr, desc = "変更をステージ" })
			end,
		}
	}
}

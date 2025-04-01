-- --------------------------------------------------
-- コンテンツを中央に寄せる
-- --------------------------------------------------
return {
	"shortcuts/no-neck-pain.nvim",
	version = "*",
	config = function()
		opts = {
			width = 120,
			minSideBufferWidth = 5,
			autocmds = {
				enableOnVimEnter = false,
				enableOnTabEnter = false,
				reloadOnColorSchemeChange = false,
				skipEnteringNoNeckPainBuffer = false,
			},
			colors = {
				blend = -0.1,
			},
			buffers = {
				scratchPad = {
					enabled = true,
					fileName = "notes",
					location = "~/",
				},
				bo = {
					filetype = "md",
				},
				-- right = {
					-- 	enabled = false,
					-- },
					-- left = {
						-- 	enabled = false,
						-- },
					},

				}

				require("no-neck-pain").setup(opts)
				vim.keymap.set("n", "<Leader>Z", "<cmd>NoNeckPain<CR>",       { desc = "no-neck-pain" } )
				--vim.keymap.set("n", "<Leader>s", ":NoNeckPainScratchPad<CR>", { desc = "スクラッチパッド" })
			end,
		}

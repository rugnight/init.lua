-- --------------------------------------------------
-- コンテンツを中央に寄せる
-- --------------------------------------------------
return {
	"shortcuts/no-neck-pain.nvim",
	version = "*",
	keys = {
		{ "<leader>wz", function() require("no-neck-pain").toggle() end, desc = "🪟 ゼンモード" },
	},
	config = function()
		local opts = {
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
			},
		}

		require("no-neck-pain").setup(opts)
	end,
}

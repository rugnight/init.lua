return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	main = 'nvim-treesitter.configs', 
	config = function () 
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = { "c_sharp" },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },  
		})

	end
}

return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	main = 'nvim-treesitter.configs', 
	config = function () 
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = { "c_sharp", "lua", "vim", "vimdoc", "markdown" },
			sync_install = false,
			auto_install = true,
			highlight = { 
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },  
		})

	end
}

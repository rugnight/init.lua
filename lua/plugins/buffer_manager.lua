--------------------------------------------------
--- シンプルなバッファリスト
--------------------------------------------------
return {
	"j-morano/buffer_manager.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	config = function() 
		require("lua.plugins.buffer_manager").setup()
		vim.keymap.set("n", "<Leader>bm", function() require("buffer_manager.ui").toggle_quick_menu() end, { desc = "バッファマネージャー" })
	end,
}

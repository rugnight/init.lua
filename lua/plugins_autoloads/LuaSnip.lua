return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	-- build = "make install_jsregexp",
	config = function()
		local ls = require("luasnip")
		ls.setup()
		require("luasnip.loaders.from_lua").load()

		-- スニペット楽々編集メニュー
		vim.keymap.set('n', '<C-,><C-,><C-,>', require("luasnip.loaders").edit_snippet_files, { desc = "Edit snippets" })
	end,
}

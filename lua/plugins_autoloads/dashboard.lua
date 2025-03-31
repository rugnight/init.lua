----------------------------------------------------------------------------------------------------
--- 起動画面
----------------------------------------------------------------------------------------------------
return {
	'nvimdev/dashboard-nvim',
	event = 'VimEnter',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local db = require('dashboard')

		db.setup({
			theme = 'hyper',  -- 'hyper'または'doom'など
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
					{ desc = '󰊳 更新', group = '@property', action = 'Lazy update', key = 'u' },
					{ desc = '󰊳 ファイル', group = 'Label', action = 'Telescope find_files', key = 'f' },
					{ desc = '󰊳 テキスト検索', group = 'Number', action = 'Telescope live_grep', key = 'g' },
					{ desc = '󰊳 最近のファイル', group = 'String', action = 'Telescope oldfiles', key = 'r' },
					{ desc = '󰊳 設定', group = 'DiagnosticHint', action = 'edit ~/.config/nvim/init.lua', key = 'c' },
				},
				project = { enable = true, limit = 8, icon = '󰺿', label = '最近のプロジェクト:' },
				mru = { limit = 10, icon = '', label = '最近開いたファイル:' },
			},
		})
	end,
}

--return {
--	'goolord/alpha-nvim',
--	dependencies = { 'nvim-tree/nvim-web-devicons' },
--	config = function()
--		local startify = require("alpha.themes.startify")
--		-- available: devicons, mini, default is mini
--		-- if provider not loaded and enablrkview splitToggleed is true, it will try to use another provider
--		startify.file_icons.provider = "devicons"
--		require("alpha").setup(
--		startify.config
--		)
--	end,
--}

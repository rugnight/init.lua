return {
	{
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.8',
		config = function() 
			require("telescope").load_extension "file_browser"
			require'telescope'.load_extension('project')

			local builtin = require('telescope.builtin')
			local actions = require('telescope.actions')
			vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'ファイル検索' })
			vim.keymap.set('n', '<leader>g', builtin.live_grep,  { desc = 'ファイルをGrep' })
			vim.keymap.set('n', '<leader>b', builtin.buffers,    { desc = 'バッファ一覧' })
			vim.keymap.set("n", "<C-S-P>",    builtin.commands,   { desc = 'コマンド一覧' })
			vim.keymap.set("n", "<leader>c",    builtin.commands,   { desc = 'コマンド一覧' })

			--vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
			-- vim.keymap.set('n', '<leader>fh', actions.history.get_simple_history(), { desc = 'Telescope help tags' })

			-- local opts = {...} -- picker options
			-- local builtin = require('telescope.builtin')
			-- local themes = require('telescope.themes')
			-- builtin.find_files(themes.get_dropdown(opts))
			--
			-- local opts = {...} -- picker options
			-- local builtin = require('telescope.builtin')
			-- local themes = require('telescope.themes')
			-- builtin.find_files(themes.get_cursor(opts))

			-- local opts = {...} -- picker options
			-- local builtin = require('telescope.builtin')
			-- local themes = require('telescope.themes')
			-- builtin.find_files(themes.get_ivy(opts))
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	},
	{
		"nvim-telescope/telescope-project.nvim",
	},
	-- 最近開いたファイル
	-- {
	-- 	"nvim-telescope/telescope-frecency.nvim",
	-- 	config = function()
	-- 		require("telescope").load_extension("frecency")
	-- 	end,
	-- },
	{
		"nvim-telescope/telescope-frecency.nvim",
		-- install the latest stable version
		version = "*",
		config = function()
			require("telescope").load_extension "frecency"
			vim.keymap.set('n', '<Leader>h', ':Telescope frecency path_display={"shorten"} theme=ivy<CR>',               { desc = '最近開いたファイル' })
			vim.keymap.set('n', '<leader>r', ':Telescope frecency workspace=CWD path_display={"shorten"} theme=ivy<CR>', { desc = 'プロジェクト内で最近開いたファイル' })
		end,
	},
}

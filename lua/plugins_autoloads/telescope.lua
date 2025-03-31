return {
	{
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.8',
		config = function() 
            local telescope = require('telescope')
            local actions = require('telescope.actions')
			require("telescope").load_extension "file_browser"
			require'telescope'.load_extension('project')

            telescope.setup({
                defaults = {
                    layout_strategy = "bottom_pane",
                    layout_config = {
                        height = 0.4,  -- 画面の40%の高さを使用
                        width = 0.9,   -- 画面の90%の幅を使用
                        prompt_position = "top", -- プロンプトを上部に配置
                    },
                    sorting_strategy = "ascending", -- 結果を上から下に表示
                    prompt_prefix = " ",
                    path_display = {"truncate"},
                },
            })

			local builtin = require('telescope.builtin')
			local actions = require('telescope.actions')
			vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'ファイル検索' })
			vim.keymap.set('n', '<leader>g', builtin.live_grep,  { desc = 'ファイルをGrep' })
			vim.keymap.set('n', '<leader>b', builtin.buffers,    { desc = 'バッファ一覧' })
			vim.keymap.set("n", "<C-S-P>",    builtin.commands,   { desc = 'コマンド一覧' })
			vim.keymap.set("n", "<leader>c",    builtin.commands,   { desc = 'コマンド一覧' })
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

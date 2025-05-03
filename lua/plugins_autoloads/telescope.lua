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
			vim.keymap.set('n', '<Leader>tf', builtin.find_files, { desc = 'ファイル検索' })
			vim.keymap.set('n', '<Leader>tg', builtin.live_grep,  { desc = 'ファイルをGrep' })
			vim.keymap.set('n', '<Leader>tb', builtin.buffers,    { desc = 'バッファ一覧' })
			vim.keymap.set("n", "<Leader>tc", builtin.commands,   { desc = 'コマンド一覧' })
            vim.keymap.set('n', '<leader>to', builtin.oldfiles, { desc = '最近開いたファイル(history)' })

			-- TreeSitter関連のTelescopeコマンド
			vim.keymap.set('n', '<leader>st', require('telescope.builtin').treesitter, { desc = 'TreeSitterシンボル一覧' })
			vim.keymap.set('n', '<leader>sf', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '現在のファイル内をあいまい検索' })
			vim.keymap.set('n', '<leader>ss', require('telescope.builtin').lsp_document_symbols, { desc = 'ドキュメントシンボル' })

            -- LSP関連のキーマッピング
            vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = 'LSPドキュメントシンボル' })
            vim.keymap.set('n', '<leader>lw', builtin.lsp_dynamic_workspace_symbols, { desc = 'LSPワークスペースシンボル' })
            vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = 'LSP参照を検索' })
            vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = 'LSP定義を検索' })
            --vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = 'LSP実装を検索' })
            vim.keymap.set('n', '<leader>lt', builtin.lsp_type_definitions, { desc = 'LSP型定義を検索' })

			-- Git系
            vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Gitコミット履歴' })
            vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Gitブランチ一覧' })
            vim.keymap.set('n', '<leader>gg', builtin.git_status, { desc = 'Git変更ファイル' })
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	},
	{
		"nvim-telescope/telescope-project.nvim",
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		-- install the latest stable version
		version = "*",
		config = function()
			require("telescope").load_extension "frecency"
			vim.keymap.set('n', '<Leader>tr', ':Telescope frecency path_display={"shorten"} theme=ivy<CR>',               { desc = '最近開いたファイル' })
			--vim.keymap.set('n', '<leader>tr', ':Telescope frecency workspace=CWD path_display={"shorten"} theme=ivy<CR>', { desc = 'プロジェクト内で最近開いたファイル' })
		end,
	},
	{
		"jmacadie/telescope-hierarchy.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
		},
		keys = {
			{ "<leader>li", "<cmd>Telescope hierarchy incoming_calls<cr>", desc = "LSP: 参照元を検索", },
			{ "<leader>lo", "<cmd>Telescope hierarchy outgoing_calls<cr>", desc = "LSP: 参照先を検索", },
		},
		opts = {
			-- don't use `defaults = { }` here, do this in the main telescope spec
			extensions = {
				hierarchy = {
					-- telescope-hierarchy.nvim config, see below
				},
				-- no other extensions here, they can have their own spec too
			},
		},
		config = function(_, opts)
			-- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
			-- configs for us. We won't use data, as everything is in it's own namespace (telescope
			-- defaults, as well as each extension).
			require("telescope").setup(opts)
			require("telescope").load_extension("hierarchy")
		end,
	}
}

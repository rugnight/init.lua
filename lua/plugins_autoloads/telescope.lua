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
	},
	{
		'renerocksai/telekasten.nvim',
		dependencies = {
			'nvim-telescope/telescope.nvim',
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-media-files.nvim'  -- 画像プレビュー用
		},
		config = function()
			local home = vim.fn.expand("~/.telekasten")

			-- 基本ディレクトリ設定
			require('telekasten').setup({
				-- 基本設定
				home = home,  -- メモのルートディレクトリ

				-- 各種ディレクトリ設定
				dailies = home .. "/daily",   -- 日記用ディレクトリ
				weeklies = home .. "/weekly", -- 週次メモ用ディレクトリ
				templates = home .. "/templates", -- テンプレートディレクトリ
				image_subdir = "media",      -- 画像保存用ディレクトリ

				-- テンプレート設定
				template_new_note = home .. "/templates/new_note.md",
				template_new_daily = home .. "/templates/daily.md",
				template_new_weekly = home .. "/templates/weekly.md",

				-- ファイル形式設定
				extension = ".md",          -- マークダウン拡張子を使用
				new_note_filename = "title", -- ノート名はタイトルベース
				filename_case = "lower",    -- ファイル名は小文字に変換

				-- 日付形式
				journal_format = "%Y-%m-%d", -- 日記のファイル名形式
				weekly_format = "%Y-W%V",    -- 週次メモのファイル名形式

				-- 表示・操作設定
				sort = "filename",           -- ファイル名でソート
				use_template_placeholders = true, -- テンプレートでプレースホルダーを使用
				close_after_yanking = false,     -- リンクコピー後もウィンドウを開いたまま
				insert_after_inserting = true,   -- リンク挿入後にインサートモードに戻る

				-- リンク設定
				link_style = "markdown",     -- Markdownスタイルのリンク
				subdirs_in_links = true,     -- リンクにサブディレクトリを含める

				-- カレンダー設定
				calendar_opts = {
					weeknm = 4,
					calendar_monday = 1,     -- 月曜始まり
					calendar_mark = "left-fit",
				},
			})

			-- キーマッピング：基本操作
			local map = vim.keymap.set

			-- メインコマンド
			map("n", "<leader>mz", "<cmd>Telekasten panel<CR>", { desc = "Telekastenパネル" })

			-- ノート操作
			map("n", "<leader>mf", "<cmd>Telekasten find_notes<CR>", { desc = "ノート検索" })
			map("n", "<leader>mg", "<cmd>Telekasten search_notes<CR>", { desc = "ノート内検索" })
			map("n", "<leader>mn", "<cmd>Telekasten new_note<CR>", { desc = "新規ノート" })
			map("n", "<leader>mt", "<cmd>Telekasten toggle_todo<CR>", { desc = "TODO切替" })

			-- 日記・週報
			map("n", "<leader>md", "<cmd>Telekasten goto_today<CR>", { desc = "今日の日記" })
			map("n", "<leader>mw", "<cmd>Telekasten goto_thisweek<CR>", { desc = "今週の週報" })

			-- ブラウジング
			map("n", "<leader>mb", "<cmd>Telekasten show_backlinks<CR>", { desc = "バックリンク" })
			map("n", "<leader>m#", "<cmd>Telekasten show_tags<CR>", { desc = "タグ一覧" })
			--map("n", "<leader>mc", "<cmd>Telekasten show_calendar<CR>", { desc = "カレンダー" })

			-- リンク操作
			map("n", "<leader>ml", "<cmd>Telekasten follow_link<CR>", { desc = "リンクをたどる" })
			map("n", "<leader>mi", "<cmd>Telekasten insert_link<CR>", { desc = "リンクを挿入" })
			map("i", "[[", "<cmd>Telekasten insert_link<CR>", { desc = "リンクを挿入" })

			-- メディア
			map("n", "<leader>mp", "<cmd>Telekasten preview_img<CR>", { desc = "画像プレビュー" })
			map("n", "<leader>mm", "<cmd>Telekasten insert_img_link<CR>", { desc = "画像リンク挿入" })
		end
	}
}

return {
	{
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.8',
		cmd = "Telescope",
		keys = {
			{ '<Leader>ff', function() require('telescope.builtin').find_files() end, desc = 'ファイル検索' },
			{ '<Leader>fg', function() require('telescope.builtin').live_grep() end, desc = '文字列検索(Grep)' },
			{ '<leader>fr', function() require('telescope.builtin').oldfiles() end, desc = '最近のファイル' },
			{ '<Leader>fb', function() require('telescope.builtin').buffers() end, desc = 'バッファ検索' },
			{ '<Leader>fc', function() require('telescope.builtin').commands() end, desc = 'コマンド検索' },
			{ '<Leader>fp', function() 
				require("telescope").load_extension("project")
				vim.cmd('Telescope project') 
			end, desc = 'プロジェクト選択' },
			{ '<leader>gc', function() require('telescope.builtin').git_commits() end, desc = 'コミット履歴' },
			{ '<leader>gb', function() require('telescope.builtin').git_branches() end, desc = 'ブランチ一覧' },
			{ '<leader>gs', function() require('telescope.builtin').git_status() end, desc = 'Git状態' },
		},
		config = function() 
            local telescope = require('telescope')
            local actions = require('telescope.actions')

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

		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		cmd = "Telescope file_browser",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").load_extension "file_browser"
		end,
	},
	{
		"nvim-telescope/telescope-project.nvim",
		cmd = "Telescope project",
		config = function()
			require'telescope'.load_extension('project')
		end,
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		version = "*",
		keys = {
			{ '<Leader>fq', function() 
				require("telescope").load_extension "frecency"
				vim.cmd('Telescope frecency path_display={"shorten"} theme=ivy')
			end, desc = '頻繁に使うファイル' },
		},
	},
	{
		"jmacadie/telescope-hierarchy.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{ "<leader>li", function()
				require("telescope").load_extension("hierarchy")
				vim.cmd("Telescope hierarchy incoming_calls")
			end, desc = "呼び出し元", },
			{ "<leader>lo", function()
				require("telescope").load_extension("hierarchy")
				vim.cmd("Telescope hierarchy outgoing_calls")
			end, desc = "呼び出し先", },
		},
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

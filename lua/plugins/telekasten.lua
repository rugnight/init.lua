return {
	"nvim-telekasten/telekasten.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telekasten/calendar-vim", -- Optional calendar integration
	},
	keys = {
		-- メモ・ノート基本操作（<Leader>m*で統一）
		{ "<Leader>mp", "<cmd>Telekasten panel<CR>", desc = "📝 パネル表示" },
		{ "<Leader>mf", "<cmd>Telekasten find_notes<CR>", desc = "📝 ノート検索" },
		{ "<Leader>mg", "<cmd>Telekasten search_notes<CR>", desc = "📝 ノート内容検索" },
		{ "<Leader>md", "<cmd>Telekasten goto_today<CR>", desc = "📝 今日のノート" },
		{ "<Leader>mz", "<cmd>Telekasten goto_thisweek<CR>", desc = "📝 今週のノート" },
		{ "<Leader>mw", "<cmd>Telekasten find_weekly_notes<CR>", desc = "📝 週次ノート検索" },
		{ "<Leader>mn", "<cmd>Telekasten new_note<CR>", desc = "📝 新規ノート" },
		{ "<Leader>mN", "<cmd>Telekasten new_templated_note<CR>", desc = "📝 テンプレートノート" },
		{ "<Leader>my", "<cmd>Telekasten yank_notelink<CR>", desc = "📝 ノートリンクヤンク" },
		{ "<Leader>mc", "<cmd>Telekasten show_calendar<CR>", desc = "📝 カレンダー表示" },

		-- リンク操作
		{ "<Leader>mi", "<cmd>Telekasten paste_img_and_link<CR>", desc = "📝 画像貼付け" },
		{ "<Leader>mt", "<cmd>Telekasten toggle_todo<CR>", desc = "📝 TODO切替" },
		{ "<Leader>mb", "<cmd>Telekasten show_backlinks<CR>", desc = "📝 バックリンク" },
		{ "<Leader>mF", "<cmd>Telekasten find_friends<CR>", desc = "📝 関連ノート" },
		{ "<Leader>mI", "<cmd>Telekasten insert_img_link<CR>", desc = "📝 画像リンク挿入" },
		{ "<Leader>mP", "<cmd>Telekasten preview_img<CR>", desc = "📝 画像プレビュー" },
		{ "<Leader>mM", "<cmd>Telekasten browse_media<CR>", desc = "📝 メディア一覧" },
		{ "<Leader>ma", "<cmd>Telekasten show_tags<CR>", desc = "📝 タグ表示" },

		-- リンク挿入（Visual mode）
		{ "<Leader>ml", "<cmd>Telekasten insert_link<CR>", desc = "📝 リンク挿入", mode = {"n", "v"} },

		-- 移動系
		{ "<Leader>mG", "<cmd>Telekasten follow_link<CR>", desc = "📝 リンクフォロー" },
		{ "<Leader>mT", "<cmd>Telekasten goto_today<CR>", desc = "📝 今日へ移動" },
		{ "<Leader>mW", "<cmd>Telekasten goto_thisweek<CR>", desc = "📝 今週へ移動" },
	},

	opts = {
		home = vim.fn.expand("~/telekasten"), -- ベースディレクトリ

		-- 日記設定
		dailies = vim.fn.expand("~/telekasten/daily"),
		weeklies = vim.fn.expand("~/telekasten/weekly"),
		templates = vim.fn.expand("~/telekasten/templates"),

		-- ファイル拡張子
		extension = ".md",

		-- 日記ファイル名フォーマット
		journal_auto_open = true,

		-- テンプレート設定
		template_new_note = vim.fn.expand("~/telekasten/templates/new_note.md"),
		template_new_daily = vim.fn.expand("~/telekasten/templates/daily.md"),
		template_new_weekly = vim.fn.expand("~/telekasten/templates/weekly.md"),

		-- リンク形式
		follow_creates_nonexisting = true,
		dailies_create_nonexisting = true,
		weeklies_create_nonexisting = true,

		-- ファイル名生成
		journal_auto_open = true,

		-- カレンダー設定
		calendar_opts = {
			-- カレンダーの表示週開始日 (1=月曜日, 0=日曜日)
			weekstart = 1,
			calendar_monday = 1,
		},

		-- メディア設定
		media_previewer = "telescope-media-files",

		-- 画像設定
		image_subdir = "img",
		image_link_style = "markdown",

		-- タグ設定
		tag_notation = "#tag",

		-- ノートID生成関数
		new_note_filename = function(title)
			local name = ""
			if title ~= nil then
				name = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-ぁ-んァ-ン一-龯]", ""):lower()
			else
				name = "note-" .. tostring(os.time())
			end
			return name
		end,

		-- UUID生成（高度なリンクIDが必要な場合）
		new_note_location = "smart",
		uuid_type = "%Y%m%d%H%M",
		uuid_sep = "-",

		-- プラグイン統合
		plug_into_calendar = true,
		calendar_opts = {
			weekstart = 1,
			calendar_monday = 1,
		},

		-- コマンド使用許可
		command_palette_theme = "dropdown",
		show_command_palette = true,

		-- ファイルブラウザ統合
		close_after_yanking = false,
		insert_after_inserting = true,

		-- Telescope設定
		find_command = "rg",
		vaults = {},

		-- 自動保存
		auto_set_filetype = true,
		auto_set_syntax = true,

		-- リンクフォーマット
		link_notation = "markdown",

		-- 高度な設定
		sort = "filename",

		-- デバッグ
		debug = false,
	},

	config = function(_, opts)
		require('telekasten').setup(opts)

		-- カスタム設定があれば追加
		-- 例：特定のファイルタイプでの自動コマンド
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				-- マークダウンファイルでの追加設定
				local buf_opts = { buffer = true, silent = true }

				-- INSERT mode でのキーマップ（オプション）
				-- vim.keymap.set("i", "[[", function()
				-- 	vim.cmd("Telekasten insert_link")
				-- end, buf_opts)
			end,
		})

		-- テレカステンディレクトリが存在しない場合は作成
		local home_dir = vim.fn.expand("~/telekasten")
		if vim.fn.isdirectory(home_dir) == 0 then
			vim.fn.mkdir(home_dir, "p")
			vim.fn.mkdir(home_dir .. "/daily", "p")
			vim.fn.mkdir(home_dir .. "/weekly", "p")
			vim.fn.mkdir(home_dir .. "/templates", "p")
			vim.fn.mkdir(home_dir .. "/img", "p")
		end
	end,
}
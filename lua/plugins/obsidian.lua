return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		-- ノート作成・管理
		{ "<Leader>mn", "<cmd>ObsidianNew<CR>", desc = "新規ノート作成" },
		{ "<Leader>mf", "<cmd>ObsidianQuickSwitch<CR>", desc = "ノート検索" },
		{ "<Leader>ms", "<cmd>ObsidianSearch<CR>", desc = "ノート内容検索" },
		{ "<Leader>mt", "<cmd>ObsidianToday<CR>", desc = "今日のノート" },
		{ "<Leader>my", "<cmd>ObsidianYesterday<CR>", desc = "昨日のノート" },
		{ "<Leader>mw", "<cmd>ObsidianWorkspace<CR>", desc = "ワークスペース切替" },
		{ "<Leader>mr", "<cmd>ObsidianRename<CR>", desc = "ノートリネーム" },
		
		-- リンク・参照
		{ "<Leader>ml", "<cmd>ObsidianLink<CR>", desc = "リンク作成", mode = {"n", "v"} },
		{ "<Leader>mL", "<cmd>ObsidianLinkNew<CR>", desc = "新規ノートリンク", mode = {"n", "v"} },
		{ "<Leader>mb", "<cmd>ObsidianBacklinks<CR>", desc = "バックリンク表示" },
		{ "<Leader>mg", "<cmd>ObsidianFollowLink<CR>", desc = "リンクを開く" },
		{ "<Leader>me", "<cmd>ObsidianExtractNote<CR>", desc = "ノート抽出", mode = "v" },
		
		-- 日記・定期ノート
		{ "<Leader>mt", "<cmd>ObsidianToday<CR>", desc = "今日のノート" },
		{ "<Leader>my", "<cmd>ObsidianYesterday<CR>", desc = "昨日のノート" },
		{ "<Leader>md", "<cmd>ObsidianDailies<CR>", desc = "日記一覧" },
		
		-- テンプレート・操作
		{ "<Leader>mT", "<cmd>ObsidianTemplate<CR>", desc = "テンプレート挿入" },
		{ "<Leader>mo", "<cmd>ObsidianOpen<CR>", desc = "Obsidianで開く" },
		{ "<Leader>mp", "<cmd>ObsidianPasteImg<CR>", desc = "画像貼付け" },
		{ "<Leader>mz", "<cmd>ObsidianTags<CR>", desc = "タグ検索" },
	},
	opts = {
		workspaces = {
			{
				name = "rugnight.net",
				path = "~/obsidian/rugnight.net",
				overrides = {
					notes_subdir = "notes",
				},
			},
		},

		-- ノート保存設定
		notes_subdir = "notes",
		log_level = vim.log.levels.INFO,

		-- 日記設定
		daily_notes = {
			folder = "journal",
			date_format = "%Y-%m-%d",
			alias_format = "%Y年%m月%d日",
			default_tags = { "daily-notes" },
			template = "daily.md"
		},
		

		-- 補完設定
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},

		-- キーマッピング (markdownファイル内)
		mappings = {
			-- リンク移動
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- チェックボックス切替
			["<localleader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			-- スマートアクション
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			}
		},

		-- 新しいノートの保存場所
		new_notes_location = "notes_subdir",
		
		-- ノートID生成関数（わかりやすい名前）
		note_id_func = function(title)
			if title ~= nil then
				-- タイトルをファイル名に適した形式に変換
				return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-ぁ-んァ-ン一-龯]", ""):lower()
			else
				-- タイトルがない場合はタイムスタンプベース
				return "note-" .. tostring(os.time())
			end
		end,

		-- フロントマター生成（aliasesなし）
		note_frontmatter_func = function(note)
			local out = { 
				id = note.id, 
				tags = note.tags,
				created = os.date("%Y-%m-%d %H:%M:%S"),
			}
			
			-- カスタムメタデータがあれば追加
			if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
				for k, v in pairs(note.metadata) do
					out[k] = v
				end
			end
			return out
		end,

		-- テンプレート設定
		templates = {
			subdir = "template",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			-- 置換用変数
			substitutions = {
				["jp_date"] = function()
					return os.date("%Y年%m月%d日")
				end,
			},
		},

		-- URLの扱い
		follow_url_func = function(url)
			-- WindowsとLinuxの両方に対応
			if vim.fn.has('win32') == 1 then
				vim.fn.jobstart({"cmd", "/c", "start", url}, {detach = true})
			else
				vim.fn.jobstart({"open", url}, {detach = true})
			end
		end,

		-- 高度な設定
		use_advanced_uri = false,
		open_app_foreground = false,

		-- Telescope設定
		picker = {
			name = "telescope.nvim",
			note_mappings = {
				new = "<C-x>",
				insert_link = "<C-l>",
			},
			tag_mappings = {
				tag_note = "<C-x>",
				insert_tag = "<C-l>",
			},
		},

		-- ソート設定
		sort_by = "modified",
		sort_reversed = true,
		search_max_lines = 1000,
		open_notes_in = "current",

		-- UI強化
		ui = {
			enable = true,
			update_debounce = 200,
			max_file_length = 5000,
			checkboxes = {
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
				[">"] = { char = "", hl_group = "ObsidianRightArrow" },
				["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
				["!"] = { char = "", hl_group = "ObsidianImportant" },
			},
			bullets = { char = "•", hl_group = "ObsidianBullet" },
			external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
			reference_text = { hl_group = "ObsidianRefText" },
			highlight_text = { hl_group = "ObsidianHighlightText" },
			tags = { hl_group = "ObsidianTag" },
			block_ids = { hl_group = "ObsidianBlockID" },
			hl_groups = {
				ObsidianTodo = { bold = true, fg = "#f78c6c" },
				ObsidianDone = { bold = true, fg = "#89ddff" },
				ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
				ObsidianTilde = { bold = true, fg = "#ff5370" },
				ObsidianImportant = { bold = true, fg = "#d73027" },
				ObsidianBullet = { bold = true, fg = "#89ddff" },
				ObsidianRefText = { underline = true, fg = "#c792ea" },
				ObsidianExtLinkIcon = { fg = "#c792ea" },
				ObsidianTag = { italic = true, fg = "#89ddff" },
				ObsidianBlockID = { italic = true, fg = "#89ddff" },
				ObsidianHighlightText = { bg = "#75662e" },
			},
		},

		-- 添付ファイル設定
		attachments = {
			img_folder = "assets/images",
			img_name_func = function()
				return string.format("%s-", os.date("%Y%m%d%H%M%S"))
			end,
			img_text_func = function(client, path)
				path = client:vault_relative_path(path) or path
				return string.format("![%s](%s)", path.name, path)
			end,
		},

		-- YAML frontmatterの設定
		yaml_parser = "native",
	},
	
	-- 日記作成時の自動見出し設定
	config = function(_, opts)
		require("obsidian").setup(opts)
		
		-- 日記ファイルの見出し自動修正
		vim.api.nvim_create_autocmd({"BufNewFile", "BufReadPost"}, {
			pattern = {"*/journal/*.md", "*/obsidian/*/journal/*.md"},
			callback = function()
				local filename = vim.fn.expand("%:t:r")
				
				-- YYYY-MM-DD形式の場合のみ処理
				if filename:match("^%d%d%d%d%-%d%d%-%d%d$") then
					local year, month, day = filename:match("^(%d%d%d%d)%-(%d%d)%-(%d%d)$")
					if year and month and day then
						local jp_date = string.format("%s年%s月%s日", 
							tonumber(year), tonumber(month), tonumber(day))
						
						-- 複数回試行
						local function fix_title()
							local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
							local new_lines = {}
							local modified = false
							local skip_aliases = false
							
							for i, line in ipairs(lines) do
								-- 見出しの修正
								if line:match("^# ") and not line:match("^# %d%d%d%d年") then
									table.insert(new_lines, "# " .. jp_date)
									modified = true
								-- aliases セクションの開始を検出
								elseif line:match("^aliases:") then
									skip_aliases = true
									modified = true
								-- aliases の項目をスキップ
								elseif skip_aliases and line:match("^%s*%-") then
									modified = true
								-- aliases セクション終了（次のキーまたは---）
								elseif skip_aliases and (line:match("^%w+:") or line:match("^%-%-%-")) then
									skip_aliases = false
									table.insert(new_lines, line)
								-- 通常の行
								elseif not skip_aliases then
									table.insert(new_lines, line)
								end
							end
							
							if modified then
								vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
								-- バッファを保存（サイレント）
								vim.api.nvim_buf_call(0, function()
									vim.cmd("silent! write")
								end)
								return true
							end
							return false
						end
						
						-- 即座に実行
						if not fix_title() then
							-- 失敗したら遅延実行
							vim.defer_fn(fix_title, 500)
						end
					end
				end
			end,
		})
	end,
}

return {
	{
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.8',
		cmd = "Telescope",
		keys = {
			{ '<C-S-j>', function() require('telescope.builtin').buffers() end, desc = '📋 バッファ検索' },
			{ '<C-S-f>', function() require('telescope.builtin').live_grep() end, desc = '🔍 文字列検索' },
			{ '<C-S-p>', function() require('telescope.builtin').find_files() end, desc = '📁 ファイル検索' },
			{ '<C-S-k>', function() require('telescope.builtin').oldfiles() end, desc = '📁 最近のファイル' },

			{ '<Leader>ff', function() require('telescope.builtin').find_files() end, desc = '📁 ファイル検索' },
			{ '<Leader>fg', function() require('telescope.builtin').live_grep() end, desc = '🔍 文字列検索' },
			{ '<leader>fr', function() require('telescope.builtin').oldfiles() end, desc = '📁 最近のファイル' },
			{ '<Leader>fb', function() require('telescope.builtin').buffers() end, desc = '📋 バッファ検索' },
			{ '<Leader>fp', function() 
				require("telescope").load_extension("project")
				vim.cmd('Telescope project') 
			end, desc = '🏠 プロジェクト選択' },
			{ '<leader>gc', function() require('telescope.builtin').git_commits() end, desc = '🔀 コミット履歴' },
			{ '<leader>gb', function() require('telescope.builtin').git_branches() end, desc = '🔀 ブランチ一覧' },
			{ '<leader>gs', function() require('telescope.builtin').git_status() end, desc = '🔀 Git状態' },
			{ '<Leader>fk', function() 
				require('telescope.builtin').keymaps({
					prompt_title = "🔍 キーマップナビゲーター",
					layout_config = {
						height = 0.6,
						width = 0.8,
					},
					attach_mappings = function(prompt_bufnr, map)
						-- カスタムアクション: 選択したキーマップを実行
						map('i', '<CR>', function()
							local selection = require('telescope.actions.state').get_selected_entry()
							if selection then
								local key = selection.value.lhs
								-- Telescopeを閉じる
								require('telescope.actions').close(prompt_bufnr)
								-- キーマップを実行
								vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), 'n', true)
							end
						end)
						-- 説明をプレビューで表示
						map('i', '<C-p>', function()
							local selection = require('telescope.actions.state').get_selected_entry()
							if selection and selection.value.desc then
								print("📝 " .. selection.value.desc)
							end
						end)
						return true
					end,
				})
			end, desc = '🔍 キーマップ検索' },
			{ '<Leader><Leader>', function()
				local ok, err = pcall(function()
					vim.cmd('Telescope cmdline')
				end)
				if not ok then
					vim.notify("Command Palette実行エラー: " .. (err or "不明なエラー"), vim.log.levels.ERROR)
					-- フォールバック: 通常のコマンドライン
					vim.cmd(":")
				end
			end, desc = '🎯 Command Palette' },
		},
		config = function() 
            local telescope = require('telescope')
            local actions = require('telescope.actions')

            -- 🎯 統一ファイル除外パターン定義
            local EXCLUSION_PATTERNS = {
                "--glob", "!**/.git/*",
                "--glob", "!**/*.meta",
                "--glob", "!**/*.dll",
                "--glob", "!**/*.exe",
                "--glob", "!**/*.so",
                "--glob", "!**/*.dylib",
                "--glob", "!**/*.pdb",
                "--glob", "!**/*.mdb",
                "--glob", "!**/Library/**",
                "--glob", "!**/Temp/**",
                "--glob", "!**/Logs/**",
                "--glob", "!**/obj/**",
                "--glob", "!**/bin/**",
                "--glob", "!**/.vs/**",
                "--glob", "!**/.vscode/**",
                "--glob", "!**/node_modules/**",
            }
            
            local MINIMAL_EXCLUSION = {"--glob", "!**/.git/*"}

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
                    -- QuickFix統合のキーマップ
                    mappings = {
                        i = {
                            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                            ["<C-l>"] = actions.send_to_loclist + actions.open_loclist,
                            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<M-l>"] = actions.send_selected_to_loclist + actions.open_loclist,
                            ["<C-h>"] = "which_key", -- gitignoreトグル用
                            ["<C-c>"] = actions.close, -- Ctrl+CでTelescope終了
                        },
                        n = {
                            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                            ["<C-l>"] = actions.send_to_loclist + actions.open_loclist,
                            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<M-l>"] = actions.send_selected_to_loclist + actions.open_loclist,
                            ["<C-h>"] = "which_key", -- gitignoreトグル用
                            ["<C-c>"] = actions.close, -- Ctrl+CでTelescope終了
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true, -- 隠しファイル表示
                        find_command = vim.list_extend({"rg", "--files", "--hidden"}, EXCLUSION_PATTERNS),
                        mappings = {
                            i = {
                                ["<C-i>"] = function(prompt_bufnr)
                                    local current_picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
                                    local find_command = current_picker.finder.command_generator()[1]
                                    if vim.tbl_contains(find_command, "--no-ignore") then
                                        -- gitignore除外モードに戻す（Unity除外含む）
                                        current_picker:refresh(vim.list_extend({"rg", "--files", "--hidden"}, EXCLUSION_PATTERNS))
                                        print("ファイル除外: ON (Unity/開発ファイル除外)")
                                    else
                                        -- すべて表示（最小限の除外のみ）
                                        current_picker:refresh(vim.list_extend({"rg", "--files", "--hidden", "--no-ignore"}, MINIMAL_EXCLUSION))
                                        print("ファイル除外: OFF (全ファイル表示)")
                                    end
                                end,
                            },
                            n = {
                                ["<C-i>"] = function(prompt_bufnr)
                                    local current_picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
                                    local find_command = current_picker.finder.command_generator()[1]
                                    if vim.tbl_contains(find_command, "--no-ignore") then
                                        -- gitignore除外モードに戻す（Unity除外含む）
                                        current_picker:refresh({ 
                                            "rg", "--files", "--hidden", 
                                            "--glob", "!**/.git/*",
                                            "--glob", "!**/*.meta",
                                            "--glob", "!**/*.dll",
                                            "--glob", "!**/*.exe",
                                            "--glob", "!**/*.so",
                                            "--glob", "!**/*.dylib",
                                            "--glob", "!**/*.pdb",
                                            "--glob", "!**/*.mdb",
                                            "--glob", "!**/Library/**",
                                            "--glob", "!**/Temp/**",
                                            "--glob", "!**/Logs/**",
                                            "--glob", "!**/obj/**",
                                            "--glob", "!**/bin/**",
                                            "--glob", "!**/.vs/**",
                                            "--glob", "!**/.vscode/**",
                                            "--glob", "!**/node_modules/**",
                                        })
                                        print("ファイル除外: ON (Unity/開発ファイル除外)")
                                    else
                                        -- すべて表示（最小限の除外のみ）
                                        current_picker:refresh({ "rg", "--files", "--hidden", "--no-ignore", "--glob", "!**/.git/*" })
                                        print("ファイル除外: OFF (全ファイル表示)")
                                    end
                                end,
                            },
                        },
                    },
                    live_grep = {
                        additional_args = function()
                            return vim.list_extend({"--hidden"}, EXCLUSION_PATTERNS)
                        end,
                        mappings = {
                            i = {
                                ["<C-i>"] = function(prompt_bufnr)
                                    local current_picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
                                    local additional_args = current_picker.finder.additional_args
                                    if additional_args and vim.tbl_contains(additional_args(), "--no-ignore") then
                                        -- gitignore除外モードに戻す（Unity除外含む）
                                        current_picker.finder.additional_args = function()
                                            return vim.list_extend({"--hidden"}, EXCLUSION_PATTERNS)
                                        end
                                        current_picker:refresh()
                                        print("ファイル除外: ON (Unity/開発ファイル除外)")
                                    else
                                        -- gitignoreを無視してすべて検索
                                        current_picker.finder.additional_args = function()
                                            return vim.list_extend({"--hidden", "--no-ignore"}, MINIMAL_EXCLUSION)
                                        end
                                        current_picker:refresh()
                                        print("ファイル除外: OFF (全ファイル検索)")
                                    end
                                end,
                            },
                            n = {
                                ["<C-i>"] = function(prompt_bufnr)
                                    local current_picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
                                    local additional_args = current_picker.finder.additional_args
                                    if additional_args and vim.tbl_contains(additional_args(), "--no-ignore") then
                                        -- gitignore除外モードに戻す
                                        current_picker.finder.additional_args = function()
                                            return vim.list_extend({"--hidden"}, EXCLUSION_PATTERNS)
                                        end
                                        current_picker:refresh()
                                        print("gitignore除外: ON")
                                    else
                                        -- gitignoreを無視してすべて検索
                                        current_picker.finder.additional_args = function()
                                            return {"--hidden", "--no-ignore", "--glob", "!**/.git/*"}
                                        end
                                        current_picker:refresh()
                                        print("gitignore除外: OFF")
                                    end
                                end,
                            },
                        },
                    },
                    -- バッファ選択時のデフォルトモード設定
                    buffers = {
                        initial_mode = "normal", -- デフォルトをノーマルモードに設定
                        sort_mru = true, -- 最近使用順でソート
                        sort_lastused = true, -- 最後に使用したものを上位に
                        show_all_buffers = true, -- すべてのバッファを表示
                        -- パス表示設定：プロジェクトルートからの相対パス表示
                        path_display = function(opts, path)
                            -- 現在の作業ディレクトリを取得
                            local cwd = vim.fn.getcwd()

                            -- パスを正規化（バックスラッシュをスラッシュに統一）
                            local normalized_path = path:gsub("\\", "/")
                            local normalized_cwd = cwd:gsub("\\", "/")

                            -- プロジェクト内のファイルかチェック
                            if vim.startswith(normalized_path, normalized_cwd) then
                                -- プロジェクトルートからの相対パス表示
                                local relative_path = vim.fn.fnamemodify(path, ":~:.")
                                -- 先頭の"./"を削除
                                relative_path = relative_path:gsub("^%./", "")
                                return relative_path
                            else
                                -- プロジェクト外ファイルはファイル名のみ表示
                                return vim.fn.fnamemodify(path, ":t")
                            end
                        end,
                        mappings = {
                            i = {
                                ["<C-x>"] = actions.delete_buffer, -- インサートモードでバッファ削除
                            },
                            n = {
                                ["dd"] = actions.delete_buffer, -- ノーマルモードでバッファ削除
                                ["<C-x>"] = actions.delete_buffer, -- 代替削除キー
                            },
                        },
                    },
                },
                extensions = {
                    cmdline = {
                        -- 安全な基本設定
                        picker = {
                            layout_strategy = "bottom_pane",
                            layout_config = {
                                height = 0.3,
                            },
                            prompt_title = "🎯 Command Palette",
                            sorting_strategy = "ascending",
                            previewer = false,
                            results_title = false,
                        },
                        mappings = {
                            complete = "<Tab>",
                            run_selection = "<CR>",
                            run_input = "<CR>",
                        },
                        -- エラー回避のための安全設定
                        overseer = {
                            enabled = false,
                        },
                    },
                },
            })

		end,
	},
	{
		"jonarrien/telescope-cmdline.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			-- extension読み込み時のエラーハンドリング
			local ok, err = pcall(function()
				require("telescope").load_extension("cmdline")
			end)
			if not ok then
				vim.notify("telescope-cmdline extension読み込み失敗: " .. (err or "不明なエラー"), vim.log.levels.WARN)
			end
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		cmd = "Telescope file_browser",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			-- extensionは使用時にロード
		end,
	},
	{
		"nvim-telescope/telescope-project.nvim",
		cmd = "Telescope project",
		config = function()
			-- extensionは使用時（キーマップ）でロード
		end,
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		version = "*",
		keys = {
			{ '<Leader>fq', function() 
				require("telescope").load_extension "frecency"
				vim.cmd('Telescope frecency path_display={"shorten"} theme=ivy')
			end, desc = '📁 頻繁に使うファイル' },
		},
	},
	{
		"jmacadie/telescope-hierarchy.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{ "<leader>li", function()
				require("telescope").load_extension("hierarchy")
				vim.cmd("Telescope hierarchy incoming_calls")
			end, desc = "🎯 呼び出し元", },
			{ "<leader>lo", function()
				require("telescope").load_extension("hierarchy")
				vim.cmd("Telescope hierarchy outgoing_calls")
			end, desc = "🎯 呼び出し先", },
		},
	},
}

return {
	{
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.8',
		cmd = "Telescope",
		keys = {
			{ '<Leader>ff', function() require('telescope.builtin').find_files() end, desc = '📁 ファイル検索' },
			{ '<Leader>fg', function() require('telescope.builtin').live_grep() end, desc = '🔍 文字列検索' },
			{ '<leader>fr', function() require('telescope.builtin').oldfiles() end, desc = '📁 最近のファイル' },
			{ '<Leader>fb', function() require('telescope.builtin').buffers() end, desc = '📋 バッファ検索' },
			{ '<Leader>fc', function() require('telescope.builtin').commands() end, desc = '🔍 コマンド検索' },
			{ '<Leader>fp', function() 
				require("telescope").load_extension("project")
				vim.cmd('Telescope project') 
			end, desc = '🏠 プロジェクト選択' },
			{ '<leader>gc', function() require('telescope.builtin').git_commits() end, desc = '🔀 コミット履歴' },
			{ '<leader>gb', function() require('telescope.builtin').git_branches() end, desc = '🔀 ブランチ一覧' },
			{ '<leader>gs', function() require('telescope.builtin').git_status() end, desc = '🔀 Git状態' },
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
                    -- QuickFix統合のキーマップ
                    mappings = {
                        i = {
                            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                            ["<C-l>"] = actions.send_to_loclist + actions.open_loclist,
                            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<M-l>"] = actions.send_selected_to_loclist + actions.open_loclist,
                            ["<C-h>"] = "which_key", -- gitignoreトグル用
                        },
                        n = {
                            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                            ["<C-l>"] = actions.send_to_loclist + actions.open_loclist,
                            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            ["<M-l>"] = actions.send_selected_to_loclist + actions.open_loclist,
                            ["<C-h>"] = "which_key", -- gitignoreトグル用
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true, -- 隠しファイル表示
                        find_command = { 
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
                        },
                        mappings = {
                            i = {
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
                            return {
                                "--hidden", 
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
                        end,
                        mappings = {
                            i = {
                                ["<C-i>"] = function(prompt_bufnr)
                                    local current_picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
                                    local additional_args = current_picker.finder.additional_args
                                    if additional_args and vim.tbl_contains(additional_args(), "--no-ignore") then
                                        -- gitignore除外モードに戻す（Unity除外含む）
                                        current_picker.finder.additional_args = function()
                                            return {
                                                "--hidden", 
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
                                        end
                                        current_picker:refresh()
                                        print("ファイル除外: ON (Unity/開発ファイル除外)")
                                    else
                                        -- gitignoreを無視してすべて検索
                                        current_picker.finder.additional_args = function()
                                            return {"--hidden", "--no-ignore", "--glob", "!**/.git/*"}
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
                                            return {"--hidden", "--glob", "!**/.git/*"}
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
                },
            })

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

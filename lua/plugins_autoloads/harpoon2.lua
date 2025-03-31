return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- ハープーンの基本設定
		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
				key = function()
					-- プロジェクトごとに異なる設定ファイルを使用
					return vim.loop.cwd()
				end,
			}
		})

		-- コマンドとグループを追加する関数
		local function add_file_with_name()
			vim.ui.input({ prompt = "ブックマーク名: " }, function(name)
				if name then
					local current_file = vim.fn.expand("%")
					local row, col = unpack(vim.api.nvim_win_get_cursor(0))

					harpoon:list():append({
						value = current_file,
						context = {
							row = row,
							col = col,
							name = name,
						},
					})
				end
			end)
		end

		-- グループ選択のための関数
		local function select_group()
			local groups = {"main", "work", "personal", "temp"}
			vim.ui.select(groups, {
				prompt = "グループを選択:",
			}, function(group)
					if group then
						harpoon:setup({
							settings = {
								key = function()
									return vim.loop.cwd() .. ":" .. group
								end,
							}
						})
						vim.notify("ブックマークグループを「" .. group .. "」に変更しました", vim.log.levels.INFO)
					end
				end)
		end

		-- キーマッピング
		vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end, { desc = "ブックマークに追加" })
		vim.keymap.set("n", "<leader>hA", add_file_with_name, { desc = "名前付きでブックマークに追加" })
		vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "ブックマーク一覧" })
		vim.keymap.set("n", "<leader>hg", select_group, { desc = "ブックマークグループを選択" })

		-- 数字キーでの移動
		vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "ブックマーク 1" })
		vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "ブックマーク 2" })
		vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "ブックマーク 3" })
		vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "ブックマーク 4" })

		-- 前後移動
		vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "前のブックマーク" })
		vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "次のブックマーク" })
	end
}

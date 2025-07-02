return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	-- Optional dependencies
	-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
	dependencies = { 
		"nvim-tree/nvim-web-devicons", -- use if prefer nvim-web-devicons
		"refractalize/oil-git-status.nvim"
	},
	cmd = "Oil",
	keys = { { "-", "<CMD>Oil<CR>", desc = "📁 親ディレクトリを開く" } },
	config = function()
		opts = {
			win_options = {
				signcolumn = "yes:2",
			},
			keymaps = {
				["?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
				["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
				--["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
				["<C-t>"] = "actions.open_terminal",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["<BS>"] = "actions.parent",
				["u"] = "actions.parent",
				["-"] = "actions.close",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory", mode = "n" },
				["s"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["."] = "actions.toggle_hidden",
				--["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
		}

		require("oil").setup(opts)
		require("oil-git-status").setup()
		-- キーマップは keys で定義済み
	end,
}




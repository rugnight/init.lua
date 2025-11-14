-- UnrealDev.nvim - Unreal Engine Development Suite
-- https://github.com/taku25/UnrealDev.nvim
return {
	{
		"taku25/UnrealDev.nvim",
		dependencies = {
			{ "taku25/UNL.nvim", lazy = false }, -- Core library
			"taku25/UEP.nvim", -- Project navigation
			"taku25/UBT.nvim", -- Build tool integration
			"taku25/UCM.nvim", -- Class manager
			"taku25/ULG.nvim", -- Log viewer
			"taku25/USH.nvim", -- Shader support
			{ "taku25/USX.nvim", lazy = false }, -- Syntax extension
			"nvim-telescope/telescope.nvim", -- Required for UI
			"j-hui/fidget.nvim", -- Progress UI
		},
		ft = { "cpp", "h", "hpp", "c" }, -- UnrealEngine C++ files
		cmd = { "UDEV" }, -- Command interface
		keys = {
			-- File navigation
			{ "<leader>uf", "<cmd>UDEV files<cr>", desc = "UE: Find Files" },
			{ "<leader>um", "<cmd>UDEV modules<cr>", desc = "UE: Find Modules" },

			-- Class management
			{ "<leader>us", "<cmd>UDEV switch<cr>", desc = "UE: Switch Header/Source" },
			{ "<leader>un", "<cmd>UDEV new<cr>", desc = "UE: New Class" },
			{ "<leader>ur", "<cmd>UDEV rename<cr>", desc = "UE: Rename Class" },
			{ "<leader>ud", "<cmd>UDEV delete<cr>", desc = "UE: Delete Class" },

			-- Build operations
			{ "<leader>ub", "<cmd>UDEV build<cr>", desc = "UE: Build" },
			{ "<leader>ug", "<cmd>UDEV generate<cr>", desc = "UE: Generate Project Files" },
			{ "<leader>uc", "<cmd>UDEV clean<cr>", desc = "UE: Clean Build" },

			-- Project management
			{ "<leader>ux", "<cmd>UDEV refresh<cr>", desc = "UE: Refresh Project" },
			{ "<leader>ul", "<cmd>UDEV logs<cr>", desc = "UE: Show Logs" },
		},
		opts = {
			-- UNL.nvim global configuration
			unl = {
				ui = {
					picker = "auto", -- auto, telescope, fzf, snacks
					filer = "auto", -- auto, neo-tree, nvim-tree
					progress = "auto", -- auto, fidget, snacks
				},
				logging = {
					level = "info", -- verbose, debug, info, warn, error, fatal
					echo = true,
					notify = "error", -- Notification level
					file = false, -- Log to file
				},
				cache = {
					dir_name = ".udev_cache",
				},
			},

			-- UEP.nvim configuration
			uep = {
				auto_refresh = true,
				cache_ttl = 3600, -- Cache time-to-live in seconds
			},

			-- UBT.nvim configuration
			ubt = {
				default_target = "Editor",
				default_config = "Development",
				default_platform = "Mac", -- Mac, Win64, Linux
				jobs = 0, -- 0 = auto-detect CPU cores
			},

			-- UCM.nvim configuration
			ucm = {
				template_dir = nil, -- Custom template directory
			},
		},
		config = function(_, opts)
			require("UnrealDev").setup(opts)
		end,
	},
}

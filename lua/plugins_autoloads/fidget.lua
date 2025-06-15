return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	opts = {
		notification = {
			window = {
				winblend = 0,
				border = "none",
				zindex = 45,
				max_width = 0,
				max_height = 0,
				x_padding = 1,
				y_padding = 0,
				align = "bottom",
				relative = "editor",
			},
		},
		progress = {
			poll_rate = 200,
			suppress_on_insert = false,
			ignore_done_already = false,
			ignore_empty_message = false,
			clear_on_detach = function(client_id)
				local client = vim.lsp.get_client_by_id(client_id)
				return client and client.name or nil
			end,
			notification_group = function(msg) 
				return msg.lsp_client.name
			end,
			ignore = {},
			display = {
				render_limit = 16,
				done_ttl = 3,
				done_icon = "✓",
				done_style = "Constant",
				progress_ttl = math.huge,
				progress_icon = { pattern = "dots", period = 1 },
				progress_style = "WarningMsg",
				group_style = "Title",
				icon_style = "Question",
				priority = 30,
				skip_history = true,
				format_message = function(msg)
					if string.find(msg.title or "", "Indexing") then
						return nil
					end
					local message = msg.message
					if not message then
						message = msg.done and "完了" or "進行中"
					end
					if msg.percentage then
						message = string.format("%s (%.0f%%)", message, msg.percentage)
					end
					return message
				end,
				format_annote = function(msg)
					return msg.title
				end,
				format_group_name = function(group)
					return tostring(group)
				end,
				overrides = {
					rust_analyzer = { name = "rust-analyzer" },
					omnisharp = { name = "C#" },
				},
			},
		},
		logger = {
			level = vim.log.levels.WARN,
			max_size = 10000,
			float_precision = 0.01,
			path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
		},
	},
	keys = {
		{ "<leader>tf", function() require("fidget").setup({}) end, desc = "Fidget表示切替" },
	},
}

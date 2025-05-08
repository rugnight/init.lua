-- https://zenn.dev/sheero/articles/fbcfba5c0f3fd6
return {
	"epwalsh/obsidian.nvim",
	version = "*",  -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "rugnight",
				path = "~/obsidian/rugnight/",
			},
			{
				name = "rugnight.net",
				path = "~/obsidian/rugnight.net/",
			},
			{
				name = "work",
				path = "~/obsidian/work/",
			},
		},
		daily_notes = {
			folder = "日記",
			--date_format = "%Y年%-m月%-d日",
			template = nil,
		},
		--note_id_func = function(title)
		--	if title ~= nil then
		--		return title:gsub('[\\/:%*%?"<>|]', "")
		--	else
		--		return tostring(os.time())
		--	end
		--end,
		--note_path_func = function(spec)
		--	local current_dir = vim.fn.expand("%:p:h")
		--	return require("plenary.path"):new(current_dir) / (spec.id .. ".md")
		--end,
	},
}

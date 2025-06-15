----------------------------------------------------------------------------------------------------
--- Git競合解決とファイル統計表示
----------------------------------------------------------------------------------------------------
return {
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require('git-conflict').setup({
				default_mappings = true,
				default_commands = true,
				disable_diagnostics = false,
				list_opener = 'copen',
				highlights = {
					incoming = 'DiffAdd',
					current = 'DiffText',
				}
			})
		end,
	},
	{
		"f-person/git-blame.nvim",
		config = function()
			vim.g.gitblame_enabled = 1
			vim.g.gitblame_message_template = '👤 <author> • <date> • <summary> • [<sha>]'
			vim.g.gitblame_date_format = '%Y-%m-%d %H:%M'
			vim.g.gitblame_delay = 300
			vim.g.gitblame_virtual_text_column = 80
			
			-- バーチャルテキストの表示位置とスタイル
			vim.g.gitblame_message_when_not_committed = '🔄 まだコミットされていません'
			vim.g.gitblame_highlight_group = "Comment"
			
			-- トグルするためのキーマッピング
			vim.keymap.set('n', '<leader>gt', ':GitBlameToggle<CR>', { desc = 'GitBlame表示切替' })
		end
	},
}
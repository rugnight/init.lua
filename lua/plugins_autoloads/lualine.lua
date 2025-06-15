return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		options = {
			icons_enabled = true,
			theme = 'gruvbox',  -- 現在のカラースキームに合わせて設定
			component_separators = { left = '', right = ''},
			section_separators = { left = '', right = ''},
			disabled_filetypes = {},
			always_divide_middle = true,
			globalstatus = true,
		},
		sections = {
			lualine_a = {'mode'},
			lualine_b = {'diff', 'diagnostics'},
			lualine_c = {'filename'},
			lualine_x = {
				-- LSPの状態を表示するカスタムコンポーネント
				{
					function()
						local clients = vim.lsp.get_clients()
						if next(clients) == nil then
							return "LSP未接続"
						end

						local client_names = {}
						for _, client in ipairs(clients) do
							-- 現在のバッファに接続しているLSPのみ表示
							local bufnr = vim.api.nvim_get_current_buf()
							if vim.lsp.buf_is_attached(bufnr, client.id) then
								table.insert(client_names, client.name)
							end
						end

						if #client_names > 0 then
							return "LSP: " .. table.concat(client_names, ", ")
						else
							return "LSP: 非アクティブ"
						end
					end,
					icon = ' ',
					color = {fg = '#a9b665'}, -- LSPが接続されているときの色
				}
			},
			lualine_y = {'progress'},
			lualine_z = {'location'}
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {'filename'},
			lualine_x = {'location'},
			lualine_y = {},
			lualine_z = {}
		},
		tabline = {},
		extensions = {}
	}
}

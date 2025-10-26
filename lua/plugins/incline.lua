-- バッファごとのステータスライン（LSP情報拡張）
return {
	'b0o/incline.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('incline').setup({
			render = function(props)
				-- プロパティの安全性チェック
				if not props or not props.buf or not vim.api.nvim_buf_is_valid(props.buf) then
					return { { '[Invalid]' } }
				end
				
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
				if filename == '' then
					filename = '[No Name]'
				end
				
				-- アイコンの安全な取得
				local ft_icon = ''
				local ft_color = nil
				local ok, devicons = pcall(require, 'nvim-web-devicons')
				if ok then
					ft_icon, ft_color = devicons.get_icon_color(filename)
					ft_icon = ft_icon or ''
				end
				
				-- LSP情報の安全な取得
				local lsp_info = ""
				local ok_lsp, clients = pcall(vim.lsp.get_clients, { bufnr = props.buf })
				if ok_lsp and clients and #clients > 0 then
					local client_names = {}
					for _, client in ipairs(clients) do
						if client and client.name then
							table.insert(client_names, client.name)
						end
					end
					if #client_names > 0 then
						lsp_info = " [" .. table.concat(client_names, ",") .. "]"
					end
				end
				
				-- 診断情報の安全な取得
				local diag_info = ""
				local ok_diag, diagnostics = pcall(vim.diagnostic.get, props.buf)
				if ok_diag and diagnostics and #diagnostics > 0 then
					local error_count = 0
					local warn_count = 0
					for _, diag in ipairs(diagnostics) do
						if diag and diag.severity then
							if diag.severity == vim.diagnostic.severity.ERROR then
								error_count = error_count + 1
							elseif diag.severity == vim.diagnostic.severity.WARN then
								warn_count = warn_count + 1
							end
						end
					end
					if error_count > 0 then
						diag_info = diag_info .. " " .. error_count
					end
					if warn_count > 0 then
						diag_info = diag_info .. " " .. warn_count
					end
				end
				
				local result = {}
				if ft_icon and ft_icon ~= '' then
					table.insert(result, { ft_icon, guifg = ft_color })
					table.insert(result, { ' ' })
				end
				table.insert(result, { filename })
				if lsp_info ~= '' then
					table.insert(result, { lsp_info, gui = 'italic', guifg = '#7C3AED' })
				end
				if diag_info ~= '' then
					table.insert(result, { diag_info, guifg = '#EF4444' })
				end
				
				return result
			end,
			hide = {
				cursorline = false,
				focused_win = false,
				only_win = false,
			},
			window = {
				margin = {
					horizontal = 1,
					vertical = 1,
				},
				placement = {
					horizontal = 'right',
					vertical = 'top',
				},
				padding = 1,
				padding_char = ' ',
				zindex = 50,
			},
			-- 特定のファイルタイプで非表示
			ignore = {
				buftypes = { 'terminal', 'quickfix', 'help', 'nofile' },
				filetypes = { 'oil', 'neo-tree', 'alpha', 'dashboard', 'startify' },
				floating_wins = true,
				unlisted_buffers = true,
				wintypes = { 'popup', 'autocmd', 'preview' },
			},
		})
	end,
	event = 'VeryLazy',
}

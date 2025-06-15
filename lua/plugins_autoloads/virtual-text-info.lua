----------------------------------------------------------------------------------------------------
--- IDEライクなバーチャルテキスト情報表示
----------------------------------------------------------------------------------------------------
return {
	{
		"VidocqH/lsp-lens.nvim",
		event = "LspAttach",
		config = function()
			require'lsp-lens'.setup({
				enable = true,
				include_declaration = true,
				sections = {
					definition = true,
					references = true,
					implements = true,
				},
				ignore_filetype = {
					"prisma",
				},
				-- すべてのシンボルタイプを対象に
				target_symbol_kinds = {
					vim.lsp.protocol.SymbolKind.Function,
					vim.lsp.protocol.SymbolKind.Method,
					vim.lsp.protocol.SymbolKind.Interface,
					vim.lsp.protocol.SymbolKind.Class,
					vim.lsp.protocol.SymbolKind.Struct,
					vim.lsp.protocol.SymbolKind.Property,
					vim.lsp.protocol.SymbolKind.Field,
					vim.lsp.protocol.SymbolKind.Constructor,
				},
			})
			
			-- LSPアタッチ時に強制的に有効化
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function()
					vim.defer_fn(function()
						local ok, lens = pcall(require, "lsp-lens")
						if ok and lens.enable then
							lens.enable()
						end
					end, 1000)
				end,
			})
		end,
		keys = {
			{ "<leader>vl", function() 
				local ok, lens = pcall(require, "lsp-lens")
				if ok and lens.toggle then
					lens.toggle()
				else
					vim.notify("LSP Lens not available", vim.log.levels.WARN)
				end
			end, desc = "LSP Lens切替" },
		},
	},
}
----------------------------------------------------------------------------------------------------
--- モダンなLSP参照数表示
----------------------------------------------------------------------------------------------------
return {
	{
		"Wansmer/symbol-usage.nvim",
		event = "LspAttach",
		config = function()
			require("symbol-usage").setup({
				-- バーチャルテキストの設定
				text_format = function(symbol)
					local result = {}
					if symbol.references then
						local usage = symbol.references <= 1 and "usage" or "usages"
						table.insert(result, ("👁️ %s %s"):format(symbol.references, usage))
					end
					if symbol.definition then
						table.insert(result, ("📍 %s"):format(symbol.definition))
					end
					if symbol.implementation then
						table.insert(result, ("🔧 %s impl"):format(symbol.implementation))
					end
					return table.concat(result, ", ")
				end,
				
				-- 表示設定
				vt_position = "above", -- シンボルの上の行に表示
				request_pending_text = "loading...",
				hl = { link = "Comment" }, -- ハイライトグループ
				
				-- ターゲット種別
				kinds = {
					vim.lsp.protocol.SymbolKind.Function,
					vim.lsp.protocol.SymbolKind.Method,
					vim.lsp.protocol.SymbolKind.Interface,
					vim.lsp.protocol.SymbolKind.Class,
					vim.lsp.protocol.SymbolKind.Struct,
					vim.lsp.protocol.SymbolKind.Property,
					vim.lsp.protocol.SymbolKind.Field,
					vim.lsp.protocol.SymbolKind.Constructor,
				},
				
				-- 言語固有設定
				langs = {
					csharp = { 
						kinds = { 
							vim.lsp.protocol.SymbolKind.Method, 
							vim.lsp.protocol.SymbolKind.Function, 
							vim.lsp.protocol.SymbolKind.Class 
						} 
					},
				},
				
				-- 除外設定
				filetypes = {},
				references = { enabled = true, include_declaration = false },
				definition = { enabled = true },
				implementation = { enabled = true },
			})
		end,
		keys = {
			{ "<leader>vl", function() 
				require("symbol-usage").toggle()
			end, desc = "シンボル使用状況切替" },
		},
	},
}
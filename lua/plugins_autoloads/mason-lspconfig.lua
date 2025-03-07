return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		opts = {},
	},
	{
		'saghen/blink.cmp',
		version = '*', -- バイナリをダウンロードする場合

		opts = {
			keymap = { preset = 'super-tab' },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},

			sources = {
				default = {
					'lsp',
					'path',
					'snippets',
					'buffer'
				},
			},

			fuzzy = { implementation = "prefer_rust_with_warning" }
		},
		opts_extend = { "sources.default" },
		config = function(_, opts)
			require('blink.cmp').setup(opts)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "neovim/nvim-lspconfig" },
			{ "saghen/blink.cmp" },
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers {
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function (server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup {
						capabilities = require("blink.cmp").get_lsp_capabilities(opts.capabilities)
					}
				end,
				-- Next, you can provide a dedicated handler for specific servers.
				-- For example, a handler override for the `rust_analyzer`:
				--["rust_analyzer"] = function ()
				--	require("rust-tools").setup {}
				--end
			}

			--local mason = require("mason")
			--local lspconfig = require("lspconfig")
			--local mason_lspconfig =  require("mason-lspconfig")

			--mason.setup()
			--mason_lspconfig.setup()
			--mason_lspconfig.setup_handlers({
			--	function(server_name)
			--		local opt = {
			--			--capabilities = require('cmp_nvim_lsp').default_capabilities()
			--			capabilities = require("blink.cmp").get_lsp_capabilities(opts.capabilities)
			--		}
			--		lspconfig[server_name].setup(opt)
			--	end,
			--	["vtsls"] = function()
			--		lspconfig["vtsls"].setup({})
			--	end,
			--})

			--local mini_completion = require('mini.completion')
			--mini_completion.setup({})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(_)
					vim.keymap.set('n', 'K',      '<cmd>lua vim.lsp.buf.hover()<CR>',           { desc = "API情報表示" })
					vim.keymap.set('n', '<C-k>f', '<cmd>lua vim.lsp.buf.formatting()<CR>',      { desc = "コード整形" })
					vim.keymap.set('n', 'gr',     '<cmd>lua vim.lsp.buf.references()<CR>',      { desc = "参照を表示" })
					vim.keymap.set('n', 'gd',     '<cmd>lua vim.lsp.buf.definition()<CR>',      { desc = "定義を表示" })
					vim.keymap.set('n', 'gD',     '<cmd>lua vim.lsp.buf.declaration()<CR>',     { desc = "宣言を表示" })
					vim.keymap.set('n', 'gi',     '<cmd>lua vim.lsp.buf.implementation()<CR>',  { desc = "実装を表示" })
					vim.keymap.set('n', 'gt',     '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "型定義を表示" })
					vim.keymap.set('n', 'gn',     '<cmd>lua vim.lsp.buf.rename()<CR>',          { desc = "リネーム" })
					vim.keymap.set('n', 'ga',     '<cmd>lua vim.lsp.buf.code_action()<CR>',     { desc = "コードアクション" })
					vim.keymap.set('n', 'ge',     '<cmd>lua vim.diagnostic.open_float()<CR>',   { desc = "フロート表示" })
					vim.keymap.set('n', 'g]',     '<cmd>lua vim.diagnostic.goto_next()<CR>',    { desc = "次の警告へ" })
					vim.keymap.set('n', 'g[',     '<cmd>lua vim.diagnostic.goto_prev()<CR>',    { desc = "前の警告へ" })
				end
			})

			vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
			vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
			)
		end
	}
}

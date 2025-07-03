return {
	'kevinhwang91/nvim-ufo',
	dependencies = {
		'kevinhwang91/promise-async',
		'nvim-treesitter/nvim-treesitter'
	},
	config = function()
		-- UFOの設定
		require('ufo').setup({
			provider_selector = function(bufnr, filetype, buftype)
				return {'treesitter', 'indent'}
			end
		})

		-- キーマッピング（vカテゴリに移動済み）

		-- UFO固有のマッピング
		vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
		vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
	end
}

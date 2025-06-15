return {
	'lewis6991/gitsigns.nvim',
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require('gitsigns').setup {
			signs = {
				add          = { text = '┃' },
				change       = { text = '┃' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = '~' },
				untracked    = { text = '┆' },
			},
			signs_staged = {
				add          = { text = '┃' },
				change       = { text = '┃' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = '~' },
				untracked    = { text = '┆' },
			},
			signs_staged_enable = true,
			signcolumn = true,
			numhl      = false,
			linehl     = false,
			word_diff  = false,
			watch_gitdir = {
				follow_files = true
			},
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = false,  -- 明示的に呼び出すときのみ表示
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = 'eol',
				delay = 300,
				ignore_whitespace = false,
				virt_text_priority = 100,
				use_focus = true,
			},
			current_line_blame_formatter = '👤 <author> • <author_time:%Y-%m-%d> • <summary>',
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
			max_file_length = 40000,
			preview_config = {
				style = 'minimal',
				relative = 'cursor',
				row = 0,
				col = 1,
			},
			-- ここにon_attach関数を移動
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map('n', ']c', function()
					if vim.wo.diff then
						vim.cmd.normal({']c', bang = true})
					else
						gs.nav_hunk('next')
					end
				end)

				map('n', '[c', function()
					if vim.wo.diff then
						vim.cmd.normal({'[c', bang = true})
					else
						gs.nav_hunk('prev')
					end
				end)

				-- Git Hunk Actions
				map('n', '<leader>gs', gs.stage_hunk, { desc = 'Hunkをステージ' })
				map('n', '<leader>gr', gs.reset_hunk, { desc = 'Hunkをリセット' })

				map('v', '<leader>gs', function()
					gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
				end, { desc = '選択範囲をステージ' })

				map('v', '<leader>gr', function()
					gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
				end, { desc = '選択範囲をリセット' })

				map('n', '<leader>gS', gs.stage_buffer, { desc = 'バッファ全体をステージ' })
				map('n', '<leader>gR', gs.reset_buffer, { desc = 'バッファ全体をリセット' })
				map('n', '<leader>gp', gs.preview_hunk, { desc = 'Hunkプレビュー' })
				map('n', '<leader>gi', gs.preview_hunk_inline, { desc = 'Hunkインラインプレビュー' })

				map('n', '<leader>gb', function()
					gs.blame_line({ full = true })
				end, { desc = '行のBlame表示' })

				map('n', '<leader>gd', gs.diffthis, { desc = 'Diff表示' })

				map('n', '<leader>gD', function()
					gs.diffthis('~')
				end, { desc = 'Diff表示(前回)' })

				map('n', '<leader>gQ', function() gs.setqflist('all') end, { desc = '全HunkをQuickFixに' })
				map('n', '<leader>gq', gs.setqflist, { desc = 'HunkをQuickFixに' })

				-- Toggles
				map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Blame表示切替' })
				map('n', '<leader>tw', gs.toggle_word_diff, { desc = '単語単位Diff切替' })

				-- Text object
				map({'o', 'x'}, 'ih', gs.select_hunk, { desc = 'Hunk選択' })
			end
		}
	end
}

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
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = 'eol',
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
				use_focus = true,
			},
			current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
			max_file_length = 40000,
			preview_config = {
				style = 'minimal',
				relative = 'cursor',
				row = 0,
				col = 1
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

				-- Actions
				map('n', '<leader>hs', gs.stage_hunk)
				map('n', '<leader>hr', gs.reset_hunk)

				map('v', '<leader>hs', function()
					gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
				end)

				map('v', '<leader>hr', function()
					gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
				end)

				map('n', '<leader>hS', gs.stage_buffer)
				map('n', '<leader>hR', gs.reset_buffer)
				map('n', '<leader>hp', gs.preview_hunk)
				map('n', '<leader>hi', gs.preview_hunk_inline)

				map('n', '<leader>hb', function()
					gs.blame_line({ full = true })
				end)

				map('n', '<leader>hd', gs.diffthis)

				map('n', '<leader>hD', function()
					gs.diffthis('~')
				end)

				map('n', '<leader>hQ', function() gs.setqflist('all') end)
				map('n', '<leader>hq', gs.setqflist)

				-- Toggles
				map('n', '<leader>tb', gs.toggle_current_line_blame)
				map('n', '<leader>tw', gs.toggle_word_diff)

				-- Text object
				map({'o', 'x'}, 'ih', gs.select_hunk)
			end
		}
	end
}

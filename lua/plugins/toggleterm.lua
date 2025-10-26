return {
	'akinsho/toggleterm.nvim',
	version = "*",
	keys = {
		{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "🖥️ ターミナルトグル" },
		{ "<leader>tf", function() _G.toggle_terminal_at_file_dir() end, desc = "🖥️ 現在ファイル位置でターミナル" },
		{ "<leader>tp", function() _G.toggle_terminal_at_project_root() end, desc = "🖥️ プロジェクトルートでターミナル" },
		{ "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", desc = "🖥️ 水平ターミナル" },
		{ "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "🖥️ 垂直ターミナル" },
		{ "<C-t>", "<cmd>ToggleTerm<cr>", desc = "🖥️ ターミナルトグル (Ctrl+t)" },
	},
	cmd = {
		"ToggleTerm",
		"TermExec",
		"ToggleTermToggleAll",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualLines",
		"ToggleTermSendVisualSelection",
	},
	config = function()
		require("toggleterm").setup{
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				else
					return 20
				end
			end,
			open_mapping = [[<C-t>]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			persist_mode = true,
			direction = 'horizontal',
			close_on_exit = true,
			shell = vim.o.shell,
			auto_scroll = true,
			float_opts = {
				border = 'curved',
				width = math.floor(vim.o.columns * 0.8),
				height = math.floor(vim.o.lines * 0.8),
				winblend = 0,
			},
			winbar = {
				enabled = false,
			},
		}
		
		-- ターミナルモードでのキーマップ
		function _G.set_terminal_keymaps()
			local opts = {buffer = 0}
			vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
			-- 矢印キーでのウィンドウ移動はグローバル設定を使用
			vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

			-- ターミナル用カーソル形状設定（ターミナルモード専用）
			vim.defer_fn(function()
				-- ターミナルモード（t）を追加した設定
				vim.api.nvim_set_option_value("guicursor", "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,t:ver25,a:blinkwait700-blinkoff400-blinkon250", {scope = "local"})
			end, 50)
		end
		
		vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
		
		-- カスタムターミナル関数
		local Terminal = require('toggleterm.terminal').Terminal
		
		-- ファイル位置でターミナルを開く
		local function toggle_terminal_at_file_dir()
			local file_dir = vim.fn.expand("%:p:h")
			local term = Terminal:new({
				dir = file_dir,
				direction = "float",
				close_on_exit = true,
			})
			term:toggle()
		end
		
		-- プロジェクトルートでターミナルを開く
		local function toggle_terminal_at_project_root()
			-- プロジェクトルート検出
			local function find_project_root()
				local root_patterns = {'.git', '*.csproj', '*.sln', 'package.json', 'Cargo.toml', 'pom.xml', 'init.lua'}
				local current_dir = vim.fn.expand('%:p:h')
				
				while current_dir ~= '/' and current_dir ~= '' do
					for _, pattern in ipairs(root_patterns) do
						local files = vim.fn.glob(current_dir .. '/' .. pattern, false, true)
						if #files > 0 then
							return current_dir
						end
					end
					current_dir = vim.fn.fnamemodify(current_dir, ':h')
				end
				
				return vim.fn.getcwd()
			end
			
			local project_root = find_project_root()
			local term = Terminal:new({
				dir = project_root,
				direction = "float",
				close_on_exit = true,
			})
			term:toggle()
		end
		
		-- グローバル関数として設定
		_G.toggle_terminal_at_file_dir = toggle_terminal_at_file_dir
		_G.toggle_terminal_at_project_root = toggle_terminal_at_project_root
	end
}

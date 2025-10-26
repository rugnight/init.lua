return {
	"coder/claudecode.nvim",
	lazy = false,
	keys = {
		{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "🤖 Claude Code", mode = { "n", "v" } },
		{ "<leader>ap", "<cmd>ClaudeCodePaste<cr>", desc = "🤖 Claude Code ペースト", mode = { "n", "v" } },
		{ "<leader>at", "<cmd>ClaudeCodeToggle<cr>", desc = "🤖 Claude Code トグル" },
		{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "🤖 Claude Code フォーカス" },
		{ "<leader>ar", "<cmd>ClaudeCodeResume<cr>", desc = "🤖 Claude Code 再開" },
		{ "<leader>aC", "<cmd>ClaudeCodeContinue<cr>", desc = "🤖 Claude Code 続行" },
		{ "<leader>ab", "<cmd>ClaudeCodeAddBuffer<cr>", desc = "🤖 バッファ追加" },
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", desc = "🤖 選択範囲送信", mode = "v" },
		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "🤖 差分受け入れ" },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "🤖 差分拒否" },
		{ "<leader>aq", "<cmd>ClaudeCodeQuit<cr>", desc = "🤖 Claude Code 終了" },
	},
	config = function()
		require("claudecode").setup({
			-- デフォルト設定を使用
		})
		
		-- Claude Code ターミナル用のキーマップ設定（重複防止版）
		local keymap_set_buffers = {}
		local augroup_claude = vim.api.nvim_create_augroup("ClaudeCodeTerminal", { clear = true })
		
		vim.api.nvim_create_autocmd("TermOpen", {
			group = augroup_claude,
			pattern = "*",
			callback = function()
				local buf = vim.api.nvim_get_current_buf()
				
				-- 既にキーマップが設定されているバッファはスキップ
				if keymap_set_buffers[buf] then
					return
				end
				
				-- 遅延でキーマップを設定（バッファが完全に初期化されるまで待つ）
				vim.defer_fn(function()
					-- バッファが有効でない場合はスキップ
					if not vim.api.nvim_buf_is_valid(buf) then
						return
					end
					
					local buf_name = vim.api.nvim_buf_get_name(buf)
					
					-- Claude関連のターミナルのみに適用（条件を厳格化）
					if buf_name:match("[Cc]laude") or (vim.bo[buf].buftype == "terminal" and buf_name:match("[Tt]erminal")) then
						-- キーマップ設定済みマーク
						keymap_set_buffers[buf] = true
						
						-- インサートモードを抜ける（複数の方法）
						vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = buf, desc = "ターミナル終了", noremap = true, silent = true })
						vim.keymap.set("t", "jk", "<C-\\><C-n>", { buffer = buf, desc = "jk→ターミナル終了", noremap = true, silent = true })
						vim.keymap.set("t", "kj", "<C-\\><C-n>", { buffer = buf, desc = "kj→ターミナル終了", noremap = true, silent = true })
						
						-- ウィンドウ移動
						vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h", { buffer = buf, desc = "左ウィンドウへ", noremap = true, silent = true })
						vim.keymap.set("t", "<C-w>j", "<C-\\><C-n><C-w>j", { buffer = buf, desc = "下ウィンドウへ", noremap = true, silent = true })
						vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-w>k", { buffer = buf, desc = "上ウィンドウへ", noremap = true, silent = true })
						vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l", { buffer = buf, desc = "右ウィンドウへ", noremap = true, silent = true })
						
						-- エディタにフォーカスを戻す
						vim.keymap.set("t", "<C-o>", "<C-\\><C-n><C-w>p", { buffer = buf, desc = "前のウィンドウへ", noremap = true, silent = true })
						
						-- バッファ削除時にマークもクリア
						vim.api.nvim_create_autocmd("BufDelete", {
							group = augroup_claude,
							buffer = buf,
							callback = function()
								keymap_set_buffers[buf] = nil
							end,
						})
					end
				end, 100)
			end,
		})
	end,
}
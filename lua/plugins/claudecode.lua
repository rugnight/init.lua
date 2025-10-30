----------------------------------------------------------------------------------------------------
--- Claude Code統合（coder/claudecode.nvim）
----------------------------------------------------------------------------------------------------
return {
  "coder/claudecode.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("claudecode").setup({
      -- Windows環境での設定
      terminal = {
        -- Windows環境でのターミナル設定
        shell = vim.o.shell,  -- init.luaで設定されたシェルを使用
      },
    })

  end,
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
}
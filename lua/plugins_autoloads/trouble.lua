return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function(_, opts)
    require("trouble").setup(opts)
    
    -- キーマッピング（日本語説明）
    vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics toggle<cr>", {desc = "現在のファイルの診断"})
    vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", {desc = "ロケーションリスト"})
    vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", {desc = "クイックフィックスリスト"})
    vim.keymap.set("n", "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>", {desc = "参照一覧"})
    vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols  toggle<cr>", {desc = "シンボル一覧"})
    vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics toggle<cr>", {desc = "ワークスペース全体の診断"})
    vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr><cr>", {desc = "診断一覧の表示/非表示"})
  end
}

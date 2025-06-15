----------------------------------------------------------------------------------------------------
--- ファイルタイプ固有キーマップ（ローカルリーダーキー使用）
----------------------------------------------------------------------------------------------------

-- Lua ファイル専用キーマップ
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    local map = vim.keymap.set
    -- Lua実行・テスト
    map("n", "<localleader>r", ":luafile %<CR>", { desc = "現在のLuaファイルを実行", buffer = true })
    map("n", "<localleader>l", ":Lazy<CR>", { desc = "Lazy.nvim開く", buffer = true })
    map("n", "<localleader>s", ":source %<CR>", { desc = "設定ファイル再読込", buffer = true })
  end,
})

-- C# ファイル専用キーマップ
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cs",
  callback = function()
    local map = vim.keymap.set
    -- C#ビルド・実行
    map("n", "<localleader>b", ":!dotnet build<CR>", { desc = "dotnet build", buffer = true })
    map("n", "<localleader>r", ":!dotnet run<CR>", { desc = "dotnet run", buffer = true })
    map("n", "<localleader>t", ":!dotnet test<CR>", { desc = "dotnet test", buffer = true })
    map("n", "<localleader>c", ":!dotnet clean<CR>", { desc = "dotnet clean", buffer = true })
  end,
})

-- Python ファイル専用キーマップ
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    local map = vim.keymap.set
    -- Python実行
    map("n", "<localleader>r", ":!python %<CR>", { desc = "Python実行", buffer = true })
    map("n", "<localleader>i", ":!python -i %<CR>", { desc = "Python対話モード", buffer = true })
    map("n", "<localleader>t", ":!python -m pytest<CR>", { desc = "pytest実行", buffer = true })
  end,
})

-- JavaScript/TypeScript ファイル専用キーマップ
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript" },
  callback = function()
    local map = vim.keymap.set
    -- Node.js実行・npm操作
    map("n", "<localleader>r", ":!node %<CR>", { desc = "Node.js実行", buffer = true })
    map("n", "<localleader>n", ":!npm start<CR>", { desc = "npm start", buffer = true })
    map("n", "<localleader>t", ":!npm test<CR>", { desc = "npm test", buffer = true })
    map("n", "<localleader>b", ":!npm run build<CR>", { desc = "npm build", buffer = true })
  end,
})

-- JSON ファイル専用キーマップ
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    local map = vim.keymap.set
    -- JSON整形
    map("n", "<localleader>f", ":%!jq .<CR>", { desc = "JSON整形（jq）", buffer = true })
    map("v", "<localleader>f", ":!jq .<CR>", { desc = "選択範囲JSON整形", buffer = true })
  end,
})

-- Git commit ファイル専用キーマップ
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    local map = vim.keymap.set
    -- コミットメッセージ補助
    map("i", "<localleader>c", "🤖 Generated with [Claude Code](https://claude.ai/code)<CR><CR>Co-Authored-By: Claude <noreply@anthropic.com>", { desc = "Claude署名挿入", buffer = true })
  end,
})

-- Help ファイル専用キーマップ
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function()
    local map = vim.keymap.set
    -- ヘルプナビゲーション
    map("n", "<localleader>t", "<C-]>", { desc = "タグジャンプ", buffer = true })
    map("n", "<localleader>b", "<C-o>", { desc = "戻る", buffer = true })
    map("n", "q", ":close<CR>", { desc = "ヘルプを閉じる", buffer = true })
  end,
})
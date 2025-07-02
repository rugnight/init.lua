----------------------------------------------------------------------------------------------------
--- ファイルタイプ固有キーマップ（ローカルリーダーキー使用）
----------------------------------------------------------------------------------------------------

-- Lua ファイル専用キーマップ
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    local map = vim.keymap.set
    -- Lua実行・テスト
    map("n", "<localleader>r", ":luafile %<CR>", { desc = "⚙️ 現在のLuaファイルを実行", buffer = true })
    map("n", "<localleader>l", ":Lazy<CR>", { desc = "⚙️ Lazy.nvim開く", buffer = true })
    map("n", "<localleader>s", ":source %<CR>", { desc = "⚙️ 設定ファイル再読込", buffer = true })
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

-- Claude Code バッファ専用キーマップ（改良版）
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "BufNewFile", "BufRead"}, {
  pattern = "*",
  callback = function()
    local bufname = vim.fn.bufname()
    local buftype = vim.bo.buftype
    local term_var = vim.env.TERM_PROGRAM
    
    -- Claude Code検出条件を拡張
    local is_claude_code = buftype == 'nofile' or 
                          (bufname and (
                            bufname:lower():match('claude') or 
                            bufname:lower():match('anthropic') or
                            bufname:lower():match('assistant') or
                            bufname:lower():match('chat') or
                            bufname == '' -- 無名バッファもチェック
                          )) or
                          (term_var and term_var:lower():match('claude'))
    
    if is_claude_code then
      local map = vim.keymap.set
      -- 即座にキーマップを設定（遅延なし）
      map("i", "jk", "<Esc>", { desc = "🤖 jk→Esc", buffer = true, noremap = true, silent = true, nowait = true })
      map("i", "kj", "<Esc>", { desc = "🤖 kj→Esc", buffer = true, noremap = true, silent = true, nowait = true })
      map("i", "jj", "<Esc>", { desc = "🤖 jj→Esc", buffer = true, noremap = true, silent = true, nowait = true })
      map("i", "<C-c>", "<Esc>", { desc = "🤖 Ctrl-c→Esc", buffer = true, noremap = true, silent = true, nowait = true })
      
      -- デバッグ用: キーマップが設定されたことを確認
      vim.schedule(function()
        print("Claude Code keymap set for buffer: " .. (bufname ~= '' and bufname or '[No Name]'))
      end)
    end
  end,
})

----------------------------------------------------------------------------------------------------
--- QuickFix操作ユーティリティ関数とキーマップ
----------------------------------------------------------------------------------------------------

local M = {}

-- 検索結果をQuickFixに送る関数
function M.grep_to_quickfix(pattern)
  if pattern == "" then return end
  
  -- ripgrepが利用可能かチェック
  if vim.fn.executable("rg") == 1 then
    local cmd = "rg --vimgrep --smart-case --follow --hidden " .. vim.fn.shellescape(pattern) .. " ."
    local output = vim.fn.systemlist(cmd)
    if vim.v.shell_error == 0 and #output > 0 then
      vim.fn.setqflist({}, 'r', {
        title = 'rg: ' .. pattern,
        lines = output
      })
      MY_FUNCTIONS.safe_copen()
    else
      print("No matches found for: " .. pattern)
    end
  else
    -- fallback to vimgrep
    vim.cmd("silent vimgrep /" .. pattern .. "/j **/*")
    MY_FUNCTIONS.safe_copen()
  end
end

-- カーソル下の単語でGrep検索
function M.grep_current_word()
  local pattern = vim.fn.expand("<cword>")
  M.grep_to_quickfix(pattern)
end

-- バッファローカル検索
function M.buffer_grep()
  local pattern = vim.fn.input("Buffer grep pattern: ")
  if pattern ~= "" then
    vim.cmd("silent vimgrep /" .. pattern .. "/j %")
    MY_FUNCTIONS.safe_copen()
  end
end

-- TODOコメント検索  
function M.todo_search()
  if vim.fn.executable("rg") == 1 then
    local cmd = "rg --vimgrep --smart-case 'TODO|FIXME|HACK|BUG|NOTE' ."
    local output = vim.fn.systemlist(cmd)
    if vim.v.shell_error == 0 and #output > 0 then
      vim.fn.setqflist({}, 'r', {
        title = 'TODO/FIXME/HACK/BUG/NOTE',
        lines = output
      })
      MY_FUNCTIONS.safe_copen()
    else
      print("No TODO comments found")
    end
  else
    -- fallback to vimgrep
    vim.cmd("silent vimgrep /TODO\\|FIXME\\|HACK\\|BUG\\|NOTE/j **/*")
    MY_FUNCTIONS.safe_copen()
  end
end

-- QuickFix一括置換
function M.quickfix_replace()
  local old_pattern = vim.fn.input("Replace pattern: ")
  if old_pattern == "" then return end
  local new_pattern = vim.fn.input("Replace with: ")
  if new_pattern == "" then return end
  
  vim.cmd("cfdo %s/" .. vim.fn.escape(old_pattern, "/") .. "/" .. vim.fn.escape(new_pattern, "/") .. "/gc | update")
end

-- QuickFixセッション保存
function M.save_quickfix_session()
  local session_name = vim.fn.input("Session name: ", "quickfix_session")
  if session_name ~= "" then
    local qflist = vim.fn.getqflist()
    local session_file = vim.fn.stdpath("data") .. "/qf_sessions/" .. session_name .. ".json"
    vim.fn.mkdir(vim.fn.fnamemodify(session_file, ":h"), "p")
    local file = io.open(session_file, "w")
    if file then
      file:write(vim.fn.json_encode(qflist))
      file:close()
      print("QuickFix session saved: " .. session_name)
    end
  end
end

-- QuickFixセッション復元
function M.load_quickfix_session()
  local session_name = vim.fn.input("Session name: ")
  if session_name ~= "" then
    local session_file = vim.fn.stdpath("data") .. "/qf_sessions/" .. session_name .. ".json"
    local file = io.open(session_file, "r")
    if file then
      local content = file:read("*all")
      file:close()
      local qflist = vim.fn.json_decode(content)
      vim.fn.setqflist(qflist)
      MY_FUNCTIONS.safe_copen()
      print("QuickFix session restored: " .. session_name)
    else
      print("Session not found: " .. session_name)
    end
  end
end

-- QuickFixからLocationListに移動
function M.quickfix_to_loclist()
  local qflist = vim.fn.getqflist()
  if not vim.tbl_isempty(qflist) then
    vim.fn.setloclist(0, qflist)
    vim.cmd("lopen")
    print("QuickFix → LocationList移動完了")
  end
end

-- LocationListからQuickFixに移動
function M.loclist_to_quickfix()
  local loclist = vim.fn.getloclist(0)
  if not vim.tbl_isempty(loclist) then
    vim.fn.setqflist(loclist)
    MY_FUNCTIONS.safe_copen()
    print("LocationList → QuickFix移動完了")
  end
end

-- キーマップの設定
function M.setup_keymaps()
  -- QuickFix操作の包括的キーマップ
  vim.keymap.set("n", "<Leader>qo", function()
    MY_FUNCTIONS.safe_copen()
  end, { desc = "📋 QuickFix開く" })
  
  vim.keymap.set("n", "<Leader>qc", ":cclose<CR>", { desc = "📋 QuickFix閉じる" })
  vim.keymap.set("n", "<Leader>qn", ":cnext<CR>", { desc = "📋 次のQuickFix項目" })
  vim.keymap.set("n", "<Leader>qp", ":cprev<CR>", { desc = "📋 前のQuickFix項目" })
  vim.keymap.set("n", "<Leader>qf", ":cfirst<CR>", { desc = "📋 最初のQuickFix項目" })
  vim.keymap.set("n", "<Leader>ql", ":clast<CR>", { desc = "📋 最後のQuickFix項目" })
  vim.keymap.set("n", "<Leader>qh", ":chistory<CR>", { desc = "📋 QuickFix履歴" })

  -- Location List操作
  vim.keymap.set("n", "<Leader>qO", ":lopen<CR>", { desc = "📋 LocationList開く" })
  vim.keymap.set("n", "<Leader>qC", ":lclose<CR>", { desc = "📋 LocationList閉じる" })
  vim.keymap.set("n", "<Leader>qN", ":lnext<CR>", { desc = "📋 次のLocationList項目" })
  vim.keymap.set("n", "<Leader>qP", ":lprev<CR>", { desc = "📋 前のLocationList項目" })

  -- LSP結果をQuickFixに集約
  vim.keymap.set("n", "<Leader>qr", function()
    vim.lsp.buf.references()
    vim.defer_fn(function() MY_FUNCTIONS.safe_copen() end, 200)
  end, { desc = "📋 LSP参照→QuickFix" })

  vim.keymap.set("n", "<Leader>qd", function()
    vim.diagnostic.setqflist()
    vim.cmd("copen")
  end, { desc = "🚨 診断→QuickFix" })

  vim.keymap.set("n", "<Leader>qD", function()
    vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})
    vim.cmd("copen")
  end, { desc = "🚨 エラーのみ→QuickFix" })

  -- 検索関連
  vim.keymap.set("n", "<Leader>qg", function()
    local pattern = vim.fn.input("Grep pattern: ")
    M.grep_to_quickfix(pattern)
  end, { desc = "🔍 Grep→QuickFix" })

  vim.keymap.set("n", "<Leader>qG", M.grep_current_word, { desc = "🔍 カーソル下Grep→QuickFix" })
  vim.keymap.set("n", "<Leader>qb", M.buffer_grep, { desc = "🔍 バッファ内検索→QuickFix" })
  vim.keymap.set("n", "<Leader>qt", M.todo_search, { desc = "🔍 TODO検索→QuickFix" })

  -- QuickFix操作ヘルパー
  vim.keymap.set("n", "<Leader>qe", ":cexpr []<CR>", { desc = "📋 QuickFix空にする" })
  vim.keymap.set("n", "<Leader>q;", function()
    if vim.tbl_isempty(vim.fn.getqflist()) then
      print("QuickFix list is empty")
    else
      MY_FUNCTIONS.safe_copen()
    end
  end, { desc = "📋 QuickFix再表示" })

  -- 高度なQuickFix機能
  vim.keymap.set("n", "<Leader>qR", M.quickfix_replace, { desc = "📋 QuickFix一括置換" })
  vim.keymap.set("n", "<Leader>qS", M.save_quickfix_session, { desc = "📋 QuickFixセッション保存" })
  vim.keymap.set("n", "<Leader>qL", M.load_quickfix_session, { desc = "📋 QuickFixセッション復元" })

  -- LocationList vs QuickFix使い分け
  vim.keymap.set("n", "<Leader>qm", M.quickfix_to_loclist, { desc = "📋 QuickFix→LocationList" })
  vim.keymap.set("n", "<Leader>qM", M.loclist_to_quickfix, { desc = "📋 LocationList→QuickFix" })
end

-- QuickFix自動化の設定
function M.setup_autocmds()
  -- QuickFix自動化
  vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = "*",
    callback = function()
      -- QuickFixリストが空でない場合は自動で開く
      if not vim.tbl_isempty(vim.fn.getqflist()) then
        MY_FUNCTIONS.safe_copen()
      end
    end,
    desc = "QuickFix自動オープン"
  })

  -- QuickFixウィンドウのカスタマイズ
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
      -- QuickFixウィンドウ専用キーマップ
      vim.keymap.set("n", "dd", function()
        local line = vim.fn.line(".")
        local qflist = vim.fn.getqflist()
        table.remove(qflist, line)
        vim.fn.setqflist(qflist, 'r')
      end, { desc = "QuickFix項目削除", buffer = true })
      
      vim.keymap.set("n", "R", function()
        vim.cmd("cdo edit")
      end, { desc = "全ファイル編集", buffer = true })
    end,
  })
end

return M
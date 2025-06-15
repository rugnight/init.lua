-- QuickFix強化キーマップ設定
-- 現在のwhich-key設定に追加推奨

local function setup_quickfix_keymaps()
  -- ===== 基本操作 =====
  vim.keymap.set('n', '<leader>qo', '<cmd>copen<cr>', { desc = 'QuickFix開く' })
  vim.keymap.set('n', '<leader>qc', '<cmd>cclose<cr>', { desc = 'QuickFix閉じる' })
  vim.keymap.set('n', '<leader>qt', '<cmd>cwindow<cr>', { desc = 'QuickFix切替' })
  
  -- ===== ナビゲーション =====
  vim.keymap.set('n', '<leader>qn', '<cmd>cnext<cr>zz', { desc = '次のエラー' })
  vim.keymap.set('n', '<leader>qp', '<cmd>cprev<cr>zz', { desc = '前のエラー' })
  vim.keymap.set('n', '<leader>qf', '<cmd>cfirst<cr>zz', { desc = '最初のエラー' })
  vim.keymap.set('n', '<leader>ql', '<cmd>clast<cr>zz', { desc = '最後のエラー' })
  
  -- ===== 履歴操作 =====
  vim.keymap.set('n', '<leader>q<', '<cmd>colder<cr>', { desc = '前のQuickFix履歴' })
  vim.keymap.set('n', '<leader>q>', '<cmd>cnewer<cr>', { desc = '次のQuickFix履歴' })
  vim.keymap.set('n', '<leader>qh', '<cmd>chistory<cr>', { desc = 'QuickFix履歴表示' })
  
  -- ===== LocationList =====
  vim.keymap.set('n', '<leader>lo', '<cmd>lopen<cr>', { desc = 'LocationList開く' })
  vim.keymap.set('n', '<leader>lc', '<cmd>lclose<cr>', { desc = 'LocationList閉じる' })
  vim.keymap.set('n', '<leader>ln', '<cmd>lnext<cr>zz', { desc = '次のLocation' })
  vim.keymap.set('n', '<leader>lp', '<cmd>lprev<cr>zz', { desc = '前のLocation' })
  vim.keymap.set('n', '<leader>lf', '<cmd>lfirst<cr>zz', { desc = '最初のLocation' })
  vim.keymap.set('n', '<leader>ll', '<cmd>llast<cr>zz', { desc = '最後のLocation' })
  
  -- ===== 検索・Grep =====
  vim.keymap.set('n', '<leader>fg', function()
    vim.ui.input({ prompt = 'Ripgrep: ' }, function(pattern)
      if pattern then
        vim.cmd('grep! ' .. vim.fn.shellescape(pattern))
        vim.cmd('copen')
      end
    end)
  end, { desc = 'Ripgrep検索→QuickFix' })
  
  vim.keymap.set('n', '<leader>fG', function()
    vim.ui.input({ prompt = 'ファイル種別: ' }, function(filetype)
      vim.ui.input({ prompt = 'パターン: ' }, function(pattern)
        if pattern and filetype then
          vim.cmd('grep! -t ' .. filetype .. ' ' .. vim.fn.shellescape(pattern))
          vim.cmd('copen')
        end
      end)
    end)
  end, { desc = 'ファイル種別指定検索' })
  
  -- ファイル内検索（LocationList）
  vim.keymap.set('n', '<leader>fl', function()
    vim.ui.input({ prompt = 'ファイル内検索: ' }, function(pattern)
      if pattern then
        vim.cmd('lvimgrep /' .. pattern .. '/j %')
        vim.cmd('lopen')
      end
    end)
  end, { desc = 'ファイル内検索→LocationList' })
  
  -- ===== LSP統合 =====
  vim.keymap.set('n', '<leader>lR', function()
    vim.lsp.buf.references(nil, {
      on_list = function(options)
        vim.fn.setqflist({}, ' ', options)
        vim.cmd('copen')
      end
    })
  end, { desc = 'LSP参照→QuickFix' })
  
  vim.keymap.set('n', '<leader>lD', function()
    vim.lsp.buf.definition({
      on_list = function(options)
        vim.fn.setqflist({}, ' ', options)
        vim.cmd('copen')
      end
    })
  end, { desc = 'LSP定義→QuickFix' })
  
  -- ===== 診断統合 =====
  vim.keymap.set('n', '<leader>xE', function()
    vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
  end, { desc = 'エラー診断→QuickFix' })
  
  vim.keymap.set('n', '<leader>xW', function()
    vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
  end, { desc = '警告診断→QuickFix' })
  
  vim.keymap.set('n', '<leader>xA', function()
    vim.diagnostic.setqflist()
  end, { desc = '全診断→QuickFix' })
  
  -- ===== 一括操作 =====
  vim.keymap.set('n', '<leader>qd', '<cmd>cfdo bd<cr>', { desc = 'QuickFix全バッファ削除' })
  
  -- 段階的置換
  vim.keymap.set('n', '<leader>qR', function()
    vim.ui.input({ prompt = '検索パターン: ' }, function(search)
      if not search then return end
      
      vim.ui.input({ prompt = '置換文字: ' }, function(replace)
        if not replace then return end
        
        -- 1. 検索結果をQuickFixに
        vim.cmd('grep! ' .. vim.fn.shellescape(search))
        vim.cmd('copen')
        
        -- 2. 確認後実行するコマンドを表示
        print('確認後実行: :cfdo s/' .. search .. '/' .. replace .. '/gc | update')
        
        -- 3. 実行確認
        vim.defer_fn(function()
          local choice = vim.fn.confirm('一括置換を実行しますか？', '&Yes\n&No', 2)
          if choice == 1 then
            vim.cmd('cfdo s/' .. vim.fn.escape(search, '/') .. '/' .. vim.fn.escape(replace, '/') .. '/gc | update')
          end
        end, 1000)
      end)
    end)
  end, { desc = '段階的一括置換' })
  
  -- ===== セッション管理 =====
  vim.keymap.set('n', '<leader>qS', function()
    local qflist = vim.fn.getqflist()
    local filename = vim.fn.input('セッション名: ', 'qf_' .. os.date('%Y%m%d_%H%M') .. '.json')
    if filename ~= '' then
      local file = io.open(vim.fn.stdpath('cache') .. '/' .. filename, 'w')
      if file then
        file:write(vim.fn.json_encode(qflist))
        file:close()
        print('QuickFixセッション保存: ' .. filename)
      end
    end
  end, { desc = 'QuickFixセッション保存' })
  
  vim.keymap.set('n', '<leader>qL', function()
    local cache_dir = vim.fn.stdpath('cache')
    local sessions = vim.fn.glob(cache_dir .. '/qf_*.json', false, true)
    if #sessions == 0 then
      print('保存されたセッションがありません')
      return
    end
    
    local choices = {}
    for i, session in ipairs(sessions) do
      table.insert(choices, i .. '. ' .. vim.fn.fnamemodify(session, ':t'))
    end
    
    vim.ui.select(choices, { prompt = 'セッション選択:' }, function(choice)
      if choice then
        local idx = tonumber(choice:match('^%d+'))
        if idx and sessions[idx] then
          local file = io.open(sessions[idx], 'r')
          if file then
            local content = file:read('*all')
            file:close()
            local qflist = vim.fn.json_decode(content)
            vim.fn.setqflist(qflist)
            vim.cmd('copen')
            print('QuickFixセッション復元: ' .. vim.fn.fnamemodify(sessions[idx], ':t'))
          end
        end
      end
    end)
  end, { desc = 'QuickFixセッション復元' })
  
  -- ===== 統計・情報 =====
  vim.keymap.set('n', '<leader>qi', function()
    local qflist = vim.fn.getqflist()
    local files = {}
    for _, item in ipairs(qflist) do
      local filename = vim.fn.bufname(item.bufnr)
      files[filename] = (files[filename] or 0) + 1
    end
    
    print('QuickFix統計:')
    print('  総件数: ' .. #qflist)
    print('  ファイル数: ' .. vim.tbl_count(files))
    for file, count in pairs(files) do
      print('  ' .. vim.fn.fnamemodify(file, ':t') .. ': ' .. count .. '件')
    end
  end, { desc = 'QuickFix統計表示' })
end

-- AutoCommand設定
local function setup_quickfix_autocmds()
  local group = vim.api.nvim_create_augroup("QuickFixEnhanced", { clear = true })
  
  -- QuickFixウィンドウでのローカルキーマップ
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "qf",
    callback = function()
      local opts = { buffer = true }
      
      -- エンターでジャンプ後、QuickFixにフォーカスを戻す
      vim.keymap.set('n', '<CR>', '<CR><C-w>p', opts)
      vim.keymap.set('n', 'o', '<CR><C-w>p', opts)
      
      -- エントリ削除
      vim.keymap.set('n', 'dd', function()
        local line = vim.fn.line('.')
        local qflist = vim.fn.getqflist()
        table.remove(qflist, line)
        vim.fn.setqflist(qflist, 'r')
      end, opts)
      
      -- 範囲削除
      vim.keymap.set('v', 'd', function()
        local start_line = vim.fn.line("'<")
        local end_line = vim.fn.line("'>")
        local qflist = vim.fn.getqflist()
        
        for i = end_line, start_line, -1 do
          table.remove(qflist, i)
        end
        vim.fn.setqflist(qflist, 'r')
      end, opts)
      
      -- プレビュー
      vim.keymap.set('n', 'p', '<CR><C-w>p', opts)
      
      -- 分割オープン
      vim.keymap.set('n', 's', '<C-w><CR><C-w>K', opts)
      vim.keymap.set('n', 'v', '<C-w><CR><C-w>H<C-w>b<C-w>J<C-w>t', opts)
      
      -- タブオープン
      vim.keymap.set('n', 't', '<C-w><CR><C-w>T', opts)
      
      -- QuickFixウィンドウのステータスライン
      vim.opt_local.statusline = '📋 QuickFix [%l/%L] %t'
    end,
  })
  
  -- QuickFixオープン時のウィンドウ調整
  vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    group = group,
    pattern = "*",
    callback = function()
      -- 自動サイズ調整（最小5行、最大15行）
      local qflist = vim.fn.getqflist()
      local height = math.max(5, math.min(15, #qflist))
      vim.cmd('copen ' .. height)
    end,
  })
  
  -- LocationListオープン時の調整
  vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    group = group,
    pattern = "l*",
    callback = function()
      local loclist = vim.fn.getloclist(0)
      local height = math.max(3, math.min(10, #loclist))
      vim.cmd('lopen ' .. height)
    end,
  })
end

-- 初期化関数
local function init()
  setup_quickfix_keymaps()
  setup_quickfix_autocmds()
  
  -- which-keyグループ名追加
  if pcall(require, 'which-key') then
    require('which-key').add({
      { "<leader>q", group = "📋 QuickFix操作" },
      { "<leader>l", group = "📍 LocationList" },
    })
  end
end

-- 実行
init()

return {
  setup_quickfix_keymaps = setup_quickfix_keymaps,
  setup_quickfix_autocmds = setup_quickfix_autocmds,
}
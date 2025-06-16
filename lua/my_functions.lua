local my_functions = {}

function my_functions.my_function1()
    -- ここに処理を記述
    print("my_function1を実行しました")
end

function my_functions.my_function2()
    -- ここに処理を記述
    print("my_function2を実行しました")
end

-- QuickFixウィンドウを確実に最下部に配置する関数
function my_functions.ensure_quickfix_bottom()
    -- QuickFixウィンドウを探す
    local qf_win = nil
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_buf_get_option(buf, 'buftype') == 'quickfix' then
            qf_win = win
            break
        end
    end
    
    if qf_win then
        -- 現在のウィンドウを保存
        local current_win = vim.api.nvim_get_current_win()
        
        -- QuickFixウィンドウにフォーカス
        vim.api.nvim_set_current_win(qf_win)
        
        -- 最下部に移動
        vim.cmd("wincmd J")
        
        -- ウィンドウサイズを調整
        local qflist = vim.fn.getqflist()
        local height = math.max(5, math.min(15, #qflist))
        vim.api.nvim_win_set_height(qf_win, height)
        
        -- 元のウィンドウに戻る
        if vim.api.nvim_win_is_valid(current_win) then
            vim.api.nvim_set_current_win(current_win)
        end
        
        return true
    end
    
    return false
end

-- QuickFixを開く安全な関数
function my_functions.safe_copen(height)
    height = height or ""
    vim.cmd("botright copen " .. height)
    vim.defer_fn(function()
        my_functions.ensure_quickfix_bottom()
    end, 50)
end

return my_functions


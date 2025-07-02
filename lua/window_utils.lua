----------------------------------------------------------------------------------------------------
--- ウィンドウ操作ユーティリティ関数
----------------------------------------------------------------------------------------------------

local M = {}

-- ウィンドウ幅調整（絶対的な位置基準）- 左側拡張
function M.expand_left()
  -- 現在のウィンドウが左端かどうかチェック
  local current_win = vim.api.nvim_get_current_win()
  vim.cmd("wincmd h") -- 左に移動を試す
  local after_win = vim.api.nvim_get_current_win()
  
  if current_win == after_win then
    -- 左に移動できない = 左端のウィンドウ
    vim.cmd("vertical resize -2") -- 左に縮小
  else
    -- 左に移動できた = 右側のウィンドウ
    vim.cmd("wincmd l") -- 元の位置に戻る
    vim.cmd("vertical resize +2") -- 左に拡張（右側を縮小）
  end
end

-- ウィンドウ幅調整（絶対的な位置基準）- 右側拡張
function M.expand_right()
  -- 現在のウィンドウが右端かどうかチェック
  local current_win = vim.api.nvim_get_current_win()
  vim.cmd("wincmd l") -- 右に移動を試す
  local after_win = vim.api.nvim_get_current_win()
  
  if current_win == after_win then
    -- 右に移動できない = 右端のウィンドウ
    vim.cmd("vertical resize -2") -- 右に縮小
  else
    -- 右に移動できた = 左側のウィンドウ
    vim.cmd("wincmd h") -- 元の位置に戻る
    vim.cmd("vertical resize +2") -- 右に拡張（左側を縮小）
  end
end

return M
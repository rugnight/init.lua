----------------------------------------------------------------------------------------------------
--- 診断・情報表示ユーティリティ関数
----------------------------------------------------------------------------------------------------

local M = {}

-- メッセージをバッファで開く関数  
function M.open_messages_in_buffer()
  -- 新しいバッファを作成
  vim.cmd('enew')
  -- バッファタイプを設定
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.swapfile = false
  -- バッファ名を設定
  vim.api.nvim_buf_set_name(0, '[Messages]')
  
  -- メッセージを安全にキャプチャ
  local ok, messages = pcall(vim.fn.execute, 'messages')
  if not ok then
    messages = "メッセージの取得でエラーが発生しました: " .. tostring(messages)
  end
  
  local lines = vim.split(messages, '\n')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  
  -- 読み取り専用に設定
  vim.bo.readonly = true
  vim.bo.modifiable = false
  -- カーソルを最下部に移動
  vim.cmd('normal! G')
end

-- LSP情報をバッファで開く関数
function M.open_lsp_info_in_buffer()
  vim.cmd('enew')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.swapfile = false
  vim.api.nvim_buf_set_name(0, '[LSP Info]')
  
  local lsp_info = vim.fn.execute('LspInfo')
  local lines = vim.split(lsp_info, '\n')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  
  vim.bo.readonly = true
  vim.bo.modifiable = false
  vim.cmd('normal! gg')
end

-- Lazy情報をバッファで開く関数
function M.open_lazy_profile_in_buffer()
  vim.cmd('enew')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.swapfile = false
  vim.api.nvim_buf_set_name(0, '[Lazy Profile]')
  
  -- Lazy.nvimのプロファイル情報を取得
  local ok, lazy = pcall(require, 'lazy')
  if ok then
    local profile = lazy.profile()
    local lines = {}
    table.insert(lines, "=== Lazy.nvim Plugin Load Times ===")
    table.insert(lines, "")
    for name, data in pairs(profile) do
      table.insert(lines, string.format("%s: %.2fms", name, data.time or 0))
    end
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  else
    vim.api.nvim_buf_set_lines(0, 0, -1, false, {"Lazy.nvim not available"})
  end
  
  vim.bo.readonly = true
  vim.bo.modifiable = false
  vim.cmd('normal! gg')
end

return M
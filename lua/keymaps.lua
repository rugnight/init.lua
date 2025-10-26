----------------------------------------------------------------------------------------------------
--- キーマップ設定
----------------------------------------------------------------------------------------------------

-- 診断・情報表示関数を読み込み
local diagnostic_utils = require('diagnostic_utils')
local window_utils = require('window_utils')
local quickfix_utils = require('quickfix_utils')

-- 設定編集のショートカット
vim.keymap.set("n", "<Leader>ic", ":edit $MYVIMRC<CR>", { desc="⚙️ 設定ファイル編集" })
vim.keymap.set("n", "<Leader>ir", ":source $MYVIMRC<CR>", { desc="⚙️ 設定再読込" })
vim.keymap.set("n", "<Leader>ip", ":Telescope find_files cwd=~/.config/nvim/lua<CR>", { desc="⚙️ プラグイン設定" })

-- メッセージ表示のキーマップ（nvim-notify対応）
vim.keymap.set("n", "<Leader>im", function()
  local ok, notify = pcall(require, "notify")
  if ok and notify.print_history then
    -- nvim-notifyの履歴を表示
    pcall(notify.print_history)
  else
    -- フォールバック：従来のメッセージ表示
    pcall(diagnostic_utils.open_messages_in_buffer)
  end
end, { desc="⚙️ メッセージ履歴表示" })

vim.keymap.set("n", "<Leader>ih", ":checkhealth<CR>", { desc="⚙️ ヘルスチェック" })
vim.keymap.set("n", "<Leader>il", function() pcall(diagnostic_utils.open_lsp_info_in_buffer) end, { desc="⚙️ LSP情報をバッファで開く" })
vim.keymap.set("n", "<Leader>iz", function() pcall(diagnostic_utils.open_lazy_profile_in_buffer) end, { desc="⚙️ Lazy Profile情報" })

-- より安全な代替コマンド
vim.keymap.set("n", "<Leader>iM", ":messages<CR>", { desc="⚙️ 従来のメッセージ表示" })
vim.keymap.set("n", "<Leader>iL", ":LspInfo<CR>", { desc="⚙️ LSP情報表示" })

-- 基本的なキーマップ
vim.keymap.set("n", "<Leader>bn", ":bnext<CR>", { desc = "📋 次のバッファ" })
vim.keymap.set("n", "<Leader>bp", ":bprev<CR>", { desc = "📋 前のバッファ" })

-- 検索ハイライトを簡単に消す
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "検索ハイライト解除", silent = true })

-- 統一ESCキー（全モードで一貫性）
vim.keymap.set("i", "<C-,>", "<Esc>", { desc = "統一ESC（Ctrl+,）", noremap = true, silent = true })
vim.keymap.set("t", "<C-,>", "<C-\\><C-n>", { desc = "統一ESC（Ctrl+,）", noremap = true, silent = true })

-- ウィンドウ移動を矢印キーで統一（全モード対応）
vim.keymap.set("n", "<Left>", "<C-w>h", { desc = "左のウィンドウへ移動", noremap = true, silent = true })
vim.keymap.set("n", "<Down>", "<C-w>j", { desc = "下のウィンドウへ移動", noremap = true, silent = true })
vim.keymap.set("n", "<Up>", "<C-w>k", { desc = "上のウィンドウへ移動", noremap = true, silent = true })
vim.keymap.set("n", "<Right>", "<C-w>l", { desc = "右のウィンドウへ移動", noremap = true, silent = true })

-- インサートモードでも同じ矢印キーでウィンドウ移動
vim.keymap.set("i", "<Left>", "<C-o><C-w>h", { desc = "左のウィンドウへ移動", noremap = true, silent = true })
vim.keymap.set("i", "<Down>", "<C-o><C-w>j", { desc = "下のウィンドウへ移動", noremap = true, silent = true })
vim.keymap.set("i", "<Up>", "<C-o><C-w>k", { desc = "上のウィンドウへ移動", noremap = true, silent = true })
vim.keymap.set("i", "<Right>", "<C-o><C-w>l", { desc = "右のウィンドウへ移動", noremap = true, silent = true })

-- ターミナルモードでも同じ矢印キーでウィンドウ移動（移動後のモード調整付き）
vim.keymap.set("t", "<Left>", function()
  vim.cmd("wincmd h")
  -- 移動先がターミナルバッファの場合、自動的にインサートモードに入る
  vim.schedule(function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end)
end, { desc = "左のウィンドウへ移動", noremap = true, silent = true })

vim.keymap.set("t", "<Down>", function()
  vim.cmd("wincmd j")
  vim.schedule(function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end)
end, { desc = "下のウィンドウへ移動", noremap = true, silent = true })

vim.keymap.set("t", "<Up>", function()
  vim.cmd("wincmd k")
  vim.schedule(function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end)
end, { desc = "上のウィンドウへ移動", noremap = true, silent = true })

vim.keymap.set("t", "<Right>", function()
  vim.cmd("wincmd l")
  vim.schedule(function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end)
end, { desc = "右のウィンドウへ移動", noremap = true, silent = true })

-- ウィンドウサイズ調整はCtrl+矢印キーに変更
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "ウィンドウ高さ増加", silent = true })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "ウィンドウ高さ減少", silent = true })
vim.keymap.set("n", "<C-Left>", window_utils.expand_left, { desc = "左側を拡張", silent = true })
vim.keymap.set("n", "<C-Right>", window_utils.expand_right, { desc = "右側を拡張", silent = true })

-- インデント調整（ビジュアルモードで選択を保持）
vim.keymap.set("v", "<", "<gv", { desc = "インデント減少（選択保持）" })
vim.keymap.set("v", ">", ">gv", { desc = "インデント増加（選択保持）" })


-- 行移動（ビジュアルモード）
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "選択行を下に移動", silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "選択行を上に移動", silent = true })

-- 表示/UIトグル機能をvカテゴリに追加
vim.keymap.set("n", "<Leader>vf", "za", { desc = "👁️ 折りたたみトグル" })
vim.keymap.set("n", "<Leader>vF", "zA", { desc = "👁️ 再帰的折りたたみトグル" })

-- QuickFix関連キーマップとautocmdを設定
quickfix_utils.setup_keymaps()
quickfix_utils.setup_autocmds()

----------------------------------------------------------------------------------------------------
--- LSP & 補完 キーマップ
----------------------------------------------------------------------------------------------------

-- Neovim 0.11のデフォルトキーマップを活用
-- 以下のキーマップが標準で利用可能：
-- grn: リネーム
-- grr: 参照検索
-- gri: 実装へ移動
-- gra: コードアクション
-- gd: 定義へ移動
-- K: ホバー
-- [d, ]d: 診断ナビゲーション

-- 追加の診断キーマップ
vim.keymap.set('n', '<leader>xd', vim.diagnostic.open_float, { desc = "🚨 診断フロート表示" })

-- 補完メニューの見た目改善
vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#3c3836', fg = '#ebdbb2' })
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#458588', fg = '#ebdbb2' })
vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = '#665c54' })
vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = '#a89984' })


local fn = vim.fn

vim.loader.enable()

--- GLOBALS ---
HOME_PATH = vim.fn.expand("$HOME")
CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")
TERMINAL = vim.fn.expand("$TERMINAL")

-- カスタム関数を読み込み
MY_FUNCTIONS = require('my_functions')

-- マシン名（遅延読み込み）
local hostname
local function get_hostname()
  if not hostname then
    hostname = vim.fn.substitute(vim.fn.system('hostname'), '\n', '', '')
  end
  return hostname
end

-- WSLのシェルを使用（一般的なWSL環境）
vim.opt.shell = "bash"
vim.opt.shellcmdflag = "-c"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""


vim.g.mapleader = ";"    -- リーダーキーを設定
vim.g.maplocalleader = "," -- ローカルリーダーキー設定
vim.opt.number = true    -- 行番号表示
vim.opt.relativenumber = true -- 相対行番号で効率的移動
vim.opt.signcolumn = "yes:2" -- サインカラムを常に2文字幅で固定表示
vim.opt.scrolloff = 3    -- 画面端で常に指定数の余裕を持ってスクロールする
vim.opt.sidescrolloff = 8 -- 水平スクロール時の余裕
vim.opt.showmode = false -- 現在のModeを表示しない
vim.o.mouse = "a"        -- マウス操作を有効に
vim.opt.cursorline = true -- カーソル行をハイライト
vim.opt.wrap = false     -- 行の折り返しを無効
vim.opt.linebreak = true -- 折り返し時に単語で区切る

-- ポップアップ表示
vim.opt.pumheight = 10 -- ポップアップ表示の高さ
-- vim.opt.pumblend  = 75 -- ポップアップ表示の透過

-- フローティングウィンドウ
vim.opt.winblend = 0 -- FloatingWindowの透過を無効化（背景を明確に表示）

-- Tab
vim.o.tabstop = 4      -- Tab幅を指定のスペース数に
vim.o.softtabstop = 4  -- more tab is 4 spaces config
vim.o.shiftwidth = 4   -- Shift >> したときのインデントスペース数
-- vim.o.expandtab = true -- タブをスペースに変換する
-- vim.o.smartindent = true -- 字下げ設定、Linterを使うのでもう不要かな？

-- 検索
vim.o.ignorecase = true -- 検索で大文字小文字を無視する
vim.o.smartcase = true  -- ignorecase 指定時に大文字入力するとignorecaseを無効化して検索する
vim.o.incsearch = true  -- インクリメンタルサーチを有効に
vim.o.hlsearch = true -- 検索語をハイライトする
vim.opt.grepprg = "rg --vimgrep --smart-case --follow --hidden" -- ripgrepを使用
vim.opt.grepformat = "%f:%l:%c:%m"

-- エンコーディング
vim.opt.fileencoding = "utf-8" -- 書き込むときのエンコーディング

-- クリップボード
vim.opt.clipboard = "unnamedplus"

-- システムが自動生成するファイル関連
vim.opt.swapfile = false                -- creates a swapfile
vim.opt.backup = false                  -- creates a backup file
vim.opt.writebackup = false             -- バックアップファイルを作成しない
vim.opt.undodir = CACHE_PATH .. "/undo" -- set an undo directory
vim.opt.undofile = true                 -- enable persistent undo
vim.opt.updatetime = 250                -- CursorHoldイベントの間隔（ミリ秒）
vim.opt.timeoutlen = 400                -- キーマップのタイムアウト

-- 折り畳み設定
--vim.o.foldmethod = 'marker'
vim.o.foldenable = true
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

-- mark情報等の保存: AppData\Local\nvim-data\shada
vim.o.shada = "!,'100,<50,s10,h"

-- フォント（遅延設定）
-- https://github.com/yuru7/HackGen
-- WindowsTerminal側の設定もしましょう
vim.defer_fn(function()
  local current_hostname = get_hostname()
  if current_hostname == "GPD" then
    vim.o.guifont = "HackGen Console NF:h12"
  elseif current_hostname == "OMEN" then
    vim.o.guifont = "HackGen Console NF:h12"
  else
    vim.o.guifont = "HackGen Console NF:h12"
  end
end, 100)

-- ブラウザのパスを指定
vim.g.openerprio = {
    'xdg-open',  -- Linuxの場合
    'open',      -- macOSの場合
    'start',     -- Windowsの場合
    'wslview',   -- Windows Subsystem for Linux (WSL) の場合
}

-- {{{ 不要なビルトインプラグインを無効化
local disabled_plugins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "matchparen",
    "spec",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_plugins) do
  vim.g["loaded_" .. plugin] = 1
end
--- }}}

-- 設定編集のショートカット
--vim.keymap.set("n", "<C-,>i", ":edit ~/.config/nvim/init.lua<CR>",   { desc="init.luaを開く" })
--vim.keymap.set("n", "<C-,>s", ":source ~/.config/nvim/init.lua<CR>", { desc="init.lua再読込" })
--vim.keymap.set("n", "<C-,>p", ":FZF ~/.config/nvim/lua<CR>",         { desc="plugin設定" })
vim.keymap.set("n", "<Leader>ic", ":edit $MYVIMRC<CR>", { desc="⚙️ 設定ファイル編集" })
vim.keymap.set("n", "<Leader>ir", ":source $MYVIMRC<CR>", { desc="⚙️ 設定再読込" })
vim.keymap.set("n", "<Leader>ip", ":Telescope find_files cwd=~/.config/nvim/lua<CR>", { desc="⚙️ プラグイン設定" })

-- メッセージをバッファで開く関数
local function open_messages_in_buffer()
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
local function open_lsp_info_in_buffer()
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
local function open_lazy_profile_in_buffer()
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

-- メッセージ表示のキーマップ（nvim-notify対応）
vim.keymap.set("n", "<Leader>im", function()
  local ok, notify = pcall(require, "notify")
  if ok and notify.print_history then
    -- nvim-notifyの履歴を表示
    pcall(notify.print_history)
  else
    -- フォールバック：従来のメッセージ表示
    pcall(open_messages_in_buffer)
  end
end, { desc="⚙️ メッセージ履歴表示" })
vim.keymap.set("n", "<Leader>ih", ":checkhealth<CR>", { desc="⚙️ ヘルスチェック" })
vim.keymap.set("n", "<Leader>il", function() pcall(open_lsp_info_in_buffer) end, { desc="⚙️ LSP情報をバッファで開く" })
vim.keymap.set("n", "<Leader>iz", function() pcall(open_lazy_profile_in_buffer) end, { desc="⚙️ Lazy Profile情報" })

-- より安全な代替コマンド
vim.keymap.set("n", "<Leader>iM", ":messages<CR>", { desc="⚙️ 従来のメッセージ表示" })
vim.keymap.set("n", "<Leader>iL", ":LspInfo<CR>", { desc="⚙️ LSP情報表示" })

-- 非推奨API警告を抑制
vim.deprecate = function() end

-- 基本的なキーマップ
vim.keymap.set("n", "<Leader>;", "<C-^>", { desc = "📋 直前のバッファと切替" })
vim.keymap.set("n", "<Leader>bn", ":bnext<CR>", { desc = "📋 次のバッファ" })
vim.keymap.set("n", "<Leader>bp", ":bprev<CR>", { desc = "📋 前のバッファ" })

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

-- 検索結果をQuickFixに
vim.keymap.set("n", "<Leader>qg", function()
  local pattern = vim.fn.input("Grep pattern: ")
  if pattern ~= "" then
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
end, { desc = "🔍 Grep→QuickFix" })

vim.keymap.set("n", "<Leader>qG", function()
  local pattern = vim.fn.expand("<cword>")
  if pattern ~= "" then
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
end, { desc = "🔍 カーソル下Grep→QuickFix" })

-- バッファローカル検索
vim.keymap.set("n", "<Leader>qb", function()
  local pattern = vim.fn.input("Buffer grep pattern: ")
  if pattern ~= "" then
    vim.cmd("silent vimgrep /" .. pattern .. "/j %")
    MY_FUNCTIONS.safe_copen()
  end
end, { desc = "🔍 バッファ内検索→QuickFix" })

-- TODOコメント検索
vim.keymap.set("n", "<Leader>qt", function()
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
end, { desc = "🔍 TODO検索→QuickFix" })

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
vim.keymap.set("n", "<Leader>qR", function()
  -- QuickFixリストからの一括置換
  local old_pattern = vim.fn.input("Replace pattern: ")
  if old_pattern == "" then return end
  local new_pattern = vim.fn.input("Replace with: ")
  if new_pattern == "" then return end
  
  vim.cmd("cfdo %s/" .. vim.fn.escape(old_pattern, "/") .. "/" .. vim.fn.escape(new_pattern, "/") .. "/gc | update")
end, { desc = "📋 QuickFix一括置換" })

vim.keymap.set("n", "<Leader>qS", function()
  -- QuickFixセッション保存
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
end, { desc = "📋 QuickFixセッション保存" })

vim.keymap.set("n", "<Leader>qL", function()
  -- QuickFixセッション復元
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
end, { desc = "📋 QuickFixセッション復元" })

-- LocationList vs QuickFix使い分け
vim.keymap.set("n", "<Leader>qm", function()
  -- QuickFixからLocationListに移動（現在のウィンドウ用）
  local qflist = vim.fn.getqflist()
  if not vim.tbl_isempty(qflist) then
    vim.fn.setloclist(0, qflist)
    vim.cmd("lopen")
    print("QuickFix → LocationList移動完了")
  end
end, { desc = "📋 QuickFix→LocationList" })

vim.keymap.set("n", "<Leader>qM", function()
  -- LocationListからQuickFixに移動（グローバル化）
  local loclist = vim.fn.getloclist(0)
  if not vim.tbl_isempty(loclist) then
    vim.fn.setqflist(loclist)
    MY_FUNCTIONS.safe_copen()
    print("LocationList → QuickFix移動完了")
  end
end, { desc = "📋 LocationList→QuickFix" })

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

-- 検索ハイライトを簡単に消す
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "検索ハイライト解除", silent = true })

-- ウィンドウ移動を簡単に
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "左のウィンドウへ移動", noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "下のウィンドウへ移動", noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "上のウィンドウへ移動", noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "右のウィンドウへ移動", noremap = true, silent = true })

-- ウィンドウサイズ調整（絶対的な位置基準）
-- 高さ調整は従来通り
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "ウィンドウ高さ増加", silent = true })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "ウィンドウ高さ減少", silent = true })

-- 幅調整は絶対的な位置基準
vim.keymap.set("n", "<C-Left>", function()
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
end, { desc = "左側を拡張", silent = true })

vim.keymap.set("n", "<C-Right>", function()
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
end, { desc = "右側を拡張", silent = true })

-- インデント調整（ビジュアルモードで選択を保持）
vim.keymap.set("v", "<", "<gv", { desc = "インデント減少（選択保持）" })
vim.keymap.set("v", ">", ">gv", { desc = "インデント増加（選択保持）" })

-- 行移動（ビジュアルモード）
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "選択行を下に移動", silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "選択行を上に移動", silent = true })

-- ToggleTerm を使用したターミナル操作
vim.keymap.set("n", "<Leader>tt", "<cmd>ToggleTerm<cr>", { desc = "🖥️ ターミナルトグル" })
vim.keymap.set("n", "<Leader>tf", function()
  if _G.toggle_terminal_at_file_dir then
    _G.toggle_terminal_at_file_dir()
  else
    vim.notify("ToggleTerm plugin not loaded yet", vim.log.levels.WARN)
  end
end, { desc = "🖥️ 現在ファイル位置でターミナル" })

vim.keymap.set("n", "<Leader>tp", function()
  if _G.toggle_terminal_at_project_root then
    _G.toggle_terminal_at_project_root()
  else
    vim.notify("ToggleTerm plugin not loaded yet", vim.log.levels.WARN)
  end
end, { desc = "🖥️ プロジェクトルートでターミナル" })

vim.keymap.set("n", "<Leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", { desc = "🖥️ 水平ターミナル" })
vim.keymap.set("n", "<Leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "🖥️ 垂直ターミナル" })

-- 表示/UIトグル機能をvカテゴリに追加
vim.keymap.set("n", "<Leader>vf", "za", { desc = "👁️ 折りたたみトグル" })
vim.keymap.set("n", "<Leader>vF", "zA", { desc = "👁️ 再帰的折りたたみトグル" })

-- require("plugins")
require("ime")
require("plugins_setup")
require("filetype_keymaps")

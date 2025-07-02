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


-- 非推奨API警告を抑制
vim.deprecate = function() end


-- プラグインとキーマップ読み込み
require("ime")
require("plugins_setup")
require("filetype_keymaps")
require("keymaps")

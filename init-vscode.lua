-- VSCode-Neovim専用設定
-- VSCode内でNeovimを使用する際の軽量化設定
-- 🔍 設定確認: :lua print("VSCode専用 init-vscode.lua 読み込み完了 - " .. vim.fn.stdpath("config") .. "/init-vscode.lua")

local fn = vim.fn

-- VSCode環境判定
if not vim.g.vscode then
  return
end

vim.loader.enable()

--- GLOBALS ---
HOME_PATH = vim.fn.expand("$HOME")
CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

-- 共通設定を読み込み
require('common_config')

-- カスタム関数を読み込み
MY_FUNCTIONS = require('my_functions')

-- 基本設定
vim.g.mapleader = ";"
vim.g.maplocalleader = ","

-- VSCode連携用の軽量設定
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false

-- Tab設定
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- 検索設定
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true

-- クリップボード
vim.opt.clipboard = "unnamedplus"

-- システムファイル設定
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undodir = CACHE_PATH .. "/undo"
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400

-- 折り畳み設定（軽量版）
vim.o.foldenable = true
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

-- 不要なビルトインプラグインを無効化
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

-- 非推奨API警告を抑制
vim.deprecate = function() end

-- VSCode専用プラグインとキーマップ読み込み
require("vscode_plugins_setup")
require("vscode_keymaps")

-- 環境判別コマンド
vim.api.nvim_create_user_command('Env', function() print("📱 VSCode-Neovim環境") end, {})
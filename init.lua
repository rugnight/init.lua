local fn = vim.fn

vim.loader.enable()

--- GLOBALS ---
HOME_PATH = vim.fn.expand("$HOME")
CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")
TERMINAL = vim.fn.expand("$TERMINAL")

-- マシン名
hostname = vim.fn.substitute(vim.fn.system('hostname'), '\n', '', '')

-- vim.opt.shell = "powershell"

vim.g.mapleader = ";"    -- リーダーキーを設定
vim.opt.number = true    -- 行番号表示
vim.opt.scrolloff = 3    -- 画面端で常に指定数の余裕を持ってスクロールする
vim.opt.showmode = false -- 現在のModeを表示しない
vim.o.mouse = "a"        -- マウス操作を有効に

-- ポップアップ表示
vim.opt.pumheight = 10 -- ポップアップ表示の高さ
-- vim.opt.pumblend  = 75 -- ポップアップ表示の透過

-- フローティングウィンドウ
vim.opt.winblend = 10 -- FloatingWindowの透過

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

-- エンコーディング
vim.opt.fileencoding = "utf-8" -- 書き込むときのエンコーディング

-- クリップボード
vim.opt.clipboard = "unnamedplus"

-- システムが自動生成するファイル関連
vim.opt.swapfile = false                -- creates a swapfile
vim.opt.backup = false                  -- creates a backup file
vim.opt.undodir = CACHE_PATH .. "/undo" -- set an undo directory
vim.opt.undofile = true                 -- enable persistent undo

-- 折り畳み設定
vim.o.foldenable = true
vim.o.foldmethod = 'marker'

-- フォント
if hostname == "GPD" then
    vim.opt.guifont = "Cica:h12"
elseif hostname == "OMEN" then
    vim.opt.guifont = "Cica:h11"
else
    vim.opt.guifont = "Cica:h10"
end

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
--- }}}

-- 設定編集のショートカット
vim.keymap.set("n", "<C-,>i", ":edit ~/.config/nvim/init.lua<CR>",   { desc="init.luaを開く" })
vim.keymap.set("n", "<C-,>s", ":source ~/.config/nvim/init.lua<CR>", { desc="init.lua再読込" })
vim.keymap.set("n", "<C-,>p", ":FZF ~/.config/nvim/lua<CR>",         { desc="plugin設定" })

vim.keymap.set("n",    "<Leader>;", "<C-^>",                                  { desc = "直前のバッファと切替"} )
vim.keymap.set("n",    "<C-j>",     ":bprev<CR>",                             { desc = ""} )
vim.keymap.set("n",    "<C-k>",     ":bnext<CR>",                             { desc = ""} )
-- vim.keymap.set("n", "<C-w>",     ":bdelete<CR>",                           { desc = ""} )

-- require("plugins")
require("plugins_setup")


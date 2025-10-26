-- 共通設定ファイル
-- Neovimの基本設定

-- エンコーディング
vim.opt.fileencoding = "utf-8"

-- 基本UI設定
vim.opt.signcolumn = "yes:2" -- サインカラムを常に2文字幅で固定表示
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 8
vim.opt.showmode = false
vim.o.mouse = "a"
vim.opt.linebreak = true

-- ポップアップ設定
vim.opt.pumheight = 10

-- フローティングウィンドウ
vim.opt.winblend = 0


-- mark情報等の保存
vim.o.shada = "!,'100,<50,s10,h"

-- ブラウザのパスを指定
vim.g.openerprio = {
    'xdg-open',  -- Linuxの場合
    'open',      -- macOSの場合
    'start',     -- Windowsの場合
    'wslview',   -- WSL の場合
}

-- WSLのシェル設定（環境に応じて調整）
if vim.fn.has('win32') == 0 and vim.fn.has('wsl') == 1 then
    vim.opt.shell = "bash"
    vim.opt.shellcmdflag = "-c"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
end

-- ripgrep設定
vim.opt.grepprg = "rg --vimgrep --smart-case --follow --hidden"
vim.opt.grepformat = "%f:%l:%c:%m"
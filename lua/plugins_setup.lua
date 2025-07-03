-- Neovim専用プラグインマネージャー
-- https://github.com/folke/lazy.nvim

-- VSCode環境では実行しない
if vim.g.vscode then
  return
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvimでプラグインを管理
require("lazy").setup({
  -- 'plugins.common'と'plugins.neovim'ディレクトリ内の.luaファイルを自動で読み込む
  { import = "plugins.common" },
  { import = "plugins.neovim" },
}, {
  defaults = { lazy = true },  -- デフォルトで遅延読み込み
  ui = {
    border = "rounded",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  rocks = { enabled = false },  -- luarocksを無効化
})

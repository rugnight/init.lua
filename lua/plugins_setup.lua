-- Neovim専用プラグインマネージャー
-- https://eiji.page/blog/neovim-lazy-nvim-intro/

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

-- プラグイン読み込み関数
local function load_plugin_configs(plugin_dir)
  local config_dir = CONFIG_PATH .. "/lua/plugins/" .. plugin_dir
  local files = vim.fn.glob(config_dir .. "/*.lua", false, true)
  
  local plugins = {}
  for _, file in ipairs(files) do
    local plugin_name = vim.fn.fnamemodify(file, ":t:r")
    if plugin_name ~= "init" then -- init.luaは除外
      local ok, plugin_config = pcall(require, "plugins." .. plugin_dir .. "." .. plugin_name)
      if ok and plugin_config then
        if type(plugin_config) == "table" then
          table.insert(plugins, plugin_config)
        end
      end
    end
  end
  
  return plugins
end

-- プラグイン設定の読み込み
local all_plugins = {}

-- 共通プラグインを読み込み
local common_plugins = load_plugin_configs("common")
vim.list_extend(all_plugins, common_plugins)

-- Neovim専用プラグインを読み込み
local neovim_plugins = load_plugin_configs("neovim")
vim.list_extend(all_plugins, neovim_plugins)

-- lazy.nvimでプラグインを管理（新しい構造のみ使用）
require("lazy").setup(all_plugins, {
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

--------------------------------------------------
--- カラースキーム
--------------------------------------------------
return {
  "ellisonleao/gruvbox.nvim",  -- 別実装のGruvbox
  lazy = false,
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      contrast = "soft",
      palette_overrides = {
        light0 = "#e5d8c8",  -- 通常の背景色よりやや暗く
      },
      overrides = {
        -- 特定の構文要素をカスタマイズ
      }
    })
    vim.opt.background = "light"
    vim.cmd("colorscheme gruvbox")
  end,
}

-- return {
-- 	"cocopon/iceberg.vim",
-- 	config = function() 
-- 		vim.cmd("colorscheme iceberg")
-- 		vim.opt.background = "light"
-- 	end,
-- }

--return {
--	"sainnhe/gruvbox-material",
--	config = function()
--        vim.g.gruvbox_material_enable_italic = true
--        vim.cmd.colorscheme('gruvbox-material')
--		vim.opt.background = "light"
--
--		-- バックグラウンドの明るさを'soft'に設定（'hard', 'medium', 'soft'の3段階）
--		vim.g.gruvbox_material_background = 'hard'  -- より暗い背景
--		-- カラーパレットも調整可能（'material', 'mix', 'original'）
--		vim.g.gruvbox_material_foreground = 'original'
--		-- コントラスト設定
--		vim.g.gruvbox_material_better_performance = 1
--	end,
--}

-- return {
--   "ellisonleao/gruvbox.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("gruvbox").setup({
--       contrast = "soft",
--       palette_overrides = {
--         -- 背景色をさらに暗く設定
--         light0 = "#d5c8b8",  -- 暗めの背景色
--         light1 = "#c9bcac",  -- さらに暗いコントラスト要素用
--         light2 = "#bdafa0",  -- さらに暗い背景要素用
--       },
--       overrides = {
--         -- 特定の要素をカスタマイズして読みやすさを向上
--         Comment = { fg = "#7c6f64", italic = true },  -- コメントを少し濃く
--         LineNr = { fg = "#a89984" },  -- 行番号をより読みやすく
--       },
--       dim_inactive = false,
--       transparent_mode = false,
--     })
--     
--     vim.opt.background = "light"
--     vim.cmd("colorscheme gruvbox")
--     
--     -- カラースキーム適用後に追加調整（必要に応じて）
--     vim.cmd([[
--       " エディタ全体の背景色
--       highlight Normal guibg=#d5c8b8
--       " UI要素の背景色
--       highlight StatusLine guibg=#bdafa0 guifg=#3c3836
--       highlight StatusLineNC guibg=#c9bcac guifg=#7c6f64
--       " フロートウィンドウのカラー
--       highlight NormalFloat guibg=#c9bcac
--       " ポップアップメニュー
--       highlight Pmenu guibg=#c9bcac guifg=#3c3836
--     ]])
--   end,
-- }

--return {
--"sainnhe/gruvbox-material",
--lazy = false,
--priority = 1000,
--config = function()
--  -- バックグラウンドの明るさを設定
--  vim.g.gruvbox_material_background = 'soft'
--  vim.g.gruvbox_material_foreground = 'material'
--  vim.g.gruvbox_material_enable_italic = 1
--  vim.g.gruvbox_material_better_performance = 1
--  
--  -- ライトテーマを使用
--  vim.opt.background = "light"
--  
--  -- カラースキーム適用
--  vim.cmd("colorscheme gruvbox-material")
--  
--  -- カラースキーム適用後に背景色をさらに暗いベージュに調整
--  vim.cmd([[
--	" メインの背景色をより暗いベージュに
--	highlight Normal guibg=#e1d2c0
--	" フロートウィンドウとUI要素
--	highlight NormalFloat guibg=#e1d2c0
--	highlight NormalNC guibg=#dfd0be
--	" サイドバーやUI要素の背景色
--	highlight SignColumn guibg=#e1d2c0
--	highlight Pmenu guibg=#daccb9
--  ]])
--end,
--}

--------------------------------------------------
--- カラースキーム
--------------------------------------------------
return {
  "ellisonleao/gruvbox.nvim",  -- 別実装のGruvbox
  lazy = false,
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      contrast = "hard",  -- より強いコントラスト
      palette_overrides = {
        light0 = "#d5c4a1",  -- 背景画像との調和を重視した濃いベージュ
        light1 = "#c9b99a",  -- UI要素用のより濃い色
        light2 = "#bdae93",  -- さらに濃いアクセント色
      },
      transparent_mode = false,  -- 透明化を無効にして背景をしっかり表示
      overrides = {
        -- 特定の構文要素をカスタマイズ
      }
    })
    vim.opt.background = "light"
    vim.cmd("colorscheme gruvbox")
    
    -- 実行環境による背景設定の切り替え
    local is_gui = vim.fn.has('gui_running') == 1 or vim.g.neovide or vim.g.fvim
    local is_nvim_qt = vim.env.NVIM_GUI ~= nil or vim.fn.exists('g:GuiLoaded') == 1
    
    if is_gui or is_nvim_qt then
      -- nvim-qt など GUI環境での設定（落ち着いたベージュ）
      vim.cmd([[
        " GUI環境では落ち着いたベージュを使用
        highlight Normal guibg=#e5d8c8
        highlight NonText guibg=#e5d8c8
        highlight NormalNC guibg=#ddd0c0
        highlight NormalSB guibg=#ddd0c0
        highlight StatusLine guibg=#d5c4a1 gui=bold
        highlight StatusLineNC guibg=#c9b99a
        highlight LineNr guibg=#e5d8c8 guifg=#7c6f64
        highlight SignColumn guibg=#e5d8c8
        highlight Pmenu guibg=#ddd0c0 guifg=#3c3836
        highlight PmenuSel guibg=#d5c4a1 guifg=#282828
        highlight NormalFloat guibg=#ddd0c0
      ]])
    else
      -- Windows Terminal など端末環境での設定（透過背景）
      vim.cmd([[
        highlight Normal guibg=none
        highlight NonText guibg=none
        highlight Normal ctermbg=none
        highlight NonText ctermbg=none
        highlight NormalNC guibg=none
        highlight NormalSB guibg=none
        
        " 視認性向上のため重要なUI要素に半透明背景を追加
        highlight StatusLine guibg=#bdae93 gui=bold
        highlight StatusLineNC guibg=#a89984
        highlight LineNr guibg=#d5c4a180 guifg=#7c6f64
        highlight SignColumn guibg=#d5c4a180
        highlight Pmenu guibg=#c9b99ae0 guifg=#3c3836
        highlight PmenuSel guibg=#bdae93 guifg=#282828
        highlight NormalFloat guibg=#c9b99ae8
      ]])
    end
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

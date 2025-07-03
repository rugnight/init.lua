--------------------------------------------------
--- カラースキーム（Neovim専用 - ベージュ系）
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
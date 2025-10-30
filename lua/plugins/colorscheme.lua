--------------------------------------------------
--- カラースキーム（Neovim専用 - Windows Terminal Solarized Dark風）
--------------------------------------------------
return {
  -- maxmx03/solarized.nvim - Windows Terminal Solarized Dark最適化
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 999,
    enabled = false, -- 無効化（切り替え用）
    config = function()
      -- GUI環境（neovim-qt等）とTUI環境で設定を分ける
      local is_gui = vim.fn.has('gui_running') == 1 or vim.env.NVIM_GUI ~= nil
      
      -- 明示的にダークモード設定
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
      
      require("solarized").setup({
        variant = "winter",      -- Windows Terminal風の variant
        transparent = {
          enabled = not is_gui,  -- GUIでは透明度無効、TUIでは有効
          pmenu = false,         -- ポップアップメニューは不透明
          normal = not is_gui,   -- 通常背景の透明度
          normalfloat = false,   -- フローティングウィンドウは不透明
          neotree = not is_gui,  -- ファイルツリーの透明度
          nvimtree = not is_gui, -- nvim-treeの透明度
          wf = false,            -- wf.nvimは不透明
          telescope = false,     -- telescopeは不透明
          lazy = false,          -- lazyは不透明
        },
        styles = {
          comments = { italic = true },
          functions = {},
          variables = {},
          numbers = {},
          constants = {},
          parameters = {},
          keywords = {},
          types = {},
        },
        plugins = {
          treesitter = true,
          lspconfig = true,
          telescope = true,
          declare_diagnostic = true,
          native_lsp = true,
        },
      })
      
      -- ダークテーマを確実に適用
      vim.cmd("colorscheme solarized")
    end,
  },
  
  -- NeoSolarized（メイン使用）
  {
    "Tsuzat/NeoSolarized.nvim",
    lazy = false,
    priority = 1000,
    enabled = true, -- 有効化（メイン使用）
    config = function()
      vim.opt.background = "dark"
      local is_gui = vim.fn.has('gui_running') == 1 or vim.env.NVIM_GUI ~= nil
      
      require("NeoSolarized").setup({
        style = "dark",
        transparent = not is_gui,
        terminal_colors = true,
        enable_italics = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = false },
        },
      })
      vim.cmd("colorscheme NeoSolarized")
      
      if is_gui then
        -- neovim-qtで背景色が正しく表示されるように設定
        vim.cmd("highlight Normal guibg=#002b36")  -- Solarized dark background
        vim.cmd("highlight NonText guibg=#002b36")
        vim.cmd("highlight SignColumn guibg=#002b36")
        vim.cmd("highlight EndOfBuffer guibg=#002b36")
      end
    end,
  },
  
  -- Everforest（バックアップ・切り替え用）
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 999,
    enabled = false, -- 無効化（切り替え用）
    config = function()
      require("everforest").setup({
        background = "dark",
        style = "hard",
        transparent_background_level = 0,
        dim_inactive_windows = false,
        diagnostic_text_highlight = true,
        diagnostic_virtual_text = "coloured",
      })
      vim.opt.background = "dark"
      vim.cmd("colorscheme everforest")
    end,
  }
}

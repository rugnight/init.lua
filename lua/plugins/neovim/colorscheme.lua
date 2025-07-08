--------------------------------------------------
--- カラースキーム（Neovim専用 - ベージュ系）
--------------------------------------------------
return {
  -- Everforest - Desert/Solarized系の上品な配色
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    enabled = true, -- 切り替え用（trueで有効化）
    config = function()
      require("everforest").setup({
        background = "dark",
        style = "hard", -- light/medium/hard
        transparent_background_level = 0,
        dim_inactive_windows = false,
        diagnostic_text_highlight = true,
        diagnostic_virtual_text = "coloured",
        on_highlights = function(hl, palette)
          -- 予約語の視認性を大幅に向上
          hl.Keyword = { fg = palette.red, bold = true }           -- if, for, while等
          hl.Conditional = { fg = palette.orange, bold = true }    -- if, else, switch等
          hl.Repeat = { fg = palette.orange, bold = true }         -- for, while, do等
          hl.Statement = { fg = palette.red, bold = true }         -- return, break等
          hl.StorageClass = { fg = palette.purple, bold = true }   -- static, const等
          hl.Type = { fg = palette.yellow, bold = true }           -- int, string等
          hl.Structure = { fg = palette.purple, bold = true }      -- struct, class等
          hl.Typedef = { fg = palette.purple, bold = true }        -- typedef等
          hl.Exception = { fg = palette.red, bold = true }         -- try, catch等
          hl.Include = { fg = palette.blue, bold = true }          -- import, include等
          hl.Define = { fg = palette.aqua, bold = true }           -- define, macro等
          hl.Macro = { fg = palette.aqua, bold = true }            -- マクロ
          hl.PreProc = { fg = palette.aqua, bold = true }          -- プリプロセッサ
          hl.PreCondit = { fg = palette.aqua, bold = true }        -- #if, #ifdef等
          
          -- 関数名も強調
          hl.Function = { fg = palette.green, bold = true }        -- 関数名
          hl.Identifier = { fg = palette.blue }                    -- 変数名
          
          -- 文字列と数値
          hl.String = { fg = palette.green }                       -- 文字列
          hl.Number = { fg = palette.purple }                      -- 数値
          hl.Boolean = { fg = palette.red, bold = true }           -- true, false
          hl.Constant = { fg = palette.purple, bold = true }       -- 定数
        end,
      })
      vim.opt.background = "dark"
      vim.cmd("colorscheme everforest")
    end,
  }
}

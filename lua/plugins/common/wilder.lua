return {
  "gelguy/wilder.nvim",
  keys = {
    ":",
    "/",
    "?",
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    { "romgrk/fzy-lua-native", build = "make" },
  },
  config = function()
    local wilder = require("wilder")
    
    wilder.setup({
      modes = { ":", "/", "?" },
      next_key = "<Tab>",
      previous_key = "<S-Tab>",
      accept_key = "<CR>",
      reject_key = "<Esc>",
    })
    
    -- 美しいポップアップ設定
    wilder.set_option("renderer", wilder.popupmenu_renderer(
      wilder.popupmenu_border_theme({
        highlights = {
          border = "FloatBorder",
          default = "Pmenu",
          selected = "PmenuSel",
          accent = wilder.make_hl("WilderAccent", "Pmenu", {{ a = 1 }, { a = 1 }, { foreground = "#f4468f" }}),
        },
        border = "rounded",
        max_height = "30%",
        min_height = 0,
        prompt_position = "top",
        reverse = 0,
        -- 左側にアイコン表示
        left = {
          " ",
          wilder.popupmenu_devicons(),
          wilder.popupmenu_buffer_flags({
            flags = " a + ",
            icons = { ["+"] = "", a = "" },
          }),
        },
        right = {
          " ",
          wilder.popupmenu_scrollbar(),
        },
      })
    ))
    
    -- シンプルで確実なパイプライン設定
    wilder.set_option("pipeline", {
      wilder.branch(
        -- コマンドライン補完（:s、:eなど）
        wilder.cmdline_pipeline({
          language = 'vim',
          fuzzy = 1,
        }),
        -- 検索モード補完
        wilder.search_pipeline({
          fuzzy = 1,
        }),
        -- 置換・ファイル補完
        wilder.substitute_pipeline({
          pipeline = wilder.vim_search_pipeline({
            fuzzy = 1,
          }),
        })
      ),
    })
    
    -- アクセントカラーの設定
    vim.api.nvim_set_hl(0, "WilderAccent", { fg = "#f4468f" })
  end,
}
--------------------------------------------------
--- カラースキーム（VSCode専用 - 青系）
--------------------------------------------------
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "day", -- day, storm, night, moon
      light_style = "day",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
        functions = {},
        variables = {},
        sidebars = "normal",
        floats = "normal",
      },
      sidebars = { "qf", "vista_kind", "terminal", "packer" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,
      on_colors = function(colors)
        -- VSCode専用：明確に青系の配色
        colors.bg = "#e9f2ff"  -- 薄い青背景
        colors.bg_sidebar = "#dde8f5"
        colors.bg_statusline = "#c7d6eb"
      end,
      on_highlights = function(highlights, colors)
        -- VSCode環境では青系統で統一
        highlights.StatusLine = { bg = colors.bg_statusline, fg = colors.fg }
        highlights.Normal = { bg = colors.bg, fg = colors.fg }
      end,
    })
    
    vim.opt.background = "light"
    vim.cmd("colorscheme tokyonight-day")
  end,
}
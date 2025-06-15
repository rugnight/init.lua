return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<Leader>e", "<cmd>NvimTreeToggle<CR>", desc = "ファイルツリー切替" },
  },
  config = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
        side = "left",
        preserve_window_proportions = true,
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        icons = {
          show = {
            git = true,
            file = true,
            folder = true,
            folder_arrow = true,
          },
        },
      },
      filters = {
        dotfiles = false, -- .dotfilesも表示
        custom = { "^.git$" }, -- .gitディレクトリは非表示
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 500,
      },
      actions = {
        open_file = {
          quit_on_open = false, -- ファイル開いてもツリーを閉じない
          resize_window = true,
        },
      },
      update_focused_file = {
        enable = true, -- アクティブファイルに追従
        update_root = false,
      },
    })

  end,
}
return {
  {
    "kevinhwang91/nvim-bqf",
    event = "QuickFixCmdPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "junegunn/fzf",
    },
    opts = {
      auto_enable = true,
      auto_resize_height = true,
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border_chars = { "┃", "━", "┏", "┓", "┗", "┛", "┣", "┫", "┳", "┻" },
      },
      func_map = {
        vsplit = "",
        ptogglemode = "z,",
        stoggleup = "",
      },
      filter = {
        fzf = {
          action_for = { ["ctrl-s"] = "split" },
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
        },
      },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      -- QuickFix統合キーマップ
      { "<leader>qx", "<cmd>Trouble diagnostics toggle<cr>", desc = "診断一覧(Trouble)" },
      { "<leader>qX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "バッファ診断(Trouble)" },
      { "<leader>qs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "シンボル一覧(Trouble)" },
      { "<leader>qr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP参照(Trouble)" },
      { "<leader>qL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List(Trouble)" },
      { "<leader>qQ", "<cmd>Trouble qflist toggle<cr>", desc = "QuickFix List(Trouble)" },
    },
  },
}
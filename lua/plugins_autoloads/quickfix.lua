return {
  {
    "kevinhwang91/nvim-bqf",
    event = "QuickFixCmdPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      auto_enable = true,
      auto_resize_height = true,
      preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border_chars = { "┃", "━", "┏", "┓", "┗", "┛", "┣", "┫", "┳", "┻" },
        should_preview_cb = function(bufnr, qwinid)
          local ret = true
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          if fsize > 100 * 1024 then
            ret = false
          end
          return ret
        end,
      },
      func_map = {
        open = "<CR>",
        vsplit = "v",
        split = "s", 
        tab = "t",
        tabb = "T",
        tabc = "<C-t>",
        ptogglemode = "zp",
        pscrollup = "<C-u>",
        pscrolldown = "<C-d>",
      },
      filter = {
        fzf = {
          action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab" },
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "❯ " },
        },
      },
    },
  },
  {
    "stevearc/quicker.nvim",
    event = "QuickFixCmdPost",
    opts = {
      -- 編集機能を有効化
      edit = {
        enabled = true,
        autosave = true,
      },
      -- 表示設定
      show = {
        context = 3,
        current_line = true,
        line_numbers = true,
      },
      -- ハイライト
      highlight = {
        treesitter = true,
        lsp = true,
      },
      -- キーマップ
      keys = {
        {
          ">",
          function()
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
          end,
          desc = "コンテキスト拡張",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "コンテキスト縮小",
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
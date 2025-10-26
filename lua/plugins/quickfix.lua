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
      -- QuickFixウィンドウの位置制御
      opts = {
        number = true,
        relativenumber = false,
        signcolumn = "auto",
        winfixheight = true,
        wrap = false,
      },
      -- キーマップ
      keys = {
        {
          ">",
          function()
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
          end,
          desc = "📋 コンテキスト拡張",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "📋 コンテキスト縮小",
        },
      },
    },
    config = function(_, opts)
      require("quicker").setup(opts)
      
      -- QuickFixが開いた際の位置調整
      vim.api.nvim_create_autocmd("QuickFixCmdPost", {
        group = vim.api.nvim_create_augroup("QuickFixPosition", { clear = true }),
        callback = function()
          vim.defer_fn(function()
            -- QuickFixを常に画面最下部に強制配置
            vim.cmd("botright copen")
            
            -- 念のため追加の位置調整
            local qf_win = nil
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.api.nvim_buf_get_option(buf, 'buftype') == 'quickfix' then
                qf_win = win
                break
              end
            end
            
            if qf_win then
              vim.api.nvim_set_current_win(qf_win)
              vim.cmd("wincmd J") -- 最下部に強制移動
              
              -- ウィンドウ高さを調整
              local qflist = vim.fn.getqflist()
              local height = math.max(5, math.min(15, #qflist))
              vim.api.nvim_win_set_height(qf_win, height)
            end
          end, 100)
        end,
      })
      
      -- copenコマンドを強制的にbotright copenに置き換え
      vim.api.nvim_create_user_command("Copen", function(opts)
        vim.cmd("botright copen " .. (opts.args or ""))
      end, { nargs = "?" })
      
      -- 既存のcopenの動作をオーバーライド
      vim.keymap.set('n', '<cmd>copen<cr>', '<cmd>botright copen<cr>', { noremap = true, silent = true })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      -- QuickFix統合キーマップ
      { "<leader>qx", "<cmd>Trouble diagnostics toggle<cr>", desc = "🚨 診断一覧" },
      { "<leader>qX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "🚨 バッファ診断" },
      { "<leader>qs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "📋 シンボル一覧" },
      { "<leader>qr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "📋 LSP参照" },
      { "<leader>qL", "<cmd>Trouble loclist toggle<cr>", desc = "📋 Location List" },
      { "<leader>qQ", "<cmd>Trouble qflist toggle<cr>", desc = "📋 QuickFix List" },
    },
  },
}
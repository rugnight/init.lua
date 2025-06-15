return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    -- 主要LSP機能（lspsaga中心）
    { "<Leader>lf", "<cmd>Lspsaga finder<CR>", desc = "参照・定義検索" },
    { "<Leader>lr", "<cmd>Lspsaga finder ref<CR>", desc = "参照一覧" },
    { "<Leader>lR", function()
        vim.lsp.buf.references()
        vim.defer_fn(function() vim.cmd("copen") end, 100)
      end, desc = "参照一覧（quickfix）" },
    { "<Leader>l;", function() 
        -- 標準のquickfixリストを表示（LSP参照結果がある場合）
        if not vim.tbl_isempty(vim.fn.getqflist()) then
          vim.cmd("copen")
        else
          -- quickfixが空の場合は再度finder実行
          vim.cmd("Lspsaga finder")
        end
      end, desc = "前回の参照結果再表示" },
    { "<Leader>ld", "<cmd>Lspsaga goto_definition<CR>", desc = "定義へ移動" },
    { "<Leader>lp", "<cmd>Lspsaga peek_definition<CR>", desc = "定義プレビュー" },
    { "<Leader>lh", "<cmd>Lspsaga hover_doc<CR>", desc = "ホバー情報" },
    { "<Leader>ln", "<cmd>Lspsaga rename<CR>", desc = "リネーム" },
    { "<Leader>la", "<cmd>Lspsaga code_action<CR>", desc = "コードアクション" },
    { "<Leader>lo", "<cmd>Lspsaga outline<CR>", desc = "アウトライン" },
    { "<Leader>ls", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "行診断表示" },
    { "<Leader>lF", function() vim.lsp.buf.format({ async = true }) end, desc = "コードフォーマット" },
  },
  config = function()
    require("lspsaga").setup({
      ui = {
        border = "rounded",
        devicon = true,
        title = true,
        code_action = "💡",
      },
      hover = {
        max_width = 0.9,
        max_height = 0.8,
      },
      finder = {
        max_height = 0.4,
        left_width = 0.4,
        right_width = 0.4,
        default = "ref+def+imp",
        layout = "float",
        sp_inexist = false,
        sp_global = false,
        ly_botright = true,
        keys = {
          edit = "o",
          vsplit = "s",
          split = "i", 
          tabe = "t",
          quit = "q",
          close_in_preview = "<C-c>",
        },
      },
      outline = {
        win_position = "right",
        win_width = 30,
        auto_preview = true,
        auto_refresh = true,
        custom_sort = nil,
        layout = "normal", -- 通常ウィンドウで表示
        keys = {
          toggle_or_jump = "o",
          quit = "q",
          jump = "e",
        },
      },
      rename = {
        in_select = true,
        auto_save = false,
        keys = {
          quit = "<C-c>",
          exec = "<CR>",
        },
      },
      code_action = {
        num_shortcut = true,
        show_server_name = false,
        keys = {
          quit = "q",
          exec = "<CR>",
        },
      },
      -- パフォーマンス重視で無効化
      symbol_in_winbar = { enable = false },
      beacon = { enable = false },
    })
  end,
}
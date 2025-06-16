return {
  "Eutrius/Otree.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<Leader>e", function()
        -- プロジェクトルートを検出
        local function find_project_root()
          local root_patterns = { '.git', '*.csproj', '*.sln', 'package.json', 'Cargo.toml', 'pom.xml', 'init.lua' }
          local current_dir = vim.fn.expand('%:p:h') or vim.fn.getcwd()
          
          local function find_root(path)
            for _, pattern in ipairs(root_patterns) do
              if vim.fn.glob(path .. '/' .. pattern) ~= '' then
                return path
              end
            end
            local parent = vim.fn.fnamemodify(path, ':h')
            if parent ~= path then
              return find_root(parent)
            end
            return nil
          end
          
          return find_root(current_dir)
        end
        
        local project_root = find_project_root()
        local current_cwd = vim.fn.getcwd()
        
        -- 編集バッファから開く場合は常にプロジェクトチェック
        local current_buf_type = vim.api.nvim_buf_get_option(0, 'filetype')
        local force_refresh = current_buf_type ~= 'Otree'
        
        -- プロジェクトルートが変更されている、または編集バッファから開く場合
        if (project_root and project_root ~= current_cwd) or force_refresh then
          -- 既存のOtreeバッファを削除してから変更
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local buf_name = vim.api.nvim_buf_get_name(buf)
            if buf_name:match('Otree') or vim.api.nvim_buf_get_option(buf, 'filetype') == 'Otree' then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end
          if project_root then
            vim.cmd('cd ' .. vim.fn.fnameescape(project_root))
          end
        end
        
        vim.cmd('Otree')
        
        
      end, desc = "📁 ファイルツリー切替" },
  },
  config = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("Otree").setup({
      win_size = 30,
      hijack_netrw = true,
      oil = "float", -- oil.nvim連携
      git = {
        enable = false, -- 大きなプロジェクトでのパフォーマンス改善
      },
      filters = {
        dotfiles = false,
        custom = { ".git", "node_modules", ".DS_Store" },
      },
      -- デフォルトキーマップを無効化してウィンドウ移動キーとの競合を解消
      use_default_keymaps = false,
      keymaps = {
        -- 基本ナビゲーション
        ["<CR>"] = "actions.select",
        ["l"] = "actions.select",
        ["h"] = "actions.parent_dir",
        ["<Right>"] = "actions.goto_dir",
        ["<Left>"] = "actions.parent_dir",
        -- ファイル操作
        ["o"] = "actions.open_in_oil",
        ["O"] = "actions.open_in_oil_float",
        ["r"] = "actions.refresh",
        ["f"] = "actions.focus_file",
        ["."] = "actions.toggle_hidden",
        ["q"] = "actions.close",  -- qキーで閉じる
        ["<Esc>"] = "actions.close", -- Escキーでも閉じる
        -- ファイル管理
        ["R"] = "actions.rename",
        ["a"] = "actions.create",
        ["d"] = "actions.delete",
        ["x"] = "actions.cut",
        ["c"] = "actions.copy",
        ["p"] = "actions.paste",
        ["y"] = "actions.copy_name",
        ["Y"] = "actions.copy_path",
        ["<C-r>"] = "actions.refresh",
      },
    })

  end,
}
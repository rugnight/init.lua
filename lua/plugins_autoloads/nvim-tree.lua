return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<Leader>e", function()
        -- プロジェクトルートを検出してnvim-treeを開く
        local function find_project_root()
          local root_patterns = { '.git', '*.csproj', '*.sln', 'package.json', 'Cargo.toml', 'pom.xml', 'init.lua' }
          local current_dir = vim.fn.expand('%:p:h') or vim.fn.getcwd()
          
          -- 現在のディレクトリから上向きに検索
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
        if project_root then
          -- プロジェクトルートに移動してからnvim-treeを開く
          vim.cmd('cd ' .. vim.fn.fnameescape(project_root))
        end
        vim.cmd('NvimTreeToggle')
      end, desc = "ファイルツリー切替（プロジェクトルート）" },
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
        update_root = true, -- ルート更新を有効化
      },
      update_cwd = true, -- 現在作業ディレクトリを自動更新
      respect_buf_cwd = true, -- バッファの作業ディレクトリを尊重
    })

  end,
}
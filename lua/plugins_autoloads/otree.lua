return {
  "Eutrius/Otree.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<Leader>e", function()
        -- プロジェクトルートを検出してOtreeを開く
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
          -- プロジェクトルートに移動してからOtreeを開く
          vim.cmd('cd ' .. vim.fn.fnameescape(project_root))
        end
        vim.cmd('Otree')
      end, desc = "ファイルツリー切替（プロジェクトルート）" },
  },
  config = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("Otree").setup({
      win_size = 30,
      hijack_netrw = true,
      oil = "float", -- oil.nvim連携
    })

  end,
}
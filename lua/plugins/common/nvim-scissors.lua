return {
  "chrisgrieser/nvim-scissors",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "L3MON4D3/LuaSnip",
  },
  keys = {
    -- スニペット追加（現在の位置にスニペット作成）
    { "<Leader>sa", function()
      if _G.safe_scissors_add then
        _G.safe_scissors_add()
      else
        -- filetypeを一時的に設定してから実行
        local current_ft = vim.bo.filetype
        if current_ft == "" then
          vim.bo.filetype = "lua"
        end
        require("scissors").addNewSnippet()
      end
    end, desc = "📝 スニペット追加", mode = {"n", "v"} },
  },
  config = function()
    require("scissors").setup({
      -- Telescope設定
      snippetDir = vim.fn.stdpath("config") .. "/luasnippets",
      editSnippetPopup = {
        height = 0.4,
        width = 0.6,
        border = "rounded",
      },
      -- JSON自動整形
      jsonFormatter = "jq", -- または "yq" 
    })
    
    -- filetype不足時の対応関数
    local function safe_scissors_action(action_func)
      return function()
        local current_ft = vim.bo.filetype
        
        -- filetypeが空の場合、一時的にluaに設定
        if current_ft == "" or current_ft == "TelescopePrompt" then
          vim.bo.filetype = "lua"
          action_func()
          -- 元に戻す（必要に応じて）
          vim.defer_fn(function()
            if current_ft ~= "" and current_ft ~= "TelescopePrompt" then
              vim.bo.filetype = current_ft
            end
          end, 1000)
        else
          action_func()
        end
      end
    end
    
    -- セーフティラッパー付きのグローバル関数を作成
    _G.safe_scissors_edit = safe_scissors_action(function()
      require("scissors").editSnippet()
    end)
    
    _G.safe_scissors_add = safe_scissors_action(function()
      require("scissors").addNewSnippet()
    end)
  end,
}
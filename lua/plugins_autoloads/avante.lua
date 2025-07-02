return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  keys = {
    { "<leader>aa", mode = { "n", "v" }, desc = "🤖 AI質問" },
    { "<leader>ae", mode = { "n", "v" }, desc = "🤖 AI編集" },
    { "<leader>ar", desc = "🤖 AI更新" },
    { "<leader>ad", desc = "🤖 AIデバッグ切替" },
    { "<leader>ah", desc = "🤖 AIヒント切替" },
    { "<leader>as", desc = "🤖 AIサイドバー切替" },
  },
  opts = {
    provider = "openai", -- 使用するAIプロバイダを指定
    --provider = "gemini",
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4o", -- 使用したいモデルを指定
      timeout = 30000,
      temperature = 0.7,
      max_tokens = 1024,
    },
    gemini = {
      endpoint = "https://generativelanguage.googleapis.com/v1beta",
	  --endpoint = "https://generativelanguage.googleapis.com",
      --model = "models/gemini-pro", -- または gemini-pro-vision など
	  model = "gemini-2.0-flash",
      timeout = 30000,
      temperature = 0.7,
      max_tokens = 2048, -- Gemini側に制限あり（OpenAIより少なめ）
    },
    mappings = {
      ask = "<leader>aa",
      edit = "<leader>ae",
      refresh = "<leader>ar",
      toggle = {
        debug = "<leader>ad",
        hint = "<leader>ah",
        sidebar = "<leader>as",
      },
    },
  },
  -- 環境別ビルド設定
  build = function()
    -- WSL環境ではビルドをスキップ
    if vim.fn.has("wsl") == 1 or os.getenv("WSL_DISTRO_NAME") then
      return
    end
    
    -- Windows環境ではPowerShellビルド
    if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
      return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    end
    
    -- その他Unix系環境ではmakeビルド
    return "make"
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
}

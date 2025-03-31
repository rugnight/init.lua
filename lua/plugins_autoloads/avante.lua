return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
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
  },
  --build = "make",
  build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
}

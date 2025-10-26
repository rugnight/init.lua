return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = "VeryLazy",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- メソッド関連（mのみ）
            ["am"] = { "@function.outer", desc = "メソッド全体" },
            ["im"] = { "@function.inner", desc = "メソッド内部" },
            ["ac"] = { "@class.outer", desc = "クラス全体" },
            ["ic"] = { "@class.inner", desc = "クラス内部" },
            -- パラメータ
            ["aa"] = { "@parameter.outer", desc = "パラメータ全体" },
            ["ia"] = { "@parameter.inner", desc = "パラメータ内部" },
            -- ブロック
            ["ab"] = { "@block.outer", desc = "ブロック全体" },
            ["ib"] = { "@block.inner", desc = "ブロック内部" },
            -- 条件文
            ["ai"] = { "@conditional.outer", desc = "条件文全体" },
            ["ii"] = { "@conditional.inner", desc = "条件文内部" },
            -- ループ
            ["al"] = { "@loop.outer", desc = "ループ全体" },
            ["il"] = { "@loop.inner", desc = "ループ内部" },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = { "@function.outer", desc = "次のメソッド" },
            ["]c"] = { "@class.outer", desc = "次のクラス" },
            ["]i"] = { "@conditional.outer", desc = "次の条件文" },
            ["]l"] = { "@loop.outer", desc = "次のループ" },
          },
          goto_next_end = {
            ["]M"] = { "@function.outer", desc = "次のメソッド末尾" },
            ["]C"] = { "@class.outer", desc = "次のクラス末尾" },
          },
          goto_previous_start = {
            ["[m"] = { "@function.outer", desc = "前のメソッド" },
            ["[c"] = { "@class.outer", desc = "前のクラス" },
            ["[i"] = { "@conditional.outer", desc = "前の条件文" },
            ["[l"] = { "@loop.outer", desc = "前のループ" },
          },
          goto_previous_end = {
            ["[M"] = { "@function.outer", desc = "前のメソッド末尾" },
            ["[C"] = { "@class.outer", desc = "前のクラス末尾" },
          },
        },
      },
    })
  end,
}
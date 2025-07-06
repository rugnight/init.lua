local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Neovim Plugin定義
  s("plugin", fmt([[
    return {{
      "{}",
      {}config = function()
        {}
      end,
    }}
  ]], {
    i(1, "plugin/name"),
    c(2, {
      t(""),
      t("lazy = true,\n  "),
      t("event = \"VeryLazy\",\n  "),
      t("keys = {\"<Leader>x\"},\n  "),
    }),
    i(3, "-- 設定"),
  })),

  -- Keymap定義
  s("keymap", fmt([[
    vim.keymap.set("{}", "{}", {}, {{ desc = "{}" }})
  ]], {
    c(1, { t("n"), t("i"), t("v"), t("x") }),
    i(2, "<Leader>x"),
    c(3, {
      i(nil, "function"),
      fmt('"{}"', { i(1, "command") }),
      fmt('<cmd>{}<cr>', { i(1, "Command") }),
    }),
    i(4, "説明"),
  })),

  -- Lua function
  s("func", fmt([[
    local function {}({})
      {}
    end
  ]], {
    i(1, "function_name"),
    i(2, "args"),
    i(3, "-- body"),
  })),

  -- Require
  s("req", fmt([[
    local {} = require("{}")
  ]], {
    f(function(args)
      local module = args[1][1]
      if module then
        return module:match("([^.]+)$") or module
      end
      return "module"
    end, {1}),
    i(1, "module"),
  })),

  -- Debug print
  s("print", fmt([[
    print("{}: " .. vim.inspect({}))
  ]], {
    i(1, "DEBUG"),
    i(2, "variable"),
  })),

  -- Hello (既存)
  s("hi", {
    t('println("Hello World!")')
  }),
}

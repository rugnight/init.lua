-- ここではhelloと入力するとprintln("Hello World!")と補完できるスニペットを作成します
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    s("hello", {
        t('println("Hello World!")')
    }),
    s("test", {
        t("This is a test snippet")
    }),
    s("func", {
        t("function "), i(1, "name"), t("("), i(2, "args"), t(") {"),
        t({"", "  "}), i(3, "body"),
        t({"", "}"})
    }),
}


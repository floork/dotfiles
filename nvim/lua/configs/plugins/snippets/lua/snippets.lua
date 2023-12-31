local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt

------------------------------------------------------------------------------------------
-- ======== add snipets here ========
------------------------------------------------------------------------------------------

-- Config snippet
local config_snippet = s(
  "config",
  fmt(
    [[
config = function()

end,
]],
    {}
  )
)

------------------------------------------------------------------------------------------
-- ======== Lua snippets ========
------------------------------------------------------------------------------------------

local lua_snippets = {
  config_snippet,
}

return lua_snippets

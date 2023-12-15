return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  config = function()
    local ls = require("luasnip")
    local lua_snips = require("configs.plugins.snippets.lua_snippets")

    ls.add_snippets("lua", lua_snips)
  end,
}

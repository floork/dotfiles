return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  config = function()
    -- local ls = require("luasnip")

    -- Define the luasnip snippet for "config"
    -- ls.snippets["lua"] = {
    --   config = ls.parser.parse_snippet({
    --     "config = function()",
    --     "  $0",
    --     "end,",
    --   }),
    -- }
  end,
}

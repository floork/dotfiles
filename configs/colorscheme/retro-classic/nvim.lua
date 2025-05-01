local M = {}

-- Base palette from terminal colors
local palette = {
  black       = "#1c1c1c", -- index 0
  red         = "#d72638", -- index 1
  green       = "#3fb950", -- index 2
  orange      = "#f19d1a", -- index 3
  blue        = "#1e90ff", -- index 4
  purple      = "#a960d2", -- index 5
  cyan        = "#39c5cf", -- index 6
  silver      = "#d3d3d3", -- index 7
  gray        = "#4e4e4e", -- index 8
  brightRed   = "#ff6e6e", -- index 9
  brightGreen = "#5ffb83", -- index 10
  yellow      = "#ffd966", -- index 11
  lightBlue   = "#87bfff", -- index 12
  magenta     = "#d68fff", -- index 13
  aqua        = "#73efff", -- index 14
  white       = "#ffffff", -- index 15

  -- Additional colors (non-palette)
  bg          = "#2b2b2b",
  fg          = "#e5d27a",
  cursor      = "#ffffff",
  cursorText  = "#000000",
  selBg       = "#44475a",
  selFg       = "#f8f8f2",

  -- Additional shades for better UI
  bgDarker    = "#252525",
  bgLighter   = "#333333",
  subtle      = "#3a3a3a",
}

local function set_highlights()
  local hl = vim.api.nvim_set_hl
  local none = "NONE"

  -- Editor UI
  hl(0, "Normal", { fg = palette.fg, bg = palette.bg })
  hl(0, "NormalFloat", { fg = palette.fg, bg = palette.bgDarker })
  hl(0, "Cursor", { fg = palette.cursorText, bg = palette.cursor })
  hl(0, "CursorLine", { bg = palette.bgLighter })
  hl(0, "CursorLineNr", { fg = palette.yellow, bg = none, bold = true })
  hl(0, "LineNr", { fg = palette.gray, bg = none })
  hl(0, "SignColumn", { fg = palette.gray, bg = none })
  hl(0, "ColorColumn", { bg = palette.bgDarker })
  hl(0, "Conceal", { fg = palette.gray })
  hl(0, "EndOfBuffer", { fg = palette.gray })

  -- Gutter
  hl(0, "Folded", { fg = palette.silver, bg = palette.bgDarker, italic = true })
  hl(0, "FoldColumn", { fg = palette.gray, bg = none })

  -- Selection
  hl(0, "Visual", { bg = palette.selBg, fg = palette.selFg })
  hl(0, "VisualNOS", { bg = palette.selBg, fg = palette.selFg })
  hl(0, "Search", { fg = palette.black, bg = palette.yellow, bold = true })
  hl(0, "IncSearch", { fg = palette.black, bg = palette.orange, bold = true })
  hl(0, "CurSearch", { fg = palette.black, bg = palette.green, bold = true })

  -- Windows, tabs, and splits
  hl(0, "VertSplit", { fg = palette.subtle, bg = none })
  hl(0, "TabLine", { fg = palette.silver, bg = palette.bgDarker })
  hl(0, "TabLineFill", { fg = palette.silver, bg = palette.bgDarker })
  hl(0, "TabLineSel", { fg = palette.yellow, bg = palette.bg, bold = true })
  hl(0, "Title", { fg = palette.orange, bold = true })

  -- Status line (matching tmux style)
  hl(0, "StatusLine", { fg = palette.yellow, bg = palette.bg, bold = true })
  hl(0, "StatusLineNC", { fg = palette.silver, bg = palette.bgDarker })
  hl(0, "WinBar", { fg = palette.green, bg = none, bold = true })
  hl(0, "WinBarNC", { fg = palette.silver, bg = none })

  -- Completion menu
  hl(0, "Pmenu", { fg = palette.fg, bg = palette.bgDarker })
  hl(0, "PmenuSel", { fg = palette.black, bg = palette.orange, bold = true })
  hl(0, "PmenuSbar", { bg = palette.bgLighter })
  hl(0, "PmenuThumb", { bg = palette.gray })

  -- Messages and prompts
  hl(0, "ErrorMsg", { fg = palette.brightRed, bold = true })
  hl(0, "WarningMsg", { fg = palette.orange, bold = true })
  hl(0, "MoreMsg", { fg = palette.green })
  hl(0, "Question", { fg = palette.blue })
  hl(0, "Directory", { fg = palette.blue })

  -- Diff highlighting
  hl(0, "DiffAdd", { fg = palette.green, bg = palette.bgDarker })
  hl(0, "DiffChange", { fg = palette.yellow, bg = palette.bgDarker })
  hl(0, "DiffDelete", { fg = palette.red, bg = palette.bgDarker })
  hl(0, "DiffText", { fg = palette.blue, bg = palette.bgDarker, bold = true })

  -- Syntax highlighting
  hl(0, "Comment", { fg = palette.silver, italic = true })
  hl(0, "Constant", { fg = palette.green })
  hl(0, "String", { fg = palette.brightGreen })
  hl(0, "Character", { fg = palette.brightGreen })
  hl(0, "Number", { fg = palette.cyan })
  hl(0, "Boolean", { fg = palette.cyan, bold = true })
  hl(0, "Float", { fg = palette.cyan })

  hl(0, "Identifier", { fg = palette.yellow })
  hl(0, "Function", { fg = palette.blue, bold = true })

  hl(0, "Statement", { fg = palette.orange, bold = true })
  hl(0, "Conditional", { fg = palette.orange, bold = true })
  hl(0, "Repeat", { fg = palette.orange, bold = true })
  hl(0, "Label", { fg = palette.orange })
  hl(0, "Operator", { fg = palette.red })
  hl(0, "Keyword", { fg = palette.purple, bold = true })
  hl(0, "Exception", { fg = palette.red, bold = true })

  hl(0, "PreProc", { fg = palette.purple })
  hl(0, "Include", { fg = palette.purple, bold = true })
  hl(0, "Define", { fg = palette.purple })
  hl(0, "Macro", { fg = palette.purple })
  hl(0, "PreCondit", { fg = palette.purple, italic = true })

  hl(0, "Type", { fg = palette.blue })
  hl(0, "StorageClass", { fg = palette.blue, bold = true })
  hl(0, "Structure", { fg = palette.blue, bold = true })
  hl(0, "Typedef", { fg = palette.blue, italic = true })

  hl(0, "Special", { fg = palette.cyan })
  hl(0, "SpecialChar", { fg = palette.cyan, bold = true })
  hl(0, "Tag", { fg = palette.orange, underline = true })
  hl(0, "Delimiter", { fg = palette.silver })
  hl(0, "SpecialComment", { fg = palette.silver, bold = true, italic = true })
  hl(0, "Debug", { fg = palette.red })

  hl(0, "Underlined", { fg = palette.magenta, underline = true })
  hl(0, "Ignore", { fg = palette.gray })
  hl(0, "Error", { fg = palette.white, bg = palette.red, bold = true })
  hl(0, "Todo", { fg = palette.black, bg = palette.yellow, bold = true })

  -- Matching brackets
  hl(0, "MatchParen", { fg = palette.white, bg = palette.green, bold = true })

  -- Spelling
  hl(0, "SpellBad", { undercurl = true, sp = palette.red })
  hl(0, "SpellCap", { undercurl = true, sp = palette.yellow })
  hl(0, "SpellRare", { undercurl = true, sp = palette.purple })
  hl(0, "SpellLocal", { undercurl = true, sp = palette.cyan })

  -- Treesitter specific (if using nvim-treesitter)
  hl(0, "@variable", { fg = palette.fg })
  hl(0, "@parameter", { fg = palette.fg, italic = true })
  hl(0, "@field", { fg = palette.lightBlue })
  hl(0, "@property", { fg = palette.lightBlue })
  hl(0, "@constructor", { fg = palette.blue, bold = true })
  hl(0, "@namespace", { fg = palette.magenta })
  hl(0, "@text.literal", { fg = palette.green })
  hl(0, "@text.reference", { fg = palette.blue, underline = true })
  hl(0, "@text.title", { fg = palette.orange, bold = true })
  hl(0, "@text.uri", { fg = palette.cyan, underline = true })
  hl(0, "@text.emphasis", { italic = true })
  hl(0, "@text.strong", { bold = true })

  -- LSP
  hl(0, "DiagnosticError", { fg = palette.red })
  hl(0, "DiagnosticWarn", { fg = palette.orange })
  hl(0, "DiagnosticInfo", { fg = palette.blue })
  hl(0, "DiagnosticHint", { fg = palette.cyan })
  hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = palette.red })
  hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = palette.orange })
  hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = palette.blue })
  hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = palette.cyan })

  -- Git signs
  hl(0, "GitSignsAdd", { fg = palette.green })
  hl(0, "GitSignsChange", { fg = palette.yellow })
  hl(0, "GitSignsDelete", { fg = palette.red })
end

function M.setup()
  -- Set terminal colors
  vim.g.terminal_color_0 = palette.black
  vim.g.terminal_color_1 = palette.red
  vim.g.terminal_color_2 = palette.green
  vim.g.terminal_color_3 = palette.orange
  vim.g.terminal_color_4 = palette.blue
  vim.g.terminal_color_5 = palette.purple
  vim.g.terminal_color_6 = palette.cyan
  vim.g.terminal_color_7 = palette.silver
  vim.g.terminal_color_8 = palette.gray
  vim.g.terminal_color_9 = palette.brightRed
  vim.g.terminal_color_10 = palette.brightGreen
  vim.g.terminal_color_11 = palette.yellow
  vim.g.terminal_color_12 = palette.lightBlue
  vim.g.terminal_color_13 = palette.magenta
  vim.g.terminal_color_14 = palette.aqua
  vim.g.terminal_color_15 = palette.white

  set_highlights()

  -- Create an autocmd to ensure highlights are reapplied when colorscheme changes
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      if vim.g.colors_name == "classic_retro" then
        set_highlights()
      end
    end,
  })
end

return M

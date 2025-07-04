-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  NvDashAscii = { bg = "none", fg = "purple" },
  NvDashButtons = { bg = "none" },
  Boolean = { italic = true },
  Conditional = { italic = true, bold = true },
  Repeat = { italic = true },
  ["@keyword.return"] = { italic = true },
  ["@keyword.operator"] = { italic = true },
  ["@keyword.function"] = { italic = true },
  ["@exception"] = { italic = true },
  ["@include"] = { italic = true },
  ["@repeat"] = { italic = true },
  ["@comment"] = { italic = true, fg = "#acacac" },
  TelescopePromptNormal = { blend = 100 },
}

---@type HLTable
M.add = {
  IndentBlanklineContextStart = { bg = "black2" },
  NeogitDiffDelete = { bg = "NONE", fg = "baby_pink" },
  NeogitDiffDeleteHighlight = { bg = "NONE", fg = "red" },
  TelescopeSelection = { bg = "red" },
  LspInlayHint = { bg = "NONE", fg = "light_grey" },

  -- Flat Floating
  -- NormalFloat = { fg = "white", bg = "darker_black", blend = 0 },
  -- FloatBorder = { fg = "darker_black", bg = "darker_black", blend = 5 },

  -- Nvim Tree
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M

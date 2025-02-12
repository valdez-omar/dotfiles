-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.8
local ROW_RATIO = 0.1
local COL_RATIO = 0.1

local highlights = require "highlights"

M.ui = {
  theme = "catppuccin",

  term = {
    float = {
      relative = "editor",
      row = ROW_RATIO,
      col = COL_RATIO,
      width = WIDTH_RATIO,
      height = HEIGHT_RATIO,
    },
  },

  transparency = true,
  lsp_semantic_tokens = true,
  hl_override = highlights.override,
  hl_add = highlights.add,

  nvdash = {
    load_on_startup = true,
  },

  cmp = {
    style = "default",
    selected_item_bg = "simple",
  },

  tabufline = {
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs" },
  },

  -- statusline = {
  --   theme = "default",
  --   separator_style = "arrow",
  --   modules = {},
  -- },
}

return M

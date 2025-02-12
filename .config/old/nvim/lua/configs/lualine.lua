-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#89b4fa',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#f38ba8',
  violet = '#dDB6f2',
  grey   = '#303030',
  green  = '#a6e3a1',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet, gui = "bold" },
    b = { fg = colors.white, bg = colors.grey, gui = "bold" },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.green, gui = "bold" } },
  visual = { a = { fg = colors.black, bg = colors.cyan, gui = "bold" } },
  replace = { a = { fg = colors.black, bg = colors.red, gui = "bold" } },
  command = { a = { fg = colors.black, bg = colors.blue, gui = "bold" } },

  inactive = {
    a = { fg = colors.white, bg = colors.black, gui = "bold" },
    b = { fg = colors.white, bg = colors.black, gui = "bold" },
    c = { fg = colors.white },
  },
}

require("lualine").setup {
  options = {
    theme = bubbles_theme,
    component_separators = "",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
    lualine_b = { "filename", "branch" },
    lualine_c = {
      "%=", --[[ add your center compoentnts here in place of this comment ]]
    },
    lualine_x = {},
    lualine_y = { "filetype", "progress" },
    lualine_z = {
      { "location", separator = { right = "" }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  },
  tabline = {},
  extensions = {},
}

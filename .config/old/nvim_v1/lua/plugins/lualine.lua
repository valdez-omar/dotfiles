local colors = {
	blue = "#89b4fa",
	cyan = "#79dac8",
	black = "#080808",
	white = "#c6c6c6",
	red = "#f38ba8",
	violet = "#dDB6f2",
	grey = "#303030",
	green = "#a6e3a1",
	buffer_bg = "#e1e2e",
	buffer_bg_selected = "45475a",
	buffer_fg = "ffffff",
	buffer_fg_selected = "cdd6f4",
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

require("lualine").setup({
	options = {
		theme = bubbles_theme,
		icons_enabled = true,
		component_separators = "",
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "alpha" },
			winbar = {},
		},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
		lualine_b = { "filename", "branch" },
		lualine_c = {
			"%=", --[[ add your center components here in place of this comment ]]
			{
				"diagnostics",
				sources = { "nvim_lsp" }, -- Use LSP as the source for diagnostics
				symbols = {
					error = " :",
					warn = " :",
					info = "󰽁 :",
					hint = " :",
				},
			},
		},
		lualine_x = {
			{
				"buffers",
				show_filename_only = true, -- Show only filename
				hide_filename_extension = false,
				show_modified_status = true,
				mode = 0, -- 0: Shows buffer name, 1: Shows buffer index
				buffers_color = {
					active = { bg = colors.buffer_bg_selected, fg = colors.buffer_fg_selected },
					inactive = { bg = colors.buffer_bg, fg = colors.buffer_fg },
				},
				symbols = {
					modified = "  ", -- Symbol for modified buffers
					alternate_file = " 󰙣 ", -- Symbol for alternate files
					directory = "  ", -- Symbol for directories
				},
			},
		},
		lualine_y = { "filetype", "progress" },
		-- lualine_z = {
		-- 	{ "location", separator = { right = "" }, left_padding = 2 },
		-- },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = {},
})

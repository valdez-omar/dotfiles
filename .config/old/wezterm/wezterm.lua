local wezterm = require("wezterm")
local config = {}

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 19
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_background_opacity = 0.85
-- config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.default_prog = { "/usr/bin/fish", "-l" }
config.enable_kitty_graphics = true

local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- Move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	-- Resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),
	{
		mods = "CTRL|ALT",
		key = "k",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "CTRL|ALT",
		key = "n",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "CTRL|ALT",
		key = "m",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		mods = "CTRL|ALT|SHIFT",
		key = "Enter",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		mods = "ALT",
		key = "Enter",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		mods = "CTRL|ALT",
		key = "0",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = "CTRL|ALT",
		key = "9",
		action = wezterm.action.ActivateTabRelative(-1),
	},
}

-- Custom tab colors
local mocha = {
	rosewater = "#f5e0dc",
	flamingo = "#f2cdcd",
	pink = "#f5c2e7",
	mauve = "#cba6f7",
	red = "#f38ba8",
	maroon = "#eba0ac",
	peach = "#fab387",
	yellow = "#f9e2af",
	green = "#a6e3a1",
	teal = "#94e2d5",
	sky = "#89dceb",
	sapphire = "#74c7ec",
	blue = "#89b4fa",
	lavender = "#b4befe",
	text = "#cdd6f4",
	subtext1 = "#bac2de",
	subtext0 = "#a6adc8",
	overlay2 = "#9399b2",
	overlay1 = "#7f849c",
	overlay0 = "#6c7086",
	surface2 = "#585b70",
	surface1 = "#45475a",
	surface0 = "#313244",
	base = "#1e1e2e",
	mantle = "#181825",
	crust = "#11111b",
}

config.colors = {
	tab_bar = {
		background = mocha.base,
		active_tab = {
			bg_color = mocha.sapphire,
			fg_color = mocha.base,
		},
		inactive_tab = {
			bg_color = mocha.mauve,
			fg_color = mocha.base,
		},
		inactive_tab_hover = {
			bg_color = mocha.pink,
			fg_color = mocha.base,
		},
		new_tab = {
			bg_color = mocha.surface1,
			fg_color = mocha.text,
		},
		new_tab_hover = {
			bg_color = mocha.surface2,
			fg_color = mocha.text,
		},
	},
}

config.window_frame = {
	font = wezterm.font({ family = "JetBrains Mono Nerd Font", weight = "Bold" }),
	font_size = 14.0,
	active_titlebar_bg = mocha.crust,
	inactive_titlebar_bg = mocha.crust,
}

local function get_process_icon(process_name)
	if process_name:find("nvim") then
		return wezterm.nerdfonts.custom_neovim
	elseif process_name:find("bash") or process_name:find("sh") or process_name:find("zsh") then
		return wezterm.nerdfonts.dev_terminal
	elseif process_name:find("fish") then
		return wezterm.nerdfonts.md_fish
	elseif process_name:find("mocp") then
		return wezterm.nerdfonts.md_playlist_music
	-- Add more conditions for other processes as needed
	else
		return wezterm.nerdfonts.linux_tux
	end
end

-- New function to format tab title
local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title == nil or title == "" then
		title = tab_info.active_pane.title
	end
	local process_name = tab_info.active_pane.foreground_process_name
	local icon = get_process_icon(process_name)
	return " " .. icon .. " " .. title .. " "
end

config.tab_bar_style = {
	new_tab = wezterm.format({ { Text = "+" } }),
	new_tab_hover = wezterm.format({ { Text = "+" } }),
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab_title(tab)
	return {
		{ Text = title },
	}
end)

return config

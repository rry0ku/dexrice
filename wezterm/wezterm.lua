local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- General
config.font_size = 15.0
config.line_height = 1.2
config.font = wezterm.font("JetBrainsMono Nerd Font")

-- Linux window settings
config.window_decorations = "RESIZE"
config.enable_tab_bar = false

-- Window padding
config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 10,
}

-- Transparency
-- config.window_background_opacity = 0.8

-- Key bindings
config.window_close_confirmation = "NeverPrompt"
config.keys = {
	-- CTRL + D = Split horizontally
	{
		key = "d",
		mods = "CTRL",
		action = wezterm.action.SplitHorizontal({
			domain = "CurrentPaneDomain",
		}),
	},

	-- CTRL + SHIFT + D = Split vertically
	{
		key = "d",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitVertical({
			domain = "CurrentPaneDomain",
		}),
	},
}

-- Disable audible bell
config.audible_bell = "Disabled"

return config

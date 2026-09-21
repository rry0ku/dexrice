local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- General
config.font_size = 14.0
config.line_height = 1.2
config.font = wezterm.font("JetBrainsMono Nerd Font")

-- Look
config.color_scheme = "Dracula+"
config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.6 }
config.window_padding = { left = 12, right = 12, top = 12, bottom = 12 }
config.hide_mouse_cursor_when_typing = true

-- Behavior
config.scrollback_lines = 20000
config.check_for_updates = false
config.front_end = "WebGpu" -- for smoother rendering

-- Linux window settings
config.window_decorations = "RESIZE"
config.enable_tab_bar = false

-- Transparency
-- config.window_background_opacity = 0.7

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

	-- CTRL + SHIFT + V = Paste (works in any shell)
	{
		key = "V",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(_, pane)
			local ok, out = wezterm.run_child_process({ "wl-paste", "-n" })
			if not ok then
				ok, out = wezterm.run_child_process({ "xclip", "-o", "-selection", "clipboard" })
			end
			if ok then
				pane:paste(out)
			end
		end),
	},

	-- CTRL + SHIFT + C = Copy
	{
		key = "C",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			local text = window:get_selection_text_for_pane(pane)
			if text and text ~= "" then
				local cmd = os.getenv("WAYLAND_DISPLAY") and "wl-copy" or "xclip -selection clipboard"
				local f = io.popen(cmd, "w")
				if f then
					f:write(text)
					f:close()
				end
				window:perform_action(wezterm.action.ClearSelection, pane)
			end
		end),
	},
}

-- Disable audible bell
config.audible_bell = "Disabled"

return config

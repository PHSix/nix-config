local wezterm = require("wezterm")
local act = wezterm.action

return {
	font = wezterm.font_with_fallback({
		"Macon", -- "Monaco"
		"Symbols Nerd Font",
		"Noto Color Emoji",
		"霞鹜文楷",
		"monospace",
	}),
	audible_bell = "Disabled",
	font_size = 12,
	enable_tab_bar = false,
	color_scheme = "GitHub Dark",
	enable_wayland = true,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	window_close_confirmation = "NeverPrompt",
	keys = {
		{
			key = "s",
			mods = "CMD",
			action = act.SendKey({
				key = "s",
				mods = "ALT",
			}),
		},
	},
}


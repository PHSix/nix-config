local wezterm = require("wezterm")
local act = wezterm.action

return {
	font = wezterm.font_with_fallback({
		"JetBrains Mono NL", -- "Macon", -- "Monaco"
		"Macon",
		"Symbols Nerd Font",
		"Noto Color Emoji",
		"霞鹜文楷",
		"monospace",
	}),
	audible_bell = "Disabled",
	font_size = 13,
	enable_tab_bar = false,
	color_scheme = "GitHub Dark",
	enable_wayland = true,
	window_background_opacity = 0.9,
	window_padding = {
		left = 0,
		right = 0,
		top = 6,
		bottom = 6,
	},
	check_for_updates = false,
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


local wezterm = require("wezterm")
local act = wezterm.action

local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'GitHub Dark'
  else
    -- return 'Github (base16)'
    -- return 'Github'
		return 'Github (Gogh)'
  end
end

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
	-- color_scheme = "GitHub Dark",
	color_scheme = scheme_for_appearance(get_appearance()),
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


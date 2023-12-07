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
  font_size = 16,
  enable_tab_bar = false,
  color_scheme = "Nord (base16)",
  enable_wayland = false,
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

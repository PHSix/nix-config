{ actions, lib }: with actions;
let
  # mod = suffix: "Mod4+${suffix}";
  sh = spawn "sh" "-c";
in
lib.attrsets.mergeAttrsList [
  {
    "Mod+Return".action = spawn "ghostty";
    "Mod+D".action = sh "rofi -show drun -show-icons";
    "Mod+E".action = spawn "thunar";
    # "Mod+L".action = sh "pgrep hyprlock || hyprlock";
    "Mod+Q".action = close-window;

    "Mod+Space".action = toggle-window-floating;
    "Mod+Tab".action = switch-focus-between-floating-and-tiling;
    "Mod+Comma".action = consume-window-into-column;
    "Mod+Period".action = expel-window-from-column;
    "Mod+R".action = switch-preset-column-width;
    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;
    "Mod+Shift+C".action = center-column;
    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Plus".action = set-column-width "+10%";
    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Plus".action = set-window-height "+10%";
    "Mod+Shift+Q".action = quit;
    "Mod+Shift+P".action = power-off-monitors;
    "Mod+Shift+Ctrl+T".action = toggle-debug-tint;
    "Mod+WheelScrollDown" = {
      action = focus-workspace-down;
      cooldown-ms = 150;
    };

    "Mod+H".action = focus-column-left;
    "Mod+J".action = focus-window-down;
    "Mod+K".action = focus-window-up;
    "Mod+L".action = focus-column-right;

    "Mod+Ctrl+Left".action = move-column-left;
    "Mod+Ctrl+Down".action = move-window-down;
    "Mod+Ctrl+Up".action = move-window-up;
    "Mod+Ctrl+Right".action = move-column-right;
    "Mod+Ctrl+H".action = move-column-left;
    "Mod+Ctrl+J".action = move-window-down;
    "Mod+Ctrl+K".action = move-window-up;
    "Mod+Ctrl+L".action = move-column-right;
  }
]


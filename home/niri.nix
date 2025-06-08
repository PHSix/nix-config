{
  pkgs,
  niri,
  config,
  lib,
  ...
}:
{
  imports = [ niri.homeModules.niri ];
  home = {
    packages = with pkgs; [
      brightnessctl
      cliphist
      labwc
      lswt
      wlrctl
      wl-clip-persist
      xorg.xprop
      xwayland-satellite
      rofi
      xfce.thunar
      wofi
    ];
    # make stuff work on wayland
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
  programs.niri.enable = true;
  programs.niri.settings = {
    environment = {
      XDG_CURRENT_DESKTOP = "gnome";
      CLUTTER_BACKEND = "wayland";
      DISPLAY = ":0";
      GDK_BACKEND = "wayland,x11";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
    };
    screenshot-path = "~/Pictures/Screenshots from %Y-%m-%d %H-%M-%S.png";

    input = {
      keyboard.xkb.layout = "us";
      focus-follows-mouse.enable = true;
      mouse.accel-speed = 1.0;
      tablet.map-to-output = "P27QBC-RG";
      warp-mouse-to-focus = true;
    };

    outputs = {
      "P27QBC-RG" = {
        mode = {
          width = 2560;
          height = 1440;
          refresh = 60.0;
        };
        scale = 1.0;
        position = {
          x = 0;
          y = 0;
        };
        variable-refresh-rate = true;
        background-color = "#003300";
      };
    };
    # Workspace Configuration
    prefer-no-csd = true;
    workspaces = {
      "1" = {
        name = "terminal";
      };
      "2" = {
        name = "2";
      };
      "3" = {
        name = "3";
      };
      "4" = {
        name = "video";
      };
      "5" = {
        name = "browser";
      };
      "6" = {
        name = "music";
      };
      "7" = {
        name = "chat";
      };
      "8" = {
        name = "game";
      };
    };

    # Layout Configuration
    layout = {
      gaps = 8;
      struts = {
        top = 0;
        bottom = 0;
        left = 0;
        right = 0;
      };
      focus-ring.enable = false;
      border = {
        enable = true;
        width = 2;
        active = {
          gradient = {
            from = "#f38ba8";
            to = "#f9e2af";
            angle = 45;
            relative-to = "workspace-view";
          };
        };
        inactive = {
          gradient = {
            from = "#585b70";
            to = "#7f849c";
            angle = 45;
            relative-to = "workspace-view";
          };
        };
      };
      preset-column-widths = [
        { proportion = 1.0 / 3.0; }
        { proportion = 1.0 / 2.0; }
        { proportion = 2.0 / 3.0; }
        { proportion = 1.0; }
      ];
      default-column-width = {
        proportion = 1.0 / 2.0;
      };
    };

    hotkey-overlay.skip-at-startup = true;

    # Keybindings Configuration
    # binds =
    #   import ./binds.nix { actions = config.lib.niri.actions; lib = lib; };
    binds =
      let
        actions = config.lib.niri.actions;
        spawn = actions.spawn;
        sh = spawn "sh" "-c";
        list = with actions; [
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
        ];
      in
      lib.attrsets.mergeAttrsList list;

    # Startup Applications
    spawn-at-startup =
      let
        cmds = [ "fcitx5 --replace -d" ];
      in
      (map (cmd: { command = builtins.split " " cmd; }) cmds);

    # Animations
    animations = {
      slowdown = 0.9;
      workspace-switch = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 2000;
          epsilon = 1.0e-4;
        };
      };
      horizontal-view-movement = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 1000;
          epsilon = 1.0e-4;
        };
      };
      window-movement = {
        spring = {
          damping-ratio = 1.0;
          stiffness = 1000;
          epsilon = 1.0e-4;
        };
      };
      shaders = {
        window-close = ''
          vec4 close_color(vec3 coords_geo, vec3 size_geo) {
            // For this shader, set animation curve to linear for best results.

            // Simulate an accelerated fall: square the (linear) progress.
            float progress = niri_clamped_progress * niri_clamped_progress;

            // Get our rotation pivot point coordinates at the bottom center of the window.
            vec2 coords = (coords_geo.xy - vec2(0.5, 1.0)) * size_geo.xy;

            // Move the window down to simulate a fall.
            coords.y -= progress * 200.0;

            // Randomize rotation direction and maximum angle.
            float random = (niri_random_seed - 0.5) / 2.0;
            random = sign(random) - random;
            float max_angle = 0.05 * random;

            // Rotate the window around our pivot point.
            float angle = progress * max_angle;
            mat2 rotate = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
            coords = rotate * coords;

            // Transform the coordinates back.
            coords_geo = vec3(coords / size_geo.xy + vec2(0.5, 1.0), 1.0);

            // Sample the window texture.
            vec3 coords_tex = niri_geo_to_tex * coords_geo;
            vec4 color = texture2D(niri_tex, coords_tex.st);

            // Multiply by alpha to fade out.
            return color * (1.0 - niri_clamped_progress);
          }
        '';
        window-resize = ''
          vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
            vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;

            vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;
            vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;

            // We can crop if the current window size is smaller than the next window
            // size. One way to tell is by comparing to 1.0 the X and Y scaling
            // coefficients in the current-to-next transformation matrix.
            bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;
            bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;

            vec3 coords = coords_stretch;
            if (can_crop_by_x)
                coords.x = coords_crop.x;
            if (can_crop_by_y)
                coords.y = coords_crop.y;

            vec4 color = texture2D(niri_tex_next, coords.st);

            // However, when we crop, we also want to crop out anything outside the
            // current geometry. This is because the area of the shader is unspecified
            // and usually bigger than the current geometry, so if we don't fill pixels
            // outside with transparency, the texture will leak out.
            //
            // When stretching, this is not an issue because the area outside will
            // correspond to client-side decoration shadows, which are already supposed
            // to be outside.
            if (can_crop_by_x && (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x))
                color = vec4(0.0);
            if (can_crop_by_y && (coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y))
                color = vec4(0.0);

            return color;
          }
        '';
      };
    };
    # Window Rules
    window-rules = [
      {
        draw-border-with-background = false;
        geometry-corner-radius =
          let
            r = 8.0;
          in
          {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
        clip-to-geometry = true;
      }
      {
        matches = [ { is-focused = false; } ];
        opacity = 0.95;
      }
    ];
  };

}

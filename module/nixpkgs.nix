inputs@{ system, ... }:
let
  selfPkgs = import ../pkgs;

  # patch waybar to support hyprland desktop environment
  waybar-overlay = (final: prev: {
    waybar = prev.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      postPatch = (oldAttrs.postPatch or "") + ''
        sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp'';
    });
  });
  overlays = [
    selfPkgs
    inputs.neovim-nightly-overlay.overlay

    waybar-overlay
  ];

in {

  nixpkgs.overlays = overlays;
  nixpkgs = {

    config = {
      allowUnfree = true;
      allowAliases = false;
    };

    system = system;
  };
}

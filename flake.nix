{
  description = "My nixos config `flake.nix`.";
  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
    };
    nixos-cn = {
      url = "github:nixos-cn/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@ { nixpkgs, home-manager, flake-parts, ... }:
    let
      mypkgs = import ./pkgs;
      # pkgs = nixpkgs.legacyPackages.${system};
      parts = flake-parts;
      pkgs = import nixpkgs {
        config.allowUnfree = true;
        overlays = [
          mypkgs

          # patch waybar to support hyprland desktop environment
          (final: prev: {
            waybar =
              prev.waybar.overrideAttrs (oldAttrs: {
                mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
                postPatch = (oldAttrs.postPatch or "") + ''
                  sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp'';
              });
          })
        ];
      };
      genHomeConfiguration = inputs: {
        imports = [
          ./home
          ./home/cli.nix
          ./home/packages.nix
          ./home/misc.nix
          ./home/tmux.nix
          ./home/kitty.nix
          ./home/zsh.nix
          ./home/vim
          ./home/waybar
          ./home/hyprland
          ./home/neovim-deps.nix
          ./home/mpd.nix
          ./home/joshuto
        ];

      };
    in
    parts.lib.mkFlake { inherit inputs; } {
      system = [ "x86_64-linux" ];

      flake = {
        nixosConfigurations = {
          nixosSystem = nixpkgs.lib.nixosSystem {
            inherit pkgs;
            modules = [
              ./hardware/hardware-configuration.nix
              # ./module/gnome.nix
              ./module/hyprland.nix
              ./module/network.nix
              ./module/grub.nix
              ./module/misc.nix
              ./module/nixos.nix
              ./module/user.nix
              ./module/packages.nix
              ./module/locale.nix
              ./module/graphics.nix
              ./module/proxychains.nix

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.ph = genHomeConfiguration;
              }
            ];
          };
        };
      };
    };
}


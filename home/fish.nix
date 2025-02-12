{ pkgs, ... }: {
  programs = {
    fish = {
      enable = true;

      shellAbbrs = {
        ls = "eza";
        l = "eza --git-ignore";
        ll = "eza --all --header --long";
        llm = "eza --all --header --long --sort=modified";
        la = "eza -lbhHigUmuSa";
        lx = "eza -lbhHigUmuSa@";
        lt = "eza --tree";
        tree = "eza --tree";

        lg = "lazygit";
        cl = "clear";

        ga = "git add";
        gaa = "git add --all";
        gba = "git branch --all";
        gl = "git clone";
        gc = "git commit --verbose";
        gca = "git commit --verbose --amend";
        gcA = "git commit --verbose --no-edit --amend";
        gcb = "git checkout -b";
        grbc = "git rebase --continue";
        grba = "git rebase --abort";
        grbi = "git rebase -i";
        gm = "git merge";
        gP = "git push";
        gPf = "git push -f";
        gp = "git pull";
        gpr = "git pull --rebase";
        glogen = "git log --oneline -n";
      };

      shellAliases = {
        nvi = "nvim";
        fetch = "fastfetch";
      };

      shellInit = ''
        set -g fish_key_bindings fish_vi_key_bindings
        bind -M insert \cp history-search-backward
        bind -M insert \cn history-search-forward
        bind -M insert \cf forward-char
        bind -M insert \cb backward-char
        bind -M insert \ce end-of-buffer
        bind -M insert \ca beginning-of-buffer

        set fish_cursor_default     line
        set fish_cursor_insert      line
        set fish_cursor_replace_one underscore
        set fish_cursor_visual      block
        # fish_add_path $HOME/.npm-packages/bin

        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';

      functions = {
        fish_greeting = "";
        nix-shell = {
          wraps = "nix-shell";
          body = ''
            for ARG in $argv
              if [ "$ARG" = --run ]
                command nix-shell $argv
                return $status
              end
            end
            command nix-shell $argv --run "exec fish"
          '';
        };

        yz = {
          wraps = "yz";
          body = ''
            set tmp (mktemp -t "yazi-cwd.XXXXXX")
            yazi $argv --cwd-file="$tmp"
            if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            	cd -- "$cwd"
            end
            rm -f -- "$tmp"
          '';
        };
      };
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      enableTransience = true;
    };

    yazi.enableFishIntegration = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home = {
    sessionVariables = { EDITOR = "nvim"; };
    sessionPath = [ "$HOME/.npm-packages/bin" ];
    packages = with pkgs; [
      any-nix-shell
    ];
  };
}


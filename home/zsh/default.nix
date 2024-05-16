{ pkgs, ... }: {
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      defaultKeymap = "emacs";
      shellAliases = {
        lg = "lazygit";
        cl = "clear";
        ls = "eza";
        l = "eza -lbF --git";
        ll = "eza -lbGF --git";
        llm = "eza -lbGd --git --sort=modified";
        la = "eza -lbhHigUmuSa --time-style=long-iso --git --color-scale";
        lx = "eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale";
        lS = "eza -1";
        lt = "eza --tree --level=2";
        gp = "git pull";
        gP = "git push";
        # ra = "ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd \"$LASTDIR\"";
        cn = "touch";
        mk = "mkdir";
        gl = "git clone";
        n = "fastfetch";
        nvi = "nvim";
      };
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.5.0";
            sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
          };
        }
      ];
      initExtra = ''
        if type "yazi" > /dev/null; then
          alias ra="yz"
          function yz() {
            tmp="$(mktemp -t "yazi-cwd.XXXXX")"
            yazi --cwd-file="$tmp"
            if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
              cd -- "$cwd"
            fi
            rm -f -- "$tmp"
          }
        fi

        function proxy(){
          export https_proxy=http://localhost:7897
          export http_proxy=http://localhost:7897
        }

        function unproxy(){
          export https_proxy=
          export http_proxy=
        }

        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

        source ~/.config/zsh/.p10k.zsh
        # eval "$(zoxide init zsh)"
      '';
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };

  home = {
    sessionVariables = { EDITOR = "nvim"; };
    sessionPath = [ "$HOME/.npm-packages/bin" ];
    packages = with pkgs; [
      # zinit
      zsh-vi-mode
      zsh-fzf-tab
      zsh-fast-syntax-highlighting
      zsh-completions
      pure-prompt
      zsh-powerlevel10k

      any-nix-shell
    ];

    file.".config/zsh/.p10k.zsh".source = ./p10k.zsh;
  };
}

{ pkgs, ... }: {

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    syntaxHighlighting = { enable = true; };
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
      # {
      #   name = "zap-prompt";
      #   file = "zap-prompt.zsh-theme";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "zap-zsh";
      #     repo = "zap-prompt";
      #     rev = "7cf4762cc23761493f0b4f86270b780b55254c20";
      #     sha256 = "sha256-s6uaqI/mjtOqr8mKsKb/u+JzLxaaeItonRCRdmoZx5g=";
      #   };
      # }
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
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      source ~/.config/zsh/.p10k.zsh
      # eval "$(zoxide init zsh)"
    '';
  };

  home.sessionVariables = { EDITOR = "nvim"; };
  home.sessionPath = [ "$HOME/.npm-packages/bin" ];
  home.packages = with pkgs; [
    # zinit
    zsh-vi-mode
    zsh-fzf-tab
    zsh-fast-syntax-highlighting
    zsh-completions
    pure-prompt
    zsh-powerlevel10k
  ];
  # programs.starship = {
  #   enable = true;
  #   enableZshIntegration = true;
  #   enableBashIntegration = true;
  # };
  xdg.configFile."zsh/.p10k.zsh".source = ./p10k.zsh;
}

let
  f = { pkgs, ... }: {
    programs = {
      zsh = {
        enable = true;
        dotDir = ".config/zsh";
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
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

            function yz() {
              local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
              yazi "$@" --cwd-file="$tmp"
              if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                builtin cd -- "$cwd"
              fi
              rm -f -- "$tmp"
            }
          fi

          if type "ranger" > /dev/null; then
            function ra() {
              ranger --choosedir="$PWD" "$@"
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

          autoload -Uz compinit && compinit

          # History
          HISTSIZE=5000
          HISTFILE=~/.zsh_history
          SAVEHIST=$HISTSIZE
          HISTDUP=erase
          setopt appendhistory
          setopt sharehistory
          setopt hist_ignore_space
          setopt hist_ignore_all_dups
          setopt hist_save_no_dups
          setopt hist_ignore_dups
          setopt hist_find_no_dups

          # Completion styling
          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
          zstyle ':completion:*' list-colors "$\{(s.:.)LS_COLORS}"
          zstyle ':completion:*' menu no
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
          zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

          any-nix-shell zsh --info-right | source /dev/stdin
          eval "$(zoxide init zsh)"
          eval "$(starship init zsh)"
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
        zsh-vi-mode
        zsh-fzf-tab
        # zsh-powerlevel10k
        starship

        any-nix-shell
      ];

      # file.".config/zsh/.p10k.zsh".source = ./p10k.zsh;
    };
  };
in
{
  hmModules = [ f ];
}

{ pkgs, nixosConfig, ... }:

let
  sourceEnv =
    if (builtins.tryEval nixosConfig.age.secrets.env.path).success then
      "source ${nixosConfig.age.secrets.env.path}"
    else
      "";
in
{
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
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
      initContent = ''
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

        if type "nvim" > /dev/null; then
          export EDITOR="nvim"
        elif type "vim" > /dev/null; then
          export EDITOR="vim"
        fi

        if type "ranger" > /dev/null; then
          function ra() {
            ranger --choosedir="$PWD" "$@"
          }
        fi
        [[ -f ~/.config/zsh/.p10k.zsh ]] && source ~/.config/zsh/.p10k.zsh

        source ${pkgs.zinit}/share/zinit/zinit.zsh

        # Completion styling
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' list-colors "$\{(s.:.)LS_COLORS}"
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

        # autoload -Uz compinit && compinit

        zinit ice depth=1
        zinit for \
          light-mode \
          zsh-users/zsh-autosuggestions \
          jeffreytse/zsh-vi-mode \
          zdharma-continuum/fast-syntax-highlighting \
          zdharma-continuum/history-search-multi-word \
          zsh-users/zsh-completions \
          Aloxaf/fzf-tab \
          romkatv/powerlevel10k

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

        any-nix-shell zsh --info-right | source /dev/stdin
        eval "$(zoxide init zsh --cmd j)"
        ${sourceEnv}
      '';
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };

  home = {
    sessionPath = [ "$HOME/.npm-packages/bin" ];
    file.".config/zsh/.p10k.zsh".source = ../config/p10k.zsh;
    packages = with pkgs; [
      any-nix-shell
    ];
  };
}

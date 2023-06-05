{ pkgs, ... }:
{

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    defaultKeymap = "emacs";
    shellAliases = {
      lg = "lazygit";
      cl = "clear";
      ls = "exa";
      l = "exa -lbF --git";
      ll = "exa -lbGF --git";
      llm = "exa -lbGd --git --sort=modified";
      la = "exa -lbhHigUmuSa --time-style=long-iso --git --color-scale";
      lx = "exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale";
      lS = "exa -1";
      lt = "exa --tree --level=2";
      ra = "ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd \"$LASTDIR\"";
      cn = "touch";
      mk = "mkdir";
      gl = "git clone";
      n = "neofetch";
      nvi = "nvim";
      "'??'" = "gitcli command";
      "'commit?'" = "gitcli commit";
      "'chat?'" = "gitcli chat";
      "'t?'" = "gitcli translate";
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
      #   zsh-vi-mode
    ];
    initExtra = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      eval "$(zoxide init zsh)"
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.sessionPath = [
    "$HOME/.npm-packages/bin"
  ];
  home.packages = with pkgs; [
    # zinit
    zsh-vi-mode
    zsh-fzf-tab
  ];
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}

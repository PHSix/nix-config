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
      ra = "ranger";
      ranger = "ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd \"$LASTDIR\"";
      cn = "touch";
      mk = "mkdir";
      gl = "git clone";
      n = "neofetch";
      nvi = "nvim";
    };
    # plugins = with pkgs; [
    #   zsh-vi-mode
    # ];
    initExtra = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      export EDITOR=nvim
      export PATH="$HOME/.npm-packages/bin:$PATH"
      source ~/.proxy.sh
    '';
  };
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

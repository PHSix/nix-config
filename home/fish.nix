{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      yz = "yazi";
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
  };
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;
  };

  programs.yazi.enableFishIntegration = true;

  xdg.configFile."fish/config.fish".text = ''
    set - g fish_key_bindings fish_vi_key_bindings
    bind - M insert \cp history-search-backward
    bind - M insert \cn history-search-forward
    bind - M insert \cf forward-char
    bind - M insert \cb backward-char

    ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source

    # function fish_greeting                                            
    #     # do nothing
    # end
  '';

  home.packages = with pkgs; [
    any-nix-shell
  ];
}


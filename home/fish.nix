{ ... }: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      yz = "yazi";
      ls = "eza $eza_params";
      l = "eza --git-ignore $eza_params";
      ll = "eza --all --header --long $eza_params";
      llm = "eza --all --header --long --sort=modified $eza_params";
      la = "eza -lbhHigUmuSa";
      lx = "eza -lbhHigUmuSa@";
      lt = "eza --tree $eza_params";
      tree = "eza --tree $eza_params";

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

    # function fish_greeting                                            
    #     # do nothing
    # end
  '';
}



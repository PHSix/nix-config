{ stylix, pkgs, ... }: {
  imports = [
  ];
  stylix.enable = true;
  stylix.autoEnable = false;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/google-dark.yaml";
  stylix.fonts = {
    serif = {
      package = pkgs.lxgw-wenkai;
      name = "LXGW WenKai Mono";
    };

    sansSerif = {
      package = pkgs.lxgw-wenkai;
      name = "LXGW WenKai Mono";
    };

    monospace = {
      package = pkgs.lxgw-wenkai;
      name = "LXGW WenKai Mono";
    };

    emoji = {
      package = pkgs.twitter-color-emoji;
      name = "Twitter Color Emoji";
    };
  };

}


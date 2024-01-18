{ ... }: {
  programs.proxychains = {
    enable = true;
    proxies = {
      myproxy = {
        type = "http";
        host = "127.0.0.1";
        port = 7897;
        enable = true;
      };
    };
  };
}

let
  f = { pkgs, ... }: {
    home.packages = with pkgs;[ wofi ];
    xdg.configFile."wofi/colors".text = ""
      #1e1e2e
      #262636
      #d9e0ee
      #89b4fa
      #f38ba8
      #cba6f7
      "";
    xdg.configFile."wofi/config".text = "
    ## General
    show=drun
    prompt=Apps
    normal_window=true
    layer=top
    term=foot

    ## Geometry
    width=600px
    height=405px
    location=0
    orientation=vertical
    halign=fill
    line_wrap=off
    dynamic_lines=false

    ## Images
    allow_markup=true
    allow_images=true
    image_size=24

    ## Search
    exec_search=false
    hide_search=false
    parse_search=false
    insensitive=false

    ## Other
    hide_scroll=true
    no_actions=true
    sort_order=default
    gtk_dark=true
    filter_rate=100

    ## Keys
    key_expand=Tab
    key_exit=Escape
    ";
  };
in
{
  hmModules = [ f ];
}


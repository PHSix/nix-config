let
  f =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ wofi ];
      xdg.configFile."wofi/colors".text =
        ""
          #1e1e2e
          #262636
          #d9e0ee
          #89b4fa
          #f38ba8
          #cba6f7
          "";
      xdg.configFile."wofi/config".text =
        "\n    ## General\n    show=drun\n    prompt=Apps\n    normal_window=true\n    layer=top\n    term=foot\n\n    ## Geometry\n    width=600px\n    height=405px\n    location=0\n    orientation=vertical\n    halign=fill\n    line_wrap=off\n    dynamic_lines=false\n\n    ## Images\n    allow_markup=true\n    allow_images=true\n    image_size=24\n\n    ## Search\n    exec_search=false\n    hide_search=false\n    parse_search=false\n    insensitive=false\n\n    ## Other\n    hide_scroll=true\n    no_actions=true\n    sort_order=default\n    gtk_dark=true\n    filter_rate=100\n\n    ## Keys\n    key_expand=Tab\n    key_exit=Escape\n    ";
    };
in
{
  hmModules = [ f ];
}

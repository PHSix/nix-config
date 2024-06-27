{ pkgs, username ? "ph", ... }: {
  # programs.adb.enable = true;
  # users.users."${username}".extraGroups = [ "adbusers" ];

  # programs.java.enable = true;

  # environment.systemPackages = with pkgs; [
  #   android-udev-rules
  #   android-tools
  #   # android-studio
  #   flutter
  #   kotlin
  #
  #   jetbrains-toolbox
  # ];
}

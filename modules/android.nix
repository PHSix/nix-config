{ pkgs, username ? "ph", ... }: {
  programs.adb.enable = true;
  users.users."${username}".extraGroups = [ "adbusers" ];

  environment.systemPackages = with pkgs; [
    android-udev-rules
    android-studio
    kotlin
  ];
}

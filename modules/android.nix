{ pkgs, ... }: {
  programs.adb.enable = true;
  users.users.ph.extraGroups = [ "adbusers" ];

  environment.systemPackages = with pkgs; [
    android-studio
    kotlin
  ];
}

{
  pkgs,
  username ? "ph",
  ...
}:
let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "8.0";
    buildToolsVersions = [
      "34.0.0"
      "30.0.3"
    ];
    platformVersions = [
      "34"
      "33"
      "29"
      "28"
    ];
    abiVersions = [
      "armeabi-v7a"
      "arm64-v8a"
    ];
    extraLicenses = [
      "android-googletv-license"
      "android-sdk-arm-dbt-license"
      "android-sdk-license"
      "android-sdk-preview-license"
      "google-gdk-license"
      "intel-android-extra-license"
      "intel-android-sysimage-license"
      "mips-android-sysimage-license"
    ];
  };
  androidSdk = androidComposition.androidsdk;
in
{
  programs.adb.enable = true;
  users.users."${username}".extraGroups = [ "adbusers" ];

  environment.systemPackages = with pkgs; [
    android-udev-rules
    androidSdk
    # android-studio-full
    android-tools
    android-studio
    jdk17
    kotlin
  ];

  environment.sessionVariables = {
    GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/34.0.0/aapt2"; # 30.0.3  34.0.0
    ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
    #ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
    JAVA_HOME = "${pkgs.jdk17.home}";
    # CHROME_EXECUTABLE = "${pkgs.chromium}/bin/chromium";
  };
}

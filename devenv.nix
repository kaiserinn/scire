{pkgs, ...}: {
  android = {
    enable = true;
    flutter.enable = true;
    platformTools.version = "34.0.5";
    extraLicenses = [
      "android-sdk-preview-license"
      "android-googletv-license"
      "android-sdk-arm-dbt-license"
      "google-gdk-license"
      "intel-android-extra-license"
      "intel-android-sysimage-license"
      "mips-android-sysimage-license"
    ];
  };

  packages = with pkgs; [
    mesa-demos
    sqlite
    litecli
  ];
}

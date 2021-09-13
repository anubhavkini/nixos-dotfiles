{ pkgs, ... }:

{
  imports = [
    ../default.nix
    ../modules/external-display
    ../modules/laptop
    ../modules/media
    ../modules/shell
    ../modules/user
  ];

  hardware.enableRedistributableFirmware = true;

  # Set hostname.
  networking.hostName = "bracer";

  # Set time zone and locale.
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_GB.UTF-8";

  # External harddrive.
  environment.systemPackages = [ pkgs.ntfs3g ];
}

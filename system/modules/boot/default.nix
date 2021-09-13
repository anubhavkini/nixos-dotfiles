{ ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.systemd-boot.editor = false;

  # Silent boot.
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;
  boot.kernelParams = [ "quiet" "udev.log_priority=3" ];
  boot.plymouth.enable = true;

  # Faster boot.
  systemd.services.systemd-udev-settle.serviceConfig.TimeoutSec = 5;
  systemd.services.NetworkManager-wait-online.enable = false;
  security.audit.enable = false;

  # Configure filesystems and mountpoints.
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };
  };

  swapDevices = [ { device = "/dev/disk/by-label/SWAP"; } ];
}

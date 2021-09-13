{ lib, ... }:

{
  # Disable bluetooth on boot.
  hardware.bluetooth.powerOnBoot = lib.mkDefault false;
}

{ pkgs, ... }:

{
  # Use the latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
}

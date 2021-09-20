{ ... }:

{
  imports = [
    ../default.nix
    ../../modules/vpn/proton/linux
    ../../modules/window-manager/wayland
  ];
}

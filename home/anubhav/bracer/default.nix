{ ... }:

{
  imports = [
    ../default.nix
    ../../modules/security/keepassxc/hikari.nix
    ../../modules/terminal/foot
    ../../modules/vpn/proton/linux
    ../../modules/window-manager/wayland
  ];
}

{ ... }:

{
  imports = [
    ../default.nix
    ../../modules/password-manager/keepassxc/hikari.nix
    ../../modules/terminal/foot
    ../../modules/vpn/proton/linux
    ../../modules/window-manager/wayland
  ];
}

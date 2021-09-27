{ pkgs, ... }:

{
  imports = [
    ./modules/communication
    ./modules/boot
    ./modules/kernel
    ./modules/nix
    ./modules/security
    ./modules/systemd
    ./modules/user
  ];

  # Git dependancy.
  environment.systemPackages = [ pkgs.gitMinimal ];

  # Set the state.
  system.stateVersion = "21.11";
}

{ pkgs, ... }:

{
  # Enable flakes.
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = "experimental-features = nix-command flakes";
  nix.autoOptimiseStore = true;
}

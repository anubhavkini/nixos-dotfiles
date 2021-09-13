{
  description = "NixOS and Home Manager configuration flake";

  inputs =
    {
      # Package sets.
      nixpkgs.url = "nixpkgs/nixos-unstable";
      nixpkgs-stable.url = "nixpkgs/nixos-21.05";

      # Hardware management.
      nixos-hardware.url = "github:anubhavkini/nixos-hardware/A315-55G-709W";

      # Environment management.
      home-manager.url = "github:nix-community/home-manager/master";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";

      # Nix User Repository.
      nur.url = "github:nix-community/NUR";

      # Emacs overlay.
      emacs.url = "github:nix-community/emacs-overlay";
    };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    , home-manager
    , nur
    , emacs
    , ...
    } @ inputs:

  let
    system = "x86_64-linux";
    stateVersion = "21.11";

    pkgs = import nixpkgs {
      inherit system;

      # Permit unfree software.
      config = { allowUnfree = true; };

      overlays = [
        nur.overlay
        emacs.overlay
      ];
    };

  in {
    # System configurations.
    nixosConfigurations = with nixpkgs.lib; {

      # Configuration for bracer.
      bracer = nixosSystem {
        inherit system pkgs;

        modules = [
          nixos-hardware.nixosModules.acer-aspire-A315-55G_709W
          ./system/bracer
        ];
      };
    };

    # Home Manager configurations.
    homeConfigurations = with home-manager.lib; {

      # Configuration for anubhav on bracer.
      "anubhav@bracer" = homeManagerConfiguration {
        inherit system pkgs stateVersion;

        username = "anubhav";
        homeDirectory = "/home/anubhav";

        configuration = {
          imports = [ ./home/anubhav/bracer ];
        };
      };
    };
  };
}

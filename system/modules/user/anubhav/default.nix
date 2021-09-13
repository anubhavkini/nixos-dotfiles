{ ... }:

{
  # Setup default user.
  users.users.anubhav = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [ "wheel" ];
  };

  # Allow hikari-unlocker to unlock the screen.
  security.pam.services.hikari-unlocker.unixAuth = true;

  # Disable display manager.
  services.xserver.displayManager.startx.enable = true;

  # Use openGL.
  hardware.opengl.enable = true;

  # Allow adding cachix.
  nix.trustedUsers = [ "root" "anubhav" ];

  # SSH.
  programs.ssh = {
    extraConfig = ''
      AddKeysToAgent yes
    '';
    hostKeyAlgorithms = [ "ssh-ed25519" "ssh-rsa" ];
    startAgent = true;
  };
}

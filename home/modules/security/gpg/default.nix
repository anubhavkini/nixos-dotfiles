{ config, ... }:

{
  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
  };

  services.gpg-agent = {
    enable = true;
    #extraConfig = ''allow-emacs-pinentry'';
    #pinentryFlavor = "emacs";
  };
}

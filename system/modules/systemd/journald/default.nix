{ ... }:

{
  # Journald config.
  services.journald.extraConfig = ''
    SystemMaxFileSize=50M
    Storage=volatile
  '';
}

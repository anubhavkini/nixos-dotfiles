{ ... }:

{
  # Explicitly set global useDHCP flag to false.
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;

  # Statically set nameservers so that
  # NetworkManager won't override.
  networking.nameservers = [ "127.0.0.1" "0::1" ];
  environment.etc."resolv.conf".enable = false;
  networking.resolvconf.enable = false;

  # Use NetworkManager with iwd backend.
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };
}

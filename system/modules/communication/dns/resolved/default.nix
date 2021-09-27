{ config, ... }:

{
  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };

  networking.nameservers = [
    "45.90.28.0#${config.networking.hostName}-388b94.dns1.nextdns.io"
#    "2a07:a8c0::#${config.networking.hostName}-388b94.dns1.nextdns.io"
    "45.90.30.0#${config.networking.hostName}-388b94.dns2.nextdns.io"
#    "2a07:a8c1::#${config.networking.hostName}-388b94.dns2.nextdns.io"
  ];
}

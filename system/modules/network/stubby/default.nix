{ config, ... }:

{
  # Use Stubby with NextDNS.
  services.stubby = {
    enable = true;
    listenAddresses = [ "127.0.0.1@8053" "0::1@8053" ];
    upstreamServers = ''
      - address_data: 45.90.28.0
        tls_auth_name: "${config.networking.hostName}-388b94.dns1.nextdns.io"
      - address_data: 45.90.30.0
        tls_auth_name: "${config.networking.hostName}-388b94.dns2.nextdns.io"
    '';
  };
}

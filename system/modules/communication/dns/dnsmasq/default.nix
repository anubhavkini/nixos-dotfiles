{ ... }:

{
  # Use DNSmasq for cache.
  services.dnsmasq = {
    enable = true;
    servers = [ "127.0.0.1#8053" "0::1#8053" ];
    extraConfig = ''
      no-resolv
      proxy-dnssec
    '';
  };
}

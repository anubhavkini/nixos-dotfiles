{ config, ... }:

{
  # Configure systemd-networkd
  systemd.network = {
    enable = true;

    networks = {
      "40-wired" = {
        enable = true;
        name = "en*";
        DHCP = "yes";
        dhcpV4Config.UseDNS = false;
        dhcpV6Config.UseDNS = false;
      };

      "40-wireless" = {
        enable = true;
        name = "wl*";
        DHCP = "yes";
        dhcpV4Config.UseDNS = false;
        dhcpV6Config.UseDNS = false;
      };
    };
  };

  systemd.services."systemd-networkd-wait-online".serviceConfig.ExecStart = [
    "${config.systemd.package}/lib/systemd/systemd-networkd-wait-online --any"
  ];
}

{ ... }:

{
  imports = [
    ./networkd
  ];

  networking = {
    useDHCP = false;
    dhcpcd.enable = false;
    resolvconf.enable = false;
    enableIPv6 = false;
    useNetworkd = true;
    wireless.dbusControlled = false;
    wireless.iwd.enable = true;
  };

  environment.etc."resolv.conf".enable = false;
}

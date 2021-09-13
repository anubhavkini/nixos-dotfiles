{ config, pkgs, ... }:

let
  # Script to send notification to all active sessions.
  notify-all = pkgs.writeScriptBin "notify-all" ''
    #!${config.environment.binsh}
    session_list=$(${pkgs.procps}/bin/ps -eo user,pid,args | ${pkgs.gnugrep}/bin/grep "dbus-daemon.*--session.*--address=" | ${pkgs.gnugrep}/bin/grep -v grep | sed -r "s'[[:blank:]]+','g")
    for session in $session_list; do
      user="$(echo "$session" | ${pkgs.coreutils}/bin/cut -d',' -f 1)"
      pid="$(echo "$session" | ${pkgs.coreutils}/bin/cut -d',' -f 2)"
      bus_addr="$(${pkgs.gnugrep}/bin/grep -z DBUS_SESSION_BUS_ADDRESS /proc/"$pid"/environ)"
      ${config.environment.binsh} -c "$bus_addr ${pkgs.su}/bin/su $user -c '${pkgs.libnotify}/bin/notify-send $@'"
    done
  '';

in {
  environment.systemPackages = [ notify-all pkgs.libnotify ];

  # Battery threshold notifications and auto-suspend.
  services.udev.extraRules = ''
    # Laptop battery.
    SUBSYSTEM=="power_supply", ATTR{status}=="Full", RUN+="${notify-all}/bin/notify-all 'Battery Full'"
    SUBSYSTEM=="power_supply", ATTR{status}=="Charging", ATTR{capacity}=="[8-9][0-9]", RUN+="${notify-all}/bin/notify-all 'Disconnect Charger'"
    SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-3][0-9]|40", RUN+="${notify-all}/bin/notify-all 'Connect Charger'"
    SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-2][0-9]|3[0-5]", RUN+="${pkgs.systemd}/bin/systemctl hibernate"
  '';
}

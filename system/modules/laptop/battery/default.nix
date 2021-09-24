{ config, pkgs, ... }:

let
  # Script to send notification to all active sessions.
  notify-bat = pkgs.writeScriptBin "notify-bat" ''
    #!${config.environment.binsh}
    session_list=$(${pkgs.procps}/bin/ps -eo user,pid,args | ${pkgs.gnugrep}/bin/grep "dbus-daemon.*--session.*--address=" | ${pkgs.gnugrep}/bin/grep -v grep | sed -r "s'[[:blank:]]+','g")
    for session in $session_list; do
      user="$(echo "$session" | ${pkgs.coreutils}/bin/cut -d',' -f 1)"
      pid="$(echo "$session" | ${pkgs.coreutils}/bin/cut -d',' -f 2)"
      bus_addr="$(${pkgs.gnugrep}/bin/grep -z DBUS_SESSION_BUS_ADDRESS /proc/"$pid"/environ)"
      ${config.environment.binsh} -c "$bus_addr ${pkgs.su}/bin/su $user -c '${pkgs.libnotify}/bin/notify-send -h string:x-canonical-private-synchronous:bat $@'"
    done
  '';

in {
  environment.systemPackages = [ notify-bat pkgs.libnotify ];

  # Battery threshold notifications and auto-suspend.
  services.udev.extraRules = ''
    # Laptop battery.
    SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${notify-bat}/bin/notify-bat 'Charger\ Disconnected'"
    SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${notify-bat}/bin/notify-bat 'Charger\ Connected'"
    SUBSYSTEM=="power_supply", ATTR{status}=="Full", RUN+="${notify-bat}/bin/notify-bat 'Disconnect\ Charger Battery\ Full'"
    SUBSYSTEM=="power_supply", ATTR{status}=="Charging", ATTR{capacity}=="[8-9][0-9]", RUN+="${notify-bat}/bin/notify-bat 'Disconnect\ Charger Battery\ High'"
    SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-3][0-9]|40", RUN+="${notify-bat}/bin/notify-bat 'Connect\ Charger Battery\ Low'"
    SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-9]|10", RUN+="${notify-bat}/bin/notify-bat 'Hibernating\ System Battery\ Low'"
    SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-9]|10", RUN+="${pkgs.systemd}/bin/systemctl hibernate"
  '';
}

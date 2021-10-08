{ pkgs, ... }:

{
  systemd.user.timers."20-20-20" = {
    Unit.Description = "Prevent eye strain";
    Unit.PartOf = [ "graphical-session.target" ];
    Timer.OnActiveSec = 1200;
    Timer.OnUnitInactiveSec = 1200;
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services."20-20-20" = {
    Unit.Description = "Prevent eye strain";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.libnotify}/bin/notify-send -t 20000 20-20-20 'Look Away'";
    };
  };
}

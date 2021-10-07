{ pkgs, ... }:

{
  systemd.user.timers."20-20-20" = {
    Unit.Description = "Prevent eye strain";
    Timer.OnUnitInactiveSec = 1200;
  };

  systemd.user.services."20-20-20" = {
    Unit.Description = "Prevent eye strain";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.libnotify}/bin/notify-send -t 20000 20-20-20 'Look Away'";
    };
  };
}

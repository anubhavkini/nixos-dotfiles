{ config, ... }:

{
  # systemd service.
  systemd.user.services.firefox-autostart = {
    User = {
      Description = "Open-Source Web Browser";
      Documentation = [ "man:firefox(1)" ];
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      Requires = [ "graphical-session.target" ];
    };

    Service = {
      Type = "exec";
      ExecStart = ''
        ${config.programs.firefox.package}/bin/firefox
      '';
      Restart = "no";
      Slice = "app.slice";
    };

    Install = {
      WantedBy = [ "xdg-desktop-autostart.target" ];
    };
  };  
}

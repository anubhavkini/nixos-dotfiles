{ pkgs, ... }:

{
  # systemd service.
  systemd.user.services.keepassxc-autostart = {
    User = {
      Description = "Modern Open-Source Password Manager";
      Documentation = [ "man:keepassxc(1)" ];
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      Requires = [ "graphical-session.target" ];
    };

    Service = {
      Type = "exec";
      ExecStart = ''
        ${pkgs.keepassxc}/bin/keepassxc
      '';
      Restart = "no";
      Slice = "app.slice";
    };

    Install = {
      WantedBy = [ "xdg-desktop-autostart.target" ];
    };
  };
}

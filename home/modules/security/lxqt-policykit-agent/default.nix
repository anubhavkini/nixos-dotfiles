{ pkgs, ... }:

{
  home.packages = [ pkgs.lxqt.lxqt-policykit ];

  # Daemon.
  systemd.user.services.policykit = {
    User = {
      Description = "Polkit Authentication Agent";
      Documentation = [ "man:lxqt-policykit-agent(1)" ];
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      Requires = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent
      '';
      Restart = "always";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}

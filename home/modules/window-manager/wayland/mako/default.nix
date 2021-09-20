{ pkgs, ... }:

{
  programs.mako = {
    enable = true;
    anchor = "top-center";
    backgroundColor = "#0F5151FF";
    borderSize = 0;
    font = "source code pro 11";
    iconPath = "~/.nix-profile/share/icons/hicolor";
    margin = null;
    markup = false;
    maxIconSize = 16;
    progressColor = "source #0F5151CC";
    textColor = "#FFFFFFFF";
    extraConfig = ''
      text-alignment=center
    '';
  };

  # Daemon.
  systemd.user.services.mako = {
    Unit = {
      Description = "Lightweight Wayland notification daemon";
      Documentation = [ "man:mako(1)" ];
      After = "graphical-session.target";
      PartOf = "graphical-session.target";
    };

    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecStart = ''
        ${pkgs.mako}/bin/mako
      '';
      ExecReload = "${pkgs.mako}/bin/makoctl reload";
      Restart = "always";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}

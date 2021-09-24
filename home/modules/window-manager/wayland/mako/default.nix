{ pkgs, ... }:

{
  programs.mako = {
    enable = true;
    anchor = "top-center";
    iconPath = "~/.nix-profile/share/icons/hicolor";
    extraConfig = ''
      text-alignment=center

      [mode=silent]
      invisible=1
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

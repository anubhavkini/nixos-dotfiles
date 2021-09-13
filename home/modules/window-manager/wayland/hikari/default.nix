{ lib, pkgs, config, ... }:

{
  # Required packages.
  home.packages = with pkgs; [
    lxqt.lxqt-policykit
    hikari
    fuzzel
    pamixer
    pavucontrol
    playerctl
    wl-clipboard
    xwayland
    xdg-desktop-portal-wlr
  ];

  # Configuration.
  xdg.configFile= {
    "hikari/hikari.con".text = ''
    '';
    "hikari/autostart" = {
      executable = true;
      text = ''
        systemctl --user import-environment; systemctl --user start hikari-session.target
      '';
    };
  };

  # Polkit.
  systemd.user.services.policykit = {
    User = {
      Description = "Polkit Authentication Agent";
      Documentation = [ "man:lxqt-policykit-agent(1)" ];
      PartOf = [ "hikari-session.target" ];
      After = [ "hikari-session.target" ];
      Requires = [ "hikari-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent
      '';
      Restart = "always";
    };
    Install = {
      WantedBy = [ "hikari-session.target" ];
    };
  };

  # Terminal.
  systemd.user.services.foot.Install.WantedBy = [ "hikari-session.target" ];
  systemd.user.services.foot.Unit.After = [ "hikari-session.target" ];
  systemd.user.services.foot.Unit.PartOf = [ "hikari-session.target" ];
  systemd.user.services.foot.Unit.Requires = [ "hikari-session.target" ];
  systemd.user.services.foot.Service.Restart = pkgs.lib.mkForce "always";


  # Notification daemon.
  systemd.user.services.mako = {
    Unit = {
      Description = "Notification Daemon for Wayland";
      Documentation = [ "man:mako(1)" ];
      PartOf = [ "hikari-session.target" ];
      Requires = [ "hikari-session.target" ];
      After = [ "hikari-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.mako}/bin/mako
      '';
      Restart = "always";
    };
    Install = {
      WantedBy = [ "hikari-session.target" ];
    };
  };

  # River systemd integration.
  systemd.user.targets.hikari-session = {
    Unit = {
      Description = "Hikari compositor session";
      Documentation = [ "man:systemd.special(7)" ];
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };

  # Display manager.
  home.file.profile = {
    text = ''
      # If running from tty2 start graphical session
      if test "$(tty)" = '/dev/tty2'; then
        # Wayland environment variables
        export QT_QPA_PLATFORM="wayland-egl"
        export ELM_DISPLAY="wl"
        export MOZ_ENABLE_WAYLAND="1"

        # Start window manager
        exec dbus-run-session ${pkgs.hikari}/bin/hikari -a ${config.xdg.configHome}/hikari/autostart
      fi
    '';
  };
}

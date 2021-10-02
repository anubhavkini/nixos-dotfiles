{ lib, pkgs, config, ... }:

{
  # Required packages.
  home.packages = with pkgs; [
    # compositor
    hikari

    # menu
    fuzzel

    # audio
    pamixer
    pavucontrol

    # media
    playerctl

    # clipboard
    wl-clipboard

    # xwayland
    xwayland

    # desktop portal
    xdg-desktop-portal
    xdg-desktop-portal-wlr
  ];

  # Configuration.
  xdg.configFile= {
    "hikari/hikari.con".text = ''
    '';

    "hikari/session" = {
      executable = true;
      text = ''
        dbus-update-activation-environment --all --systemd; systemctl --user start hikari-session.target
      '';
    };
  };

  # systemd integration.
  systemd.user.targets.hikari-session = {
    Unit = {
      Description = "Hikari compositor session";
      Documentation = [ "man:systemd.special(7)" ];
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" "xdg-desktop-autostart.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };

  # Start hikari on login.
  home.file.profile = {
    text = ''
      # If running from tty2 start graphical session
      if test "$(tty)" = '/dev/tty2'; then
        # Wayland environment variables
        export QT_QPA_PLATFORM="wayland-egl"
        export ELM_DISPLAY="wl"
        export MOZ_ENABLE_WAYLAND="1"
        export XDG_CURRENT_DESKTOP="hikari"

        # Start window manager
        if [ "$DBUS_SESSION_BUS_ADDRESS" ]; then
          exec ${pkgs.hikari}/bin/hikari -a ${config.xdg.configHome}/hikari/session
        else
          exec dbus-run-session ${pkgs.hikari}/bin/hikari -a ${config.xdg.configHome}/hikari/session
        fi
      fi
    '';
  };
}

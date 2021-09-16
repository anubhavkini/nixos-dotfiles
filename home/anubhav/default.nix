{ config, ... }:

{
  imports = [
    ../modules/browser
    ../modules/editor
    ../modules/file-manager
    ../modules/font
    ../modules/media
    ../modules/misc
    ../modules/office
    ../modules/pager
    ../modules/security
    ../modules/shell
    ../modules/sync
    ../modules/terminal
    ../modules/torrent
    ../modules/vcs
  ];

  home = {
    extraOutputsToInstall = [ "*" ];
    sessionVariables.XKB_DEFAULT_OPTIONS = "ctrl:swapcaps";
    stateVersion = "21.11";
  };

  xdg = {
    enable = true;
    systemDirs.data = [ "${config.xdg.dataHome}" ];
    userDirs.enable = true;
  };

  home.file.profile = {
    target = ".profile";
    text = ''
      # Source home-manager session variables
      . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
    '';
  };
}

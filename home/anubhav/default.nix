{ config, ... }:

{
  imports = [
    ../modules/browser
    ../modules/editor
    ../modules/file-manager
    ../modules/media
    ../modules/misc
    ../modules/office
    ../modules/pager
    ../modules/password-manager
    ../modules/shell
    ../modules/terminal
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

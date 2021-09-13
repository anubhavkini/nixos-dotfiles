{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtkGcc;
  };

  services.emacs = {
    enable = true;
    client = {
      enable = true;
      arguments = [ "-c -a ${config.programs.emacs.package}/bin/emacs" ];
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/english" = [ "emacsclient.desktop" "emacs.desktop" ];
      "text/plain" = [ "emacsclient.desktop" "emacs.desktop" ];
      "text/x-makefile" = [ "emacsclient.desktop" "emacs.desktop" ];
      "text/x-c++hdr" = [ "emacsclient.desktop" "emacs.desktop" ];
      "text/x-c++src" = [ "emacsclient.desktop" "emacs.desktop" ];
      "text/x-chdr" = [ "emacsclient.desktop" "emacs.desktop" ];
      "text/x-csrc" = [ "emacsclient.desktop" "emacs.desktop" ];
      "text/x-java" = [ "emacsclient.desktop" "emacs.desktop" ];
      "text/x-moc" = [ "emacsclient.desktop" "emacs.desktop" ];
      "text/x-pascal" = [ "emacsclient.desktop" "emacs.desktop" ];
      "text/x-tcl" = [ "emacsclient.desktop" "emacs.desktop" ];
      "text/x-tex" = [ "emacsclient.desktop" "emacs.desktop" ];
      "application/x-shellscript" = [ "emacsclient.desktop" "emacs.desktop" ];
      "text/x-c" = [ "emacsclient.desktop" "emacs.desktop" ];
      "text/x-c++" = [ "emacsclient.desktop" "emacs.desktop" ];
    };
  };

  home.sessionVariables.EDITOR = "${config.programs.emacs.package}/bin/emacsclient -a ${config.programs.emacs.package}/bin/emacs";
  home.sessionVariables.VISUAL = "${config.programs.emacs.package}/bin/emacsclient -c -a ${config.programs.emacs.package}/bin/emacs";
}

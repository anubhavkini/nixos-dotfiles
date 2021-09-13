{ pkgs, ... }:

{
  home.packages = [ pkgs.less ];

  # Quit if the file can be displayed on the first screen
  home.sessionVariables.PAGER = "${pkgs.less}/bin/less -F";
}

{ pkgs, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        shell = "${pkgs.zsh}/bin/zsh";
        font = "SourceCodePro:Regular:size=7";
        font-bold = "SourceCodePro:Medium:size=7";
        font-italic = "SourceCodePro:Regular:Italic:size=7";
        font-bold-italic = "SourceCodePro:Semibold:Italic:size=7";
      };
      bell = {
        urgent = "yes";
      };
      cursor = {
        style = "bar";
        blink = "yes";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors = {
        background = "0D0D0D";
        foreground = "CCCCCC";
        regular0 = "16161C";
        regular1 = "E95678";
        regular2 = "29D398";
        regular3 = "FAB795";
        regular4 = "26BBD9";
        regular5 = "EE64AE";
        regular6 = "59E3E3";
        regular7 = "FADAD1";
        bright0 = "232530";
        bright1 = "EC6A88";
        bright2 = "3FDAA4";
        bright3 = "FBC3A7";
        bright4 = "3FC6DE";
        bright5 = "F075B7";
        bright6 = "6BE6E6";
        bright7 = "FDF0ED";
      };
    };
  };

  # Launcher for terminal applications
  home.packages = [
    (
      pkgs.writeScriptBin "launch" ''
        #!/bin/sh
        footclient -a $1 $@
      ''
    )
  ];   
}

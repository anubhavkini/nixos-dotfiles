{ ... }:

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
}

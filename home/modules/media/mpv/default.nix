{ ... }:

{
  programs.mpv = {
    enable = true;

    config = {
      # Hardware acceleration.
      hwdec = "auto";
    };
  };
}

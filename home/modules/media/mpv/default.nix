{ ... }:

{
  programs.mpv = {
    enable = true;

    config = {
      # Hardware acceleration.
      hwdec = "auto";
      profile = "gpu-hq";

      # Better audio at fast speeds.
      af = "scaletempo2";

      # eng by default.
      alang = "eng";
      slang = "eng";
      vlang = "eng";

      # Subtitles.
      sub-font-size = "35";
    };
  };
}

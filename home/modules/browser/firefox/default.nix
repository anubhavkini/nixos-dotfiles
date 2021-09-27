{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      clearurls
      cookie-autodelete
      decentraleyes
      keepassxc-browser
      multi-account-containers
      sponsorblock
      terms-of-service-didnt-read
      ublock-origin
    ];

    profiles.default = {
      settings = {
        # Hardware acceleration.
        "media.ffmpeg.vaapi.enabled" = true;
        "media.ffvpx.enabled" = false;
        "media.navigator.mediadatadecoder_vpx_enabled" = true;
        "media.rdd-vpx.enabled" = false;
      };
    };
  };
}

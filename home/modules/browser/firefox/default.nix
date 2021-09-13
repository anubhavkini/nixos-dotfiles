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
      settings = {};
    };
  };
}

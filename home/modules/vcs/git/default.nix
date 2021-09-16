{ config, ... }:

{
  programs.git = {
    enable = true;
  	userName = "Anubhav Kini";
  	userEmail = "anubhavkini@pm.me";
    signing = {
      gpgPath = "${config.programs.gpg.package}/bin/gpg";
      key = "CB79992D";
      signByDefault = true;
    };
  };
}

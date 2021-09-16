{ pkgs, ... }:

{
  # Start KeePassXC as a service.
  systemd.user.services.keepassxc = {
    User = {
      Description = "Modern Open-Source Password Manager";
      Documentation = [ "man:keepassxc(1)" ];
      PartOf = [ "hikari-session.target" ];
      After = [ "hikari-session.target" ];
      Requires = [ "hikari-session.target" ];
    };
    
    Service = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.keepassxc}/bin/keepassxc
      '';
      Restart = "always";
    };
    
    Install = {
      WantedBy = [ "hikari-session.target" ];
    };
  };
}

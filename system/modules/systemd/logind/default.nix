{ ... }:

{
  # Logind.
  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    lidSwitchDocked = "ignore";
    extraConfig = ''
      HandlePowerKey=poweroff
      HandleSuspendKey=suspend-then-hibernate
      HandleHibernateKey=hibernate
      PowerKeyIgnoreInhibited=yes
      SuspendKeyIgnoreInhibited=yes
      HibernateKeyIgnoreInhibited=yes
      LidSwitchIgnoreInhibited=yes
      IdleAction=suspend-then-hibernate
      IdleActionSec=30
    '';
  };
}

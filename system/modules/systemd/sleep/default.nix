{ ... }:

{
  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=yes
    AllowSuspendThenHibernate=yes
    SuspendState=mem standby freeze
    HibernateState=disk
    HibernateMode=platform shutdown
    HibernateDelaySec=3600
  '';
}

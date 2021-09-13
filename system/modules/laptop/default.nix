{ lib, ... }:

{
  imports = [
    ./battery
    ./tlp
  ];
  
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}

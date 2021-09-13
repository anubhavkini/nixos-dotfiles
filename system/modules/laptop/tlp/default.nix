{ ... }:

{
  # Optimize battery life with TLP.
  services.tlp = {
    enable = true;
    
    settings = {
      TLP_ENABLE=1;

      # Always run in battery mode.
      TLP_DEFAULT_MODE="BAT";
      TLP_PERSISTENT_DEFAULT=1;

      CPU_SCALING_GOVERNOR_ON_AC="performance";
      CPU_SCALING_GOVERNOR_ON_BAT="powersave";
      
      CPU_MIN_PERF_ON_AC=0;
      CPU_MAX_PERF_ON_AC=100;
      CPU_MIN_PERF_ON_BAT=0;
      CPU_MAX_PERF_ON_BAT=30;
      
      CPU_BOOST_ON_AC=1;
      CPU_BOOST_ON_BAT=0;

      # Lower values lead to popping sound on suspend or hibernate.
      SOUND_POWER_SAVE_ON_AC=10;
      
      DEVICES_TO_DISABLE_ON_STARTUP="bluetooth wwan";
    };
  };
}

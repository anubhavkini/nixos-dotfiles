{ pkgs, ... }:

{
  # Use dash as /bin/sh instead of bash.
  environment.binsh = "${pkgs.dash}/bin/dash";

  # Use dash as default login shell instead of bash.
  users.defaultUserShell = pkgs.dash;
}

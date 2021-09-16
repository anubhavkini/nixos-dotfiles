{ pkgs, ... }:

# Backup script.
let
  backup-keys = pkgs.writeScriptBin "backup-keys" ''
    #!/bin/sh

    volume_path=$1

    printf "%s\n" "Mounting volume."
    doas ${pkgs.veracrypt}/bin/veracrypt --text --mount --pim "0" --keyfiles "" --protect-hidden "no" $volume_path

    files="
      $GNUPGHOME
      $HOME/Documents/KeePass
    "

    for file in $files; do
      printf "%s\n" "Backing up $file."
      doas ${pkgs.rsync}/bin/rsync -axRS $file $mount_point
    done

    printf "%s\n" "Dismounting volume."
    doas ${pkgs.veracrypt}/bin/veracrypt --text --dismount $volume_path

    printf "%s\n" "Done."
  '';
in {
  home.packages = [ pkgs.veracrypt backup-keys ];
}

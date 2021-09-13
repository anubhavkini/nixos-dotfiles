{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.nnn
    pkgs.trash-cli
    pkgs.file
    pkgs.zip
    pkgs.unzip
    pkgs.atool
#    pkgs.tar
#    pkgs.rar
    pkgs.unrar
    pkgs.archivemount
    pkgs.sshfs
    pkgs.rclone
    pkgs.xdg-utils
  ];

  # Configure trash-cli
  home.sessionVariables.NNN_TRASH = 1;
  home.sessionVariables.trash = "${config.xdg.dataHome}/Trash";

  # Configure archives
  home.sessionVariables.NNN_ARCHIVE = "\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$";

  # Include desktop entry.
  xdg.desktopEntries.nnn = {
    type = "Application";
    name = "nnn";
    comment = "Terminal file manager";
    exec = "nnn -x";
    terminal = true;
    mimeType = [ "inode/directory" ];
    categories = [ "System" "FileTools" "FileManager" "ConsoleOnly" ];
  };
}

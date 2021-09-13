{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      save = 1000;
      size = 1000;
    };
    initExtraFirst = ''
      PROMPT='%(!.%F{1} # %f.%F{2} > %f)'
      PROMPT2='   '
      RPROMPT='%F{5}%~%f'
    '';
    initExtra = ''
      bindkey "^[[3~" delete-char

      function xterm_title_chpwd () {
        print -Pn -- '\e]2;%~\a'
      }

      xterm_title_chpwd

      if [[ "$TERM" == (Eterm*|alacritty*|aterm*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	      add-zsh-hook -Uz chpwd xterm_title_chpwd
      fi
    '';
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
        };
      }
    ];
    shellAliases = {
      ls = "ls --color=auto";
      vpn = "doas protonvpn";
      rm = "trash-put";
    };
  };
}

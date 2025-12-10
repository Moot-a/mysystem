{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";

  # keep whatever is already there, and add:
  programs.zsh = {
    enable = true;
    initContent = ''
        alias ns="sudo nixos-rebuild switch --flake ~/mysystem#moota-desktop"

        # === History ===
        HISTSIZE=100000
        SAVEHIST=$HISTSIZE
        HISTFILE=$HOME/.zsh_history
        setopt HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS APPEND_HISTORY \
            INC_APPEND_HISTORY SHARE_HISTORY EXTENDED_HISTORY CORRECT

        # === Aliases ===
        alias ls='ls --color=auto'
        alias ll='ls -lh'
        alias la='ls -lha'
        alias gs='git status'
        alias gd='git diff'
        alias gl='git pull'
        alias gp='git push'

        # Your custom alias
        alias ns="sudo nixos-rebuild switch --flake ~/mysystem#moota-desktop"

        # === zoxide ===
        eval "$(zoxide init zsh)"

        # === Starship prompt ===
        eval "$(starship init zsh)"
    '';
  };
}
